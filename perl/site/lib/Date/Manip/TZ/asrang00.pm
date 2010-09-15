package Date::Manip::TZ::asrang00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:34 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::asrang00 - Support for the Asia/Rangoon time zone

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
        [ [1,1,2,0,0,0],[1,1,2,6,24,40],'+06:24:40',[6,24,40],
          'LMT',0,[1879,12,31,17,35,19],[1879,12,31,23,59,59],
          '0001010200:00:00','0001010206:24:40','1879123117:35:19','1879123123:59:59' ],
     ],
   1879 =>
     [
        [ [1879,12,31,17,35,20],[1879,12,31,23,59,56],'+06:24:36',[6,24,36],
          'RMT',0,[1919,12,31,17,35,23],[1919,12,31,23,59,59],
          '1879123117:35:20','1879123123:59:56','1919123117:35:23','1919123123:59:59' ],
     ],
   1919 =>
     [
        [ [1919,12,31,17,35,24],[1920,1,1,0,5,24],'+06:30:00',[6,30,0],
          'BURT',0,[1942,4,30,17,29,59],[1942,4,30,23,59,59],
          '1919123117:35:24','1920010100:05:24','1942043017:29:59','1942043023:59:59' ],
     ],
   1942 =>
     [
        [ [1942,4,30,17,30,0],[1942,5,1,2,30,0],'+09:00:00',[9,0,0],
          'JST',0,[1945,5,2,14,59,59],[1945,5,2,23,59,59],
          '1942043017:30:00','1942050102:30:00','1945050214:59:59','1945050223:59:59' ],
     ],
   1945 =>
     [
        [ [1945,5,2,15,0,0],[1945,5,2,21,30,0],'+06:30:00',[6,30,0],
          'MMT',0,[9999,12,31,0,0,0],[9999,12,31,6,30,0],
          '1945050215:00:00','1945050221:30:00','9999123100:00:00','9999123106:30:00' ],
     ],
);

%LastRule      = (
);

1;
