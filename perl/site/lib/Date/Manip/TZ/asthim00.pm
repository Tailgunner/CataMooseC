package Date::Manip::TZ::asthim00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:38 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::asthim00 - Support for the Asia/Thimphu time zone

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
        [ [1,1,2,0,0,0],[1,1,2,5,58,36],'+05:58:36',[5,58,36],
          'LMT',0,[1947,8,14,18,1,23],[1947,8,14,23,59,59],
          '0001010200:00:00','0001010205:58:36','1947081418:01:23','1947081423:59:59' ],
     ],
   1947 =>
     [
        [ [1947,8,14,18,1,24],[1947,8,14,23,31,24],'+05:30:00',[5,30,0],
          'IST',0,[1987,9,30,18,29,59],[1987,9,30,23,59,59],
          '1947081418:01:24','1947081423:31:24','1987093018:29:59','1987093023:59:59' ],
     ],
   1987 =>
     [
        [ [1987,9,30,18,30,0],[1987,10,1,0,30,0],'+06:00:00',[6,0,0],
          'BTT',0,[9999,12,31,0,0,0],[9999,12,31,6,0,0],
          '1987093018:30:00','1987100100:30:00','9999123100:00:00','9999123106:00:00' ],
     ],
);

%LastRule      = (
);

1;
