package Date::Manip::TZ::anmaws00;
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

Date::Manip::TZ::anmaws00 - Support for the Antarctica/Mawson time zone

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
          'zzz',0,[1954,2,12,23,59,59],[1954,2,12,23,59,59],
          '0001010200:00:00','0001010200:00:00','1954021223:59:59','1954021223:59:59' ],
     ],
   1954 =>
     [
        [ [1954,2,13,0,0,0],[1954,2,13,6,0,0],'+06:00:00',[6,0,0],
          'MAWT',0,[2009,10,17,19,59,59],[2009,10,18,1,59,59],
          '1954021300:00:00','1954021306:00:00','2009101719:59:59','2009101801:59:59' ],
     ],
   2009 =>
     [
        [ [2009,10,17,20,0,0],[2009,10,18,1,0,0],'+05:00:00',[5,0,0],
          'MAWT',0,[9999,12,31,0,0,0],[9999,12,31,5,0,0],
          '2009101720:00:00','2009101801:00:00','9999123100:00:00','9999123105:00:00' ],
     ],
);

%LastRule      = (
);

1;
