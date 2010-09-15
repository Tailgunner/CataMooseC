package Date::Manip::TZ::amguat00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:41 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::amguat00 - Support for the America/Guatemala time zone

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
        [ [1,1,2,0,0,0],[1,1,1,17,57,56],'-06:02:04',[-6,-2,-4],
          'LMT',0,[1918,10,5,6,2,3],[1918,10,4,23,59,59],
          '0001010200:00:00','0001010117:57:56','1918100506:02:03','1918100423:59:59' ],
     ],
   1918 =>
     [
        [ [1918,10,5,6,2,4],[1918,10,5,0,2,4],'-06:00:00',[-6,0,0],
          'CST',0,[1973,11,25,5,59,59],[1973,11,24,23,59,59],
          '1918100506:02:04','1918100500:02:04','1973112505:59:59','1973112423:59:59' ],
     ],
   1973 =>
     [
        [ [1973,11,25,6,0,0],[1973,11,25,1,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[1974,2,24,4,59,59],[1974,2,23,23,59,59],
          '1973112506:00:00','1973112501:00:00','1974022404:59:59','1974022323:59:59' ],
     ],
   1974 =>
     [
        [ [1974,2,24,5,0,0],[1974,2,23,23,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[1983,5,21,5,59,59],[1983,5,20,23,59,59],
          '1974022405:00:00','1974022323:00:00','1983052105:59:59','1983052023:59:59' ],
     ],
   1983 =>
     [
        [ [1983,5,21,6,0,0],[1983,5,21,1,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[1983,9,22,4,59,59],[1983,9,21,23,59,59],
          '1983052106:00:00','1983052101:00:00','1983092204:59:59','1983092123:59:59' ],
        [ [1983,9,22,5,0,0],[1983,9,21,23,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[1991,3,23,5,59,59],[1991,3,22,23,59,59],
          '1983092205:00:00','1983092123:00:00','1991032305:59:59','1991032223:59:59' ],
     ],
   1991 =>
     [
        [ [1991,3,23,6,0,0],[1991,3,23,1,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[1991,9,7,4,59,59],[1991,9,6,23,59,59],
          '1991032306:00:00','1991032301:00:00','1991090704:59:59','1991090623:59:59' ],
        [ [1991,9,7,5,0,0],[1991,9,6,23,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2006,4,30,5,59,59],[2006,4,29,23,59,59],
          '1991090705:00:00','1991090623:00:00','2006043005:59:59','2006042923:59:59' ],
     ],
   2006 =>
     [
        [ [2006,4,30,6,0,0],[2006,4,30,1,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2006,10,1,4,59,59],[2006,9,30,23,59,59],
          '2006043006:00:00','2006043001:00:00','2006100104:59:59','2006093023:59:59' ],
        [ [2006,10,1,5,0,0],[2006,9,30,23,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[9999,12,31,0,0,0],[9999,12,30,18,0,0],
          '2006100105:00:00','2006093023:00:00','9999123100:00:00','9999123018:00:00' ],
     ],
);

%LastRule      = (
);

1;
