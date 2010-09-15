package Date::Manip::TZ::andavi00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:40 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::andavi00 - Support for the Antarctica/Davis time zone

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
        [ [1,1,2,0,0,0],[1,1,2,0,0,0],'+00:00:00',[0,0,0],
          'zzz',0,[1957,1,12,23,59,59],[1957,1,12,23,59,59],
          '0001010200:00:00','0001010200:00:00','1957011223:59:59','1957011223:59:59' ],
     ],
   1957 =>
     [
        [ [1957,1,13,0,0,0],[1957,1,13,7,0,0],'+07:00:00',[7,0,0],
          'DAVT',0,[1964,10,31,16,59,59],[1964,10,31,23,59,59],
          '1957011300:00:00','1957011307:00:00','1964103116:59:59','1964103123:59:59' ],
     ],
   1964 =>
     [
        [ [1964,10,31,17,0,0],[1964,10,31,17,0,0],'+00:00:00',[0,0,0],
          'zzz',0,[1969,1,31,23,59,59],[1969,1,31,23,59,59],
          '1964103117:00:00','1964103117:00:00','1969013123:59:59','1969013123:59:59' ],
     ],
   1969 =>
     [
        [ [1969,2,1,0,0,0],[1969,2,1,7,0,0],'+07:00:00',[7,0,0],
          'DAVT',0,[2009,10,17,18,59,59],[2009,10,18,1,59,59],
          '1969020100:00:00','1969020107:00:00','2009101718:59:59','2009101801:59:59' ],
     ],
   2009 =>
     [
        [ [2009,10,17,19,0,0],[2009,10,18,0,0,0],'+05:00:00',[5,0,0],
          'DAVT',0,[2010,3,10,19,59,59],[2010,3,11,0,59,59],
          '2009101719:00:00','2009101800:00:00','2010031019:59:59','2010031100:59:59' ],
     ],
   2010 =>
     [
        [ [2010,3,10,20,0,0],[2010,3,11,3,0,0],'+07:00:00',[7,0,0],
          'DAVT',0,[9999,12,31,0,0,0],[9999,12,31,7,0,0],
          '2010031020:00:00','2010031103:00:00','9999123100:00:00','9999123107:00:00' ],
     ],
);

%LastRule      = (
);

1;
