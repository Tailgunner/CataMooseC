package Date::Manip::TZ::afmoga00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:22 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::afmoga00 - Support for the Africa/Mogadishu time zone

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
        [ [1,1,2,0,0,0],[1,1,2,3,1,28],'+03:01:28',[3,1,28],
          'LMT',0,[1893,10,31,20,58,31],[1893,10,31,23,59,59],
          '0001010200:00:00','0001010203:01:28','1893103120:58:31','1893103123:59:59' ],
     ],
   1893 =>
     [
        [ [1893,10,31,20,58,32],[1893,10,31,23,58,32],'+03:00:00',[3,0,0],
          'EAT',0,[1930,12,31,20,59,59],[1930,12,31,23,59,59],
          '1893103120:58:32','1893103123:58:32','1930123120:59:59','1930123123:59:59' ],
     ],
   1930 =>
     [
        [ [1930,12,31,21,0,0],[1930,12,31,23,30,0],'+02:30:00',[2,30,0],
          'BEAT',0,[1956,12,31,21,29,59],[1956,12,31,23,59,59],
          '1930123121:00:00','1930123123:30:00','1956123121:29:59','1956123123:59:59' ],
     ],
   1956 =>
     [
        [ [1956,12,31,21,30,0],[1957,1,1,0,30,0],'+03:00:00',[3,0,0],
          'EAT',0,[9999,12,31,0,0,0],[9999,12,31,3,0,0],
          '1956123121:30:00','1957010100:30:00','9999123100:00:00','9999123103:00:00' ],
     ],
);

%LastRule      = (
);

1;
