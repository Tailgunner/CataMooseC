package Date::Manip::TZ::afndja00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:44 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::afndja00 - Support for the Africa/Ndjamena time zone

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
        [ [1,1,2,0,0,0],[1,1,2,1,0,12],'+01:00:12',[1,0,12],
          'LMT',0,[1911,12,31,22,59,47],[1911,12,31,23,59,59],
          '0001010200:00:00','0001010201:00:12','1911123122:59:47','1911123123:59:59' ],
     ],
   1911 =>
     [
        [ [1911,12,31,22,59,48],[1911,12,31,23,59,48],'+01:00:00',[1,0,0],
          'WAT',0,[1979,10,13,22,59,59],[1979,10,13,23,59,59],
          '1911123122:59:48','1911123123:59:48','1979101322:59:59','1979101323:59:59' ],
     ],
   1979 =>
     [
        [ [1979,10,13,23,0,0],[1979,10,14,1,0,0],'+02:00:00',[2,0,0],
          'WAST',1,[1980,3,7,21,59,59],[1980,3,7,23,59,59],
          '1979101323:00:00','1979101401:00:00','1980030721:59:59','1980030723:59:59' ],
     ],
   1980 =>
     [
        [ [1980,3,7,22,0,0],[1980,3,7,23,0,0],'+01:00:00',[1,0,0],
          'WAT',0,[9999,12,31,0,0,0],[9999,12,31,1,0,0],
          '1980030722:00:00','1980030723:00:00','9999123100:00:00','9999123101:00:00' ],
     ],
);

%LastRule      = (
);

1;
