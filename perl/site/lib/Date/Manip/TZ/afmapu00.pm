package Date::Manip::TZ::afmapu00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:42 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::afmapu00 - Support for the Africa/Maputo time zone

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
        [ [1,1,2,0,0,0],[1,1,2,2,10,20],'+02:10:20',[2,10,20],
          'LMT',0,[1903,2,28,21,49,39],[1903,2,28,23,59,59],
          '0001010200:00:00','0001010202:10:20','1903022821:49:39','1903022823:59:59' ],
     ],
   1903 =>
     [
        [ [1903,2,28,21,49,40],[1903,2,28,23,49,40],'+02:00:00',[2,0,0],
          'CAT',0,[9999,12,31,0,0,0],[9999,12,31,2,0,0],
          '1903022821:49:40','1903022823:49:40','9999123100:00:00','9999123102:00:00' ],
     ],
);

%LastRule      = (
);

1;
