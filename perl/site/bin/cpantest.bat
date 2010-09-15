@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
"%~dp0perl.exe" -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
"%~dp0perl.exe" -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!/usr/bin/perl -w
#line 15
# 
# This file is part of Test-Reporter
# 
# This software is copyright (c) 2010 by Authors and Contributors.
# 
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
# 
use 5.006;
use strict;
use warnings;
package main;
our $VERSION = '1.57';
# NAME: cpantest
# ABSTRACT: Report test results of a package retrieved from CPAN

use Cwd;
use Getopt::Long;
use File::Temp;
use Test::Reporter;
use vars qw(
    $Grade $Package $No_comment $Automatic $Comment_text $Comment_file
    %Grades $CC $Report $Tempfile $Subject $Reporter $From $Dump $Perl_version
    $Transport
);

($Tempfile, $Report) = File::Temp::tempfile(UNLINK => 1);
$Reporter      = Test::Reporter->new();
%Grades        = (
    'pass'     => "all tests pass",
    'fail'     => "some tests fail",
    'na'       => "package will not work on this platform",
    'unknown'  => "package did not include tests",
);

&get_opts();
&check_opts();
&set_transport() if $Transport;
&get_comment_file() if $Comment_file;
&set_comment() if not $No_comment;
&start_editor() unless ($No_comment || ($Comment_text and !$Comment_file));
&get_comment() unless $No_comment;
&get_package() if not $Package;
&get_subject();
&get_via();
&get_tested_perl() if $Perl_version;

if ($Dump) {
    my $fh; open($fh, '>-') or die "Can't open STDOUT: $!";
    $Reporter->write($fh);
    print $fh "\n";
} else {
    &confirm_send() if not $Automatic;
    &send();
}

sub usage {
    my ($message) = @_;

    print "Error:  $message\n" if defined $message;
    print "Usage:\n";
    print "  cpantest -g grade [ -nc ] [ -auto ] [ -p package ]\n";
    print "           [ -t text | -f file ] [ -from user\@example.com ]\n";
    print "           [ -perl-version path_to_perl ]\n";
    print "           [ -dump | email-addresses ]\n";
    print "           [ -x transport ]\n";
    print "  -g grade  Indicates the status of the tested package.\n";
    print "            Possible values for grade are:\n";

    for (keys %Grades) {
        printf "              %-10s  %s\n", $_, $Grades{$_};
    }

    print "  -from         Specify the From: address.\n";
    print "  -t            Specify a short comment.\n";
    print "  -f            Specify a file containing comments.\n";
    print "  -p            Specify the name of the distribution tested\n";
    print "                (e.g.: Test-Reporter-1.27).\n";
    print "  -nc           No comment; you will not be prompted to comment on\n";
    print "                the package.\n";
    print "  -auto         Autosubmission (non-interactive); implies -nc.\n";
    print "  -dump         Print the report instead of emailing it.\n";
    print "  -perl-version Specify an alternate perl under which the distribution was tested.\n";
    print "  -x            Specify a transport: Net::SMTP or Mail::Send.\n";

    exit 1;
}

sub get_opts {
    GetOptions(
        'g=s',  \$Grade,
        'p=s',  \$Package,
        'nc',   \$No_comment,
        'auto', \$Automatic,
        't=s',  \$Comment_text,
        'f=s',  \$Comment_file,
        'from=s',  \$From,
        'dump', \$Dump,
        'perl-version=s', \$Perl_version,
        'x=s',  \$Transport,
    ) or usage();

    $CC         = join ' ', @ARGV;
    $No_comment = 1 if ($Automatic && !$Comment_text && !$Comment_file);
    $Reporter->from($From) if $From;
}

sub set_transport {
    $Reporter->transport($Transport);
}

sub check_opts {
    usage("-g <grade> is required")    unless defined $Grade;
    usage("grade `$Grade' is invalid") unless defined $Grades{$Grade};
    usage("-p is required with -auto") if $Automatic and !$Package;
    usage("can't have both -f and -t") if $Comment_text and $Comment_file;
}

sub get_comment_file {
    local $/;
    open FH, $Comment_file or die "Can't open comment file: $!";
    $Comment_text = <FH>;
    close FH or die "Can't close comment file: $!";
}

sub set_comment {
    chomp $Comment_text if $Comment_text;

    my $comment = $Comment_text ?  $Comment_text : '[ insert comments here ]';

    $Reporter->comments($comment);
    print $Tempfile $Reporter->report();
    close $Tempfile;
}

# Given an author identifier (either a CPAN authorname or a proper
# email address), return a proper email address.
sub expand_author {
    my ($author) = @_;

    if ($author =~ /^[-A-Z]+$/) {   # Smells like a CPAN authorname
        eval { require CPAN } or return undef;

        my $cpan_author = CPAN::Shell->expand("Author", $author);

        return eval { $cpan_author->email };
    }
    elsif ($author =~ /^\S+@[a-zA-Z0-9\.-]+$/) {
        return $author;
    }

    return undef;
}

# Prompt for a new value for $label, given $default; return the user's
# selection.
sub prompt {
    my ($label, $default) = @_;

    printf "$label%s", (" [$default]: ");
    my $input = scalar <STDIN>;
    chomp $input;

    return (length $input) ? $input : $default;
}

sub ask_cc {
    my $cc = prompt('CC', 'none');

    return ($cc eq 'none') ? undef : expand_author($cc);
}

sub start_editor {
    my $editor = $ENV{VISUAL} || $ENV{EDITOR} || $ENV{EDIT}
                    || ($^O eq 'VMS'     and "edit/tpu")
                    || ($^O eq 'MSWin32' and "notepad")
                    || 'vi';

    $editor = prompt('Editor', $editor) unless $Automatic;

    die "The editor `$editor' could not be run" if system "$editor $Report";
    die "Empty report; terminated" unless -s $Report > 2;
    $CC ||= ask_cc() unless $Automatic;
}

sub get_comment {
    $Reporter->comments('');

    if ($Comment_text and not $Comment_file) {
        $Reporter->comments($Comment_text);
        return;
    }

    my $comment;
    my $skip = 1;

    open REPORT, $Report or die $!;
    while (<REPORT>) {
        if ($_ =~ /^--$/) {
            $skip = not $skip;
            next;
        }
        next if $skip;
        $comment .= $_;
    }
    close REPORT or die $!;

    chomp $comment if $comment;

    if ($comment and $comment ne '[ insert comments here ]')
    {
        $Reporter->comments($comment);
    }
}

sub get_package {
    $Package = cwd();
    $Package =~ s:.*/::;
    $Package = prompt('Package', $Package);
}

sub get_subject {
    $Reporter->grade($Grade);
    $Reporter->distribution($Package);
    $Subject = $Reporter->subject();
}

sub get_via {
    $Reporter->via("cpantest $VERSION");
}

sub get_tested_perl {
   $Reporter->perl_version($Perl_version);
}

sub confirm_send {
    $Subject = prompt('Subject', $Subject);

    print "\n";
    print "Subject:  $Subject\n";
    print "To:  " . $Reporter->address() . "\n";
    print "Cc:  $CC\n" if defined $CC;

    if (prompt('S)end/I)gnore', 'Ignore') !~ /^[Ss]/) {
        print "Ignoring message.\n";
        exit 1;
    }
}

sub send {
    if (defined $CC) {
        my @recipients = split /\s+/, $CC;
        $Reporter->send(@recipients) || die $Reporter->errstr();
    }
    else {
        $Reporter->send() || die $Reporter->errstr();
    }

    &log() if $ENV{CPANTEST_LOG};
}

sub log {
    open(LOG,">>$ENV{CPANTEST_LOG}") or
        die "Unable to open $ENV{CPANTEST_LOG}";
    my $time = localtime;
    print LOG "$Subject $time\n";
    close(LOG);
}



=pod

=head1 NAME

cpantest - Report test results of a package retrieved from CPAN

=head1 VERSION

version 1.57

=head1 DESCRIPTION

B<cpantest> uniformly posts package test results in support of the
cpan-testers project.  See B<http://www.cpantesters.org/> for details.

=head1 USAGE

    cpantest -g grade [ -nc ] [ -auto ] [ -p package ]
             [ -t text | -f file ] [ email-addresses ]
             [ -x transport ]

=head1 OPTIONS

=over 4

=item -g grade

I<grade> indicates the success or failure of the package's builtin
tests, and is one of:

    grade     meaning
    -----     -------
    pass      all tests included with the package passed
    fail      some tests failed
    na        the package does not work on this platform
    unknown   the package did not include tests

=item -p package

I<package> is the name of the package you are testing.  If you don't
supply a value on the command line, you will be prompted for one.

For example: Test-Reporter-1.27

=item -nc

No comment; you will not be prompted to supply a comment about the
package.

=item -t text

A short comment text line.

=item -f file

A file containing comments; '-' will make it read from STDIN. Note
that an editor will still appear after reading this file.

=item -auto

Autosubmission (non-interactive); you won't be prompted to supply any
information that you didn't provide on the command line.  Implies I<-nc>.

=item email-addresses

A list of additional email addresses that should be cc:'d in this
report (typically, the package's author).

=item perl-version perl

An alternate version of perl on which the distribution was tested.
This option allows reporting on versions of perl for which Test::Reporter
is not installed.

=item -x transport

Specify a transport: Net::SMTP or Mail::Send. This is optional. One will be
chosen for you automatically if not specified. See Test::Reporter docs for
further information.

=back

=head1 AUTHORS

  Adam J. Foxson <afoxson@pobox.com>
  David Golden <dagolden@cpan.org>
  Kirrily "Skud" Robert <skud@cpan.org>
  Ricardo Signes <rjbs@cpan.org>
  Richard Soderberg <rsod@cpan.org>
  Kurt Starsinic <Kurt.Starsinic@isinet.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Authors and Contributors.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


__END__
:endofperl