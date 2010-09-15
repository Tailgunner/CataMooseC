#############################################################################
#
# Apache::Session::Generate::MD5;
# Generates session identifier tokens using MD5
# Copyright(c) 2000, 2001 Jeffrey William Baker (jwbaker@acm.org)
# Distribute under the Perl License
#
############################################################################

package Apache::Session::Generate::MD5;

use strict;
use vars qw($VERSION);
use Digest::MD5;

$VERSION = '2.12';

sub generate {
    my $session = shift;
    my $length = 32;
    
    if (exists $session->{args}->{IDLength}) {
        $length = $session->{args}->{IDLength};
    }
    
    $session->{data}->{_session_id} = 
        substr(Digest::MD5::md5_hex(Digest::MD5::md5_hex(time(). {}. rand(). $$)), 0, $length);
    

}

sub validate {
    #This routine checks to ensure that the session ID is in the form
    #we expect.  This must be called before we start diddling around
    #in the database or the disk.

    my $session = shift;
    
    if ($session->{data}->{_session_id} =~ /^([a-fA-F0-9]+)$/) {
        $session->{data}->{_session_id} = $1;
    } else {
        die "Invalid session ID: ".$session->{data}->{_session_id};
    }
}

1;

=pod

=head1 NAME

Apache::Session::Generate::MD5 - Use MD5 to create random object IDs

=head1 SYNOPSIS

 use Apache::Session::Generate::MD5;

 $id = Apache::Session::Generate::MD5::generate();

=head1 DESCRIPTION

This module fulfills the ID generation interface of Apache::Session.  The
IDs are generated using a two-round MD5 of a random number, the time since the
epoch, the process ID, and the address of an anonymous hash.  The resultant ID
number is highly entropic on Linux and other platforms that have good
random number generators.  You are encouraged to investigate the quality of
your system's random number generator if you are using the generated ID
numbers in a secure environment.

This module can also examine session IDs to ensure that they are, indeed,
session ID numbers and not evil attacks.  The reader is encouraged to 
consider the effect of bogus session ID numbers in a system which uses
these ID numbers to access disks and databases.

This modules takes one argument in the usual Apache::Session style.  The
argument is IDLength, and the value, between 0 and 32, tells this module
where to truncate the session ID.  Without this argument, the session ID will
be 32 hexadecimal characters long, equivalent to a 128-bit key.

=head1 AUTHOR

This module was written by Jeffrey William Baker <jwbaker@acm.org>.

=head1 SEE ALSO

L<Apache::Session>
