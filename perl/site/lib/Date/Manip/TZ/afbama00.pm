package Date::Manip::TZ::afbama00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:33 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::afbama00 - Support for the Africa/Bamako time zone

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
        [ [1,1,2,0,0,0],[1,1,1,23,28,0],'-00:32:00',[0,-32,0],
          'LMT',0,[1912,1,1,0,31,59],[1911,12,31,23,59,59],
          '0001010200:00:00','0001010123:28:00','1912010100:31:59','1911123123:59:59' ],
     ],
   1912 =>
     [
        [ [1912,1,1,0,32,0],[1912,1,1,0,32,0],'+00:00:00',[0,0,0],
          'GMT',0,[1934,2,25,23,59,59],[1934,2,25,23,59,59],
          '1912010100:32:00','1912010100:32:00','1934022523:59:59','1934022523:59:59' ],
     ],
   1934 =>
     [
        [ [1934,2,26,0,0,0],[1934,2,25,23,0,0],'-01:00:00',[-1,0,0],
          'WAT',0,[1960,6,20,0,59,59],[1960,6,19,23,59,59],
          '1934022600:00:00','1934022523:00:00','1960062000:59:59','1960061923:59:59' ],
     ],
   1960 =>
     [
        [ [1960,6,20,1,0,0],[1960,6,20,1,0,0],'+00:00:00',[0,0,0],
          'GMT',0,[9999,12,31,0,0,0],[9999,12,31,0,0,0],
          '1960062001:00:00','1960062001:00:00','9999123100:00:00','9999123100:00:00' ],
     ],
);

%LastRule      = (
);

1;
