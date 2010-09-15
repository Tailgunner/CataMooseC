package Date::Manip::TZ::aspyon00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:18 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::aspyon00 - Support for the Asia/Pyongyang time zone

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
        [ [1,1,2,0,0,0],[1,1,2,8,23,0],'+08:23:00',[8,23,0],
          'LMT',0,[1889,12,31,15,36,59],[1889,12,31,23,59,59],
          '0001010200:00:00','0001010208:23:00','1889123115:36:59','1889123123:59:59' ],
     ],
   1889 =>
     [
        [ [1889,12,31,15,37,0],[1890,1,1,0,7,0],'+08:30:00',[8,30,0],
          'KST',0,[1904,11,30,15,29,59],[1904,11,30,23,59,59],
          '1889123115:37:00','1890010100:07:00','1904113015:29:59','1904113023:59:59' ],
     ],
   1904 =>
     [
        [ [1904,11,30,15,30,0],[1904,12,1,0,30,0],'+09:00:00',[9,0,0],
          'KST',0,[1927,12,31,14,59,59],[1927,12,31,23,59,59],
          '1904113015:30:00','1904120100:30:00','1927123114:59:59','1927123123:59:59' ],
     ],
   1927 =>
     [
        [ [1927,12,31,15,0,0],[1927,12,31,23,30,0],'+08:30:00',[8,30,0],
          'KST',0,[1931,12,31,15,29,59],[1931,12,31,23,59,59],
          '1927123115:00:00','1927123123:30:00','1931123115:29:59','1931123123:59:59' ],
     ],
   1931 =>
     [
        [ [1931,12,31,15,30,0],[1932,1,1,0,30,0],'+09:00:00',[9,0,0],
          'KST',0,[1954,3,20,14,59,59],[1954,3,20,23,59,59],
          '1931123115:30:00','1932010100:30:00','1954032014:59:59','1954032023:59:59' ],
     ],
   1954 =>
     [
        [ [1954,3,20,15,0,0],[1954,3,20,23,0,0],'+08:00:00',[8,0,0],
          'KST',0,[1961,8,9,15,59,59],[1961,8,9,23,59,59],
          '1954032015:00:00','1954032023:00:00','1961080915:59:59','1961080923:59:59' ],
     ],
   1961 =>
     [
        [ [1961,8,9,16,0,0],[1961,8,10,1,0,0],'+09:00:00',[9,0,0],
          'KST',0,[9999,12,31,0,0,0],[9999,12,31,9,0,0],
          '1961080916:00:00','1961081001:00:00','9999123100:00:00','9999123109:00:00' ],
     ],
);

%LastRule      = (
);

1;
