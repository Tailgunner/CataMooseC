package Date::Manip::TZ::afnair00;
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

Date::Manip::TZ::afnair00 - Support for the Africa/Nairobi time zone

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
        [ [1,1,2,0,0,0],[1,1,2,2,27,16],'+02:27:16',[2,27,16],
          'LMT',0,[1928,6,30,21,32,43],[1928,6,30,23,59,59],
          '0001010200:00:00','0001010202:27:16','1928063021:32:43','1928063023:59:59' ],
     ],
   1928 =>
     [
        [ [1928,6,30,21,32,44],[1928,7,1,0,32,44],'+03:00:00',[3,0,0],
          'EAT',0,[1929,12,31,20,59,59],[1929,12,31,23,59,59],
          '1928063021:32:44','1928070100:32:44','1929123120:59:59','1929123123:59:59' ],
     ],
   1929 =>
     [
        [ [1929,12,31,21,0,0],[1929,12,31,23,30,0],'+02:30:00',[2,30,0],
          'BEAT',0,[1939,12,31,21,29,59],[1939,12,31,23,59,59],
          '1929123121:00:00','1929123123:30:00','1939123121:29:59','1939123123:59:59' ],
     ],
   1939 =>
     [
        [ [1939,12,31,21,30,0],[1940,1,1,0,14,45],'+02:44:45',[2,44,45],
          'BEAUT',0,[1959,12,31,21,15,14],[1959,12,31,23,59,59],
          '1939123121:30:00','1940010100:14:45','1959123121:15:14','1959123123:59:59' ],
     ],
   1959 =>
     [
        [ [1959,12,31,21,15,15],[1960,1,1,0,15,15],'+03:00:00',[3,0,0],
          'EAT',0,[9999,12,31,0,0,0],[9999,12,31,3,0,0],
          '1959123121:15:15','1960010100:15:15','9999123100:00:00','9999123103:00:00' ],
     ],
);

%LastRule      = (
);

1;
