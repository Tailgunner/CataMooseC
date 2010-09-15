package Date::Manip::TZ::amcaym00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:19 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::amcaym00 - Support for the America/Cayman time zone

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
        [ [1,1,2,0,0,0],[1,1,1,18,34,28],'-05:25:32',[-5,-25,-32],
          'LMT',0,[1890,1,1,5,25,31],[1889,12,31,23,59,59],
          '0001010200:00:00','0001010118:34:28','1890010105:25:31','1889123123:59:59' ],
     ],
   1890 =>
     [
        [ [1890,1,1,5,25,32],[1890,1,1,0,18,20],'-05:07:12',[-5,-7,-12],
          'KMT',0,[1912,2,1,5,7,11],[1912,1,31,23,59,59],
          '1890010105:25:32','1890010100:18:20','1912020105:07:11','1912013123:59:59' ],
     ],
   1912 =>
     [
        [ [1912,2,1,5,7,12],[1912,2,1,0,7,12],'-05:00:00',[-5,0,0],
          'EST',0,[9999,12,31,0,0,0],[9999,12,30,19,0,0],
          '1912020105:07:12','1912020100:07:12','9999123100:00:00','9999123019:00:00' ],
     ],
);

%LastRule      = (
);

1;
