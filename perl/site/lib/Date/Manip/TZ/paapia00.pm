package Date::Manip::TZ::paapia00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:43 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::paapia00 - Support for the Pacific/Apia time zone

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
        [ [1,1,2,0,0,0],[1,1,2,12,33,4],'+12:33:04',[12,33,4],
          'LMT',0,[1879,7,4,11,26,55],[1879,7,4,23,59,59],
          '0001010200:00:00','0001010212:33:04','1879070411:26:55','1879070423:59:59' ],
     ],
   1879 =>
     [
        [ [1879,7,4,11,26,56],[1879,7,4,0,0,0],'-11:26:56',[-11,-26,-56],
          'LMT',0,[1911,1,1,11,26,55],[1910,12,31,23,59,59],
          '1879070411:26:56','1879070400:00:00','1911010111:26:55','1910123123:59:59' ],
     ],
   1911 =>
     [
        [ [1911,1,1,11,26,56],[1910,12,31,23,56,56],'-11:30:00',[-11,-30,0],
          'SAMT',0,[1950,1,1,11,29,59],[1949,12,31,23,59,59],
          '1911010111:26:56','1910123123:56:56','1950010111:29:59','1949123123:59:59' ],
     ],
   1950 =>
     [
        [ [1950,1,1,11,30,0],[1950,1,1,0,30,0],'-11:00:00',[-11,0,0],
          'WST',0,[2010,9,26,10,59,59],[2010,9,25,23,59,59],
          '1950010111:30:00','1950010100:30:00','2010092610:59:59','2010092523:59:59' ],
     ],
   2010 =>
     [
        [ [2010,9,26,11,0,0],[2010,9,26,1,0,0],'-10:00:00',[-10,0,0],
          'WSDT',1,[2011,4,3,9,59,59],[2011,4,2,23,59,59],
          '2010092611:00:00','2010092601:00:00','2011040309:59:59','2011040223:59:59' ],
     ],
   2011 =>
     [
        [ [2011,4,3,10,0,0],[2011,4,2,23,0,0],'-11:00:00',[-11,0,0],
          'WST',0,[9999,12,31,0,0,0],[9999,12,30,13,0,0],
          '2011040310:00:00','2011040223:00:00','9999123100:00:00','9999123013:00:00' ],
     ],
);

%LastRule      = (
);

1;
