package Date::Manip::TZ::paguam00;
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

Date::Manip::TZ::paguam00 - Support for the Pacific/Guam time zone

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
        [ [1,1,2,0,0,0],[1,1,1,9,39,0],'-14:21:00',[-14,-21,0],
          'LMT',0,[1844,12,31,14,20,59],[1844,12,30,23,59,59],
          '0001010200:00:00','0001010109:39:00','1844123114:20:59','1844123023:59:59' ],
     ],
   1844 =>
     [
        [ [1844,12,31,14,21,0],[1845,1,1,0,0,0],'+09:39:00',[9,39,0],
          'LMT',0,[1900,12,31,14,20,59],[1900,12,31,23,59,59],
          '1844123114:21:00','1845010100:00:00','1900123114:20:59','1900123123:59:59' ],
     ],
   1900 =>
     [
        [ [1900,12,31,14,21,0],[1901,1,1,0,21,0],'+10:00:00',[10,0,0],
          'GST',0,[2000,12,22,13,59,59],[2000,12,22,23,59,59],
          '1900123114:21:00','1901010100:21:00','2000122213:59:59','2000122223:59:59' ],
     ],
   2000 =>
     [
        [ [2000,12,22,14,0,0],[2000,12,23,0,0,0],'+10:00:00',[10,0,0],
          'ChST',0,[9999,12,31,0,0,0],[9999,12,31,10,0,0],
          '2000122214:00:00','2000122300:00:00','9999123100:00:00','9999123110:00:00' ],
     ],
);

%LastRule      = (
);

1;
