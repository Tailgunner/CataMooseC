package Date::Manip::TZ::afgabo00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:36 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::afgabo00 - Support for the Africa/Gaborone time zone

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
        [ [1,1,2,0,0,0],[1,1,2,1,43,40],'+01:43:40',[1,43,40],
          'LMT',0,[1884,12,31,22,16,19],[1884,12,31,23,59,59],
          '0001010200:00:00','0001010201:43:40','1884123122:16:19','1884123123:59:59' ],
     ],
   1884 =>
     [
        [ [1884,12,31,22,16,20],[1885,1,1,0,16,20],'+02:00:00',[2,0,0],
          'CAT',0,[1943,9,18,23,59,59],[1943,9,19,1,59,59],
          '1884123122:16:20','1885010100:16:20','1943091823:59:59','1943091901:59:59' ],
     ],
   1943 =>
     [
        [ [1943,9,19,0,0,0],[1943,9,19,3,0,0],'+03:00:00',[3,0,0],
          'CAST',1,[1944,3,18,22,59,59],[1944,3,19,1,59,59],
          '1943091900:00:00','1943091903:00:00','1944031822:59:59','1944031901:59:59' ],
     ],
   1944 =>
     [
        [ [1944,3,18,23,0,0],[1944,3,19,1,0,0],'+02:00:00',[2,0,0],
          'CAT',0,[9999,12,31,0,0,0],[9999,12,31,2,0,0],
          '1944031823:00:00','1944031901:00:00','9999123100:00:00','9999123102:00:00' ],
     ],
);

%LastRule      = (
);

1;
