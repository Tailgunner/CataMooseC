package Date::Manip::TZ::afaddi00;
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

Date::Manip::TZ::afaddi00 - Support for the Africa/Addis_Ababa time zone

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
        [ [1,1,2,0,0,0],[1,1,2,2,34,48],'+02:34:48',[2,34,48],
          'LMT',0,[1869,12,31,21,25,11],[1869,12,31,23,59,59],
          '0001010200:00:00','0001010202:34:48','1869123121:25:11','1869123123:59:59' ],
     ],
   1869 =>
     [
        [ [1869,12,31,21,25,12],[1870,1,1,0,0,32],'+02:35:20',[2,35,20],
          'ADMT',0,[1936,5,4,21,24,39],[1936,5,4,23,59,59],
          '1869123121:25:12','1870010100:00:32','1936050421:24:39','1936050423:59:59' ],
     ],
   1936 =>
     [
        [ [1936,5,4,21,24,40],[1936,5,5,0,24,40],'+03:00:00',[3,0,0],
          'EAT',0,[9999,12,31,0,0,0],[9999,12,31,3,0,0],
          '1936050421:24:40','1936050500:24:40','9999123100:00:00','9999123103:00:00' ],
     ],
);

%LastRule      = (
);

1;
