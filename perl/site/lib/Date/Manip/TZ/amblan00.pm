package Date::Manip::TZ::amblan00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:21 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::amblan00 - Support for the America/Blanc-Sablon time zone

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
        [ [1,1,2,0,0,0],[1,1,1,20,11,32],'-03:48:28',[-3,-48,-28],
          'LMT',0,[1884,1,1,3,48,27],[1883,12,31,23,59,59],
          '0001010200:00:00','0001010120:11:32','1884010103:48:27','1883123123:59:59' ],
     ],
   1884 =>
     [
        [ [1884,1,1,3,48,28],[1883,12,31,23,48,28],'-04:00:00',[-4,0,0],
          'AST',0,[1918,4,14,5,59,59],[1918,4,14,1,59,59],
          '1884010103:48:28','1883123123:48:28','1918041405:59:59','1918041401:59:59' ],
     ],
   1918 =>
     [
        [ [1918,4,14,6,0,0],[1918,4,14,3,0,0],'-03:00:00',[-3,0,0],
          'ADT',1,[1918,10,31,4,59,59],[1918,10,31,1,59,59],
          '1918041406:00:00','1918041403:00:00','1918103104:59:59','1918103101:59:59' ],
        [ [1918,10,31,5,0,0],[1918,10,31,1,0,0],'-04:00:00',[-4,0,0],
          'AST',0,[1942,2,9,5,59,59],[1942,2,9,1,59,59],
          '1918103105:00:00','1918103101:00:00','1942020905:59:59','1942020901:59:59' ],
     ],
   1942 =>
     [
        [ [1942,2,9,6,0,0],[1942,2,9,3,0,0],'-03:00:00',[-3,0,0],
          'AWT',1,[1945,8,14,22,59,59],[1945,8,14,19,59,59],
          '1942020906:00:00','1942020903:00:00','1945081422:59:59','1945081419:59:59' ],
     ],
   1945 =>
     [
        [ [1945,8,14,23,0,0],[1945,8,14,20,0,0],'-03:00:00',[-3,0,0],
          'APT',1,[1945,9,30,4,59,59],[1945,9,30,1,59,59],
          '1945081423:00:00','1945081420:00:00','1945093004:59:59','1945093001:59:59' ],
        [ [1945,9,30,5,0,0],[1945,9,30,1,0,0],'-04:00:00',[-4,0,0],
          'AST',0,[9999,12,31,0,0,0],[9999,12,30,20,0,0],
          '1945093005:00:00','1945093001:00:00','9999123100:00:00','9999123020:00:00' ],
     ],
);

%LastRule      = (
);

1;
