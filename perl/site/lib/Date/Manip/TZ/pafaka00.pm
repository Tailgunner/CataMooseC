package Date::Manip::TZ::pafaka00;
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

Date::Manip::TZ::pafaka00 - Support for the Pacific/Fakaofo time zone

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
        [ [1,1,2,0,0,0],[1,1,1,12,35,4],'-11:24:56',[-11,-24,-56],
          'LMT',0,[1901,1,1,11,24,55],[1900,12,31,23,59,59],
          '0001010200:00:00','0001010112:35:04','1901010111:24:55','1900123123:59:59' ],
     ],
   1901 =>
     [
        [ [1901,1,1,11,24,56],[1901,1,1,1,24,56],'-10:00:00',[-10,0,0],
          'TKT',0,[9999,12,31,0,0,0],[9999,12,30,14,0,0],
          '1901010111:24:56','1901010101:24:56','9999123100:00:00','9999123014:00:00' ],
     ],
);

%LastRule      = (
);

1;
