package Date::Manip::TZ::inmahe00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:48 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::inmahe00 - Support for the Indian/Mahe time zone

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
        [ [1,1,2,0,0,0],[1,1,2,3,41,48],'+03:41:48',[3,41,48],
          'LMT',0,[1906,5,31,20,18,11],[1906,5,31,23,59,59],
          '0001010200:00:00','0001010203:41:48','1906053120:18:11','1906053123:59:59' ],
     ],
   1906 =>
     [
        [ [1906,5,31,20,18,12],[1906,6,1,0,18,12],'+04:00:00',[4,0,0],
          'SCT',0,[9999,12,31,0,0,0],[9999,12,31,4,0,0],
          '1906053120:18:12','1906060100:18:12','9999123100:00:00','9999123104:00:00' ],
     ],
);

%LastRule      = (
);

1;
