package Date::Manip::TZ::ancase00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:21 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::ancase00 - Support for the Antarctica/Casey time zone

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
          'zzz',0,[1968,12,31,23,59,59],[1968,12,31,23,59,59],
          '0001010200:00:00','0001010200:00:00','1968123123:59:59','1968123123:59:59' ],
     ],
   1969 =>
     [
        [ [1969,1,1,0,0,0],[1969,1,1,8,0,0],'+08:00:00',[8,0,0],
          'WST',0,[2009,10,17,17,59,59],[2009,10,18,1,59,59],
          '1969010100:00:00','1969010108:00:00','2009101717:59:59','2009101801:59:59' ],
     ],
   2009 =>
     [
        [ [2009,10,17,18,0,0],[2009,10,18,5,0,0],'+11:00:00',[11,0,0],
          'CAST',0,[2010,3,4,14,59,59],[2010,3,5,1,59,59],
          '2009101718:00:00','2009101805:00:00','2010030414:59:59','2010030501:59:59' ],
     ],
   2010 =>
     [
        [ [2010,3,4,15,0,0],[2010,3,4,23,0,0],'+08:00:00',[8,0,0],
          'WST',0,[9999,12,31,0,0,0],[9999,12,31,8,0,0],
          '2010030415:00:00','2010030423:00:00','9999123100:00:00','9999123108:00:00' ],
     ],
);

%LastRule      = (
);

1;
