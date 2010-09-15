package Date::Manip::TZ::pamidw00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:37 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::pamidw00 - Support for the Pacific/Midway time zone

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
        [ [1,1,2,0,0,0],[1,1,1,12,10,32],'-11:49:28',[-11,-49,-28],
          'LMT',0,[1901,1,1,11,49,27],[1900,12,31,23,59,59],
          '0001010200:00:00','0001010112:10:32','1901010111:49:27','1900123123:59:59' ],
     ],
   1901 =>
     [
        [ [1901,1,1,11,49,28],[1901,1,1,0,49,28],'-11:00:00',[-11,0,0],
          'NST',0,[1956,6,3,10,59,59],[1956,6,2,23,59,59],
          '1901010111:49:28','1901010100:49:28','1956060310:59:59','1956060223:59:59' ],
     ],
   1956 =>
     [
        [ [1956,6,3,11,0,0],[1956,6,3,1,0,0],'-10:00:00',[-10,0,0],
          'NDT',1,[1956,9,2,9,59,59],[1956,9,1,23,59,59],
          '1956060311:00:00','1956060301:00:00','1956090209:59:59','1956090123:59:59' ],
        [ [1956,9,2,10,0,0],[1956,9,1,23,0,0],'-11:00:00',[-11,0,0],
          'NST',0,[1967,4,1,10,59,59],[1967,3,31,23,59,59],
          '1956090210:00:00','1956090123:00:00','1967040110:59:59','1967033123:59:59' ],
     ],
   1967 =>
     [
        [ [1967,4,1,11,0,0],[1967,4,1,0,0,0],'-11:00:00',[-11,0,0],
          'BST',0,[1983,11,30,10,59,59],[1983,11,29,23,59,59],
          '1967040111:00:00','1967040100:00:00','1983113010:59:59','1983112923:59:59' ],
     ],
   1983 =>
     [
        [ [1983,11,30,11,0,0],[1983,11,30,0,0,0],'-11:00:00',[-11,0,0],
          'SST',0,[9999,12,31,0,0,0],[9999,12,30,13,0,0],
          '1983113011:00:00','1983113000:00:00','9999123100:00:00','9999123013:00:00' ],
     ],
);

%LastRule      = (
);

1;
