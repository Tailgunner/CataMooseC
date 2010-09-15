package Date::Manip::TZ::afdaka00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:32 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::afdaka00 - Support for the Africa/Dakar time zone

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
        [ [1,1,2,0,0,0],[1,1,1,22,50,16],'-01:09:44',[-1,-9,-44],
          'LMT',0,[1912,1,1,1,9,43],[1911,12,31,23,59,59],
          '0001010200:00:00','0001010122:50:16','1912010101:09:43','1911123123:59:59' ],
     ],
   1912 =>
     [
        [ [1912,1,1,1,9,44],[1912,1,1,0,9,44],'-01:00:00',[-1,0,0],
          'WAT',0,[1941,6,1,0,59,59],[1941,5,31,23,59,59],
          '1912010101:09:44','1912010100:09:44','1941060100:59:59','1941053123:59:59' ],
     ],
   1941 =>
     [
        [ [1941,6,1,1,0,0],[1941,6,1,1,0,0],'+00:00:00',[0,0,0],
          'GMT',0,[9999,12,31,0,0,0],[9999,12,31,0,0,0],
          '1941060101:00:00','1941060101:00:00','9999123100:00:00','9999123100:00:00' ],
     ],
);

%LastRule      = (
);

1;
