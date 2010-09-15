package Date::Manip::TZ::asho_c00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:24 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::asho_c00 - Support for the Asia/Ho_Chi_Minh time zone

=head1 SYNPOSIS

This module contains data from the Olsen database for the time zone. It
is not intended to be used directly (other Date::Manip modules will
load it as needed).

=cut

use strict;
use warnings;
require 5.010000;

use vars qw(%Dates %LastRule);

use vars qw($VERSION);
$VERSION='6.11';

%Dates         = (
   1    =>
     [
        [ [1,1,2,0,0,0],[1,1,2,7,6,40],'+07:06:40',[7,6,40],
          'LMT',0,[1906,6,8,16,53,19],[1906,6,8,23,59,59],
          '0001010200:00:00','0001010207:06:40','1906060816:53:19','1906060823:59:59' ],
     ],
   1906 =>
     [
        [ [1906,6,8,16,53,20],[1906,6,8,23,59,40],'+07:06:20',[7,6,20],
          'SMT',0,[1911,3,10,16,54,39],[1911,3,11,0,0,59],
          '1906060816:53:20','1906060823:59:40','1911031016:54:39','1911031100:00:59' ],
     ],
   1911 =>
     [
        [ [1911,3,10,16,54,40],[1911,3,10,23,54,40],'+07:00:00',[7,0,0],
          'ICT',0,[1912,4,30,16,59,59],[1912,4,30,23,59,59],
          '1911031016:54:40','1911031023:54:40','1912043016:59:59','1912043023:59:59' ],
     ],
   1912 =>
     [
        [ [1912,4,30,17,0,0],[1912,5,1,1,0,0],'+08:00:00',[8,0,0],
          'ICT',0,[1931,4,30,15,59,59],[1931,4,30,23,59,59],
          '1912043017:00:00','1912050101:00:00','1931043015:59:59','1931043023:59:59' ],
     ],
   1931 =>
     [
        [ [1931,4,30,16,0,0],[1931,4,30,23,0,0],'+07:00:00',[7,0,0],
          'ICT',0,[9999,12,31,0,0,0],[9999,12,31,7,0,0],
          '1931043016:00:00','1931043023:00:00','9999123100:00:00','9999123107:00:00' ],
     ],
);

%LastRule      = (
);

1;
