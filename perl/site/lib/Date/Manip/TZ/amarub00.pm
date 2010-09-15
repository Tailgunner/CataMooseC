package Date::Manip::TZ::amarub00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:45 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::amarub00 - Support for the America/Aruba time zone

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
        [ [1,1,2,0,0,0],[1,1,1,19,19,36],'-04:40:24',[-4,-40,-24],
          'LMT',0,[1912,2,12,4,40,23],[1912,2,11,23,59,59],
          '0001010200:00:00','0001010119:19:36','1912021204:40:23','1912021123:59:59' ],
     ],
   1912 =>
     [
        [ [1912,2,12,4,40,24],[1912,2,12,0,10,24],'-04:30:00',[-4,-30,0],
          'ANT',0,[1965,1,1,4,29,59],[1964,12,31,23,59,59],
          '1912021204:40:24','1912021200:10:24','1965010104:29:59','1964123123:59:59' ],
     ],
   1965 =>
     [
        [ [1965,1,1,4,30,0],[1965,1,1,0,30,0],'-04:00:00',[-4,0,0],
          'AST',0,[9999,12,31,0,0,0],[9999,12,30,20,0,0],
          '1965010104:30:00','1965010100:30:00','9999123100:00:00','9999123020:00:00' ],
     ],
);

%LastRule      = (
);

1;
