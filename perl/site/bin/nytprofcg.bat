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
#!/usr/bin/perl
#line 15
##########################################################
## This script is part of the Devel::NYTProf distribution
## Released under the same terms as Perl 5.8.0
## See http://search.cpan.org/dist/Devel-NYTProf/
##
##########################################################
# $Id: /mirror/devel-nytprof/bin/nytprofhtml 13295 2009-04-06T20:34:49.946854Z tim.bunce  $
###########################################################
use warnings;
use strict;

use Getopt::Long;

use Devel::NYTProf::Data;


my %opt = (
    file => 'nytprof.out',
    out  => 'nytprof.callgrind',
);

GetOptions( \%opt, qw/file|f=s out|o=s help|h/ )
    or usage();

usage() if $opt{help};


print "Reading $opt{file} ...\n";

my $profile = Devel::NYTProf::Data->new( { filename => $opt{file},
                                           quiet => 1 } );

print "Writing $opt{out} ...\n";

# calltree format specification
# http://kcachegrind.sourceforge.net/cgi-bin/show.cgi/KcacheGrindCalltreeFormat

open my $fh, '>', $opt{out}
    or die "Can't write to $opt{out}: $!\n";

print $fh "events: Ticks".$/;
print $fh $/;


my %callmap;
my $subname_subinfo_map = $profile->subname_subinfo_map;

for my $sub (values %$subname_subinfo_map) {

    my $callers = $sub->caller_fid_line_places;
    next unless ($callers && %$callers);

    my $fi = eval { $sub->fileinfo };

    print $fh 'fl='.( $fi ? $fi->filename : "Unknown").$/;
    print $fh 'fn='.$sub->subname.$/;
    print $fh join(' ',$sub->first_line, int($sub->excl_time * 1_000_000)).$/;
    print $fh $/;

    my @callers;
    while ( my ( $fid, $fid_line_info ) = each %$callers ) {
        for my $line ( keys %$fid_line_info ) {
            my ( $count, $incl_time, $excl_time, undef, undef, undef,
                undef, $calling_subs) = @{ $fid_line_info->{$line} };

            my @subnames = sort keys %$calling_subs;

            ref $_ and $_ = sprintf "%s (merge of %d subs)", $_->[0], scalar @$_
                for @subnames;
            my $subname = (@subnames) ? join( " or ", @subnames ) : "__main";

            my $fi        = $profile->fileinfo_of($fid);
            my $filename  = $fi->filename($fid);
            my $line_desc = "line $line of $filename";

            # chase string eval chain back to a real file
            while ( my ( $outer_fileinfo, $outer_line ) = $fi->outer ) {
                ( $filename, $line ) = ( $outer_fileinfo->filename, $outer_line );
                $line_desc .= sprintf " at line %s of %s", $line, $filename;
                $fi = $outer_fileinfo;
            }

            push @{ $callmap{$subname} }, [ $filename, $line, $sub, $count, $incl_time, $excl_time ];
        }
    }

}

for (keys %callmap) {
    for my $entry (@{$callmap{$_}}) {
        my ($filename, $line, $sub, $count, $incl_time, $excl_time) = @$entry;
        print $fh "fl=$filename$/";
        print $fh 'fn='.$_.$/;
        print $fh "cfl=".(eval { $sub->fileinfo->filename } || 'Unknown').$/;
        print $fh "cfn=".$sub->subname.$/;
        # calls=(Call Count) (Destination position)
        # (Source position) (Inclusive cost of call)
        print $fh "calls=$count ".$sub->first_line.$/;
        print $fh "$line ".int(1_000_000 * $incl_time).$/;
        print $fh $/;
    }
}

sub usage {
    print <<END;
usage: [perl] nytprofcg [opts]
 --file <file>, -f <file>  Specify NYTProf data file [default: nytprof.out]
 --out <file>,  -o <file>  Specify output file [default: nytprof.callgrind]
 --help,        -h         Print this message

This script of part of the Devel::NYTProf distribution.
Released under the same terms as Perl 5.8.0
See http://search.cpan.org/dist/Devel-NYTProf/
END
    exit 1;
}

__END__

=head1 NAME

nytprofcg - Convert an NYTProf profile into Callgrind format

=head1 SYNOPSIS

 $ nytprofcg --file=nytprof.out --out=nytprof.callgrind

 $ nytprofcg    # same as above

=head1 DESCRIPTION

Reads a profile data file generated by Devel::NYTProf and writes out the
subroutine call graph information it contains in Callgrind format.

The output Callgrind file can be loaded into the C<kcachegrind> GUI for
interactive exploration. 

For more information see L<http://kcachegrind.sourceforge.net/html/Home.html>

=cut

__END__
:endofperl
