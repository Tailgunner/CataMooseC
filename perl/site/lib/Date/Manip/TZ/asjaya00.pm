package Date::Manip::TZ::asjaya00;
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

Date::Manip::TZ::asjaya00 - Support for the Asia/Jayapura time zone

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
        [ [1,1,2,0,0,0],[1,1,2,9,22,48],'+09:22:48',[9,22,48],
          'LMT',0,[1932,10,31,14,37,11],[1932,10,31,23,59,59],
          '0001010200:00:00','0001010209:22:48','1932103114:37:11','1932103123:59:59' ],
     ],
   1932 =>
     [
        [ [1932,10,31,14,37,12],[1932,10,31,23,37,12],'+09:00:00',[9,0,0],
          'EIT',0,[1944,8,31,14,59,59],[1944,8,31,23,59,59],
          '1932103114:37:12','1932103123:37:12','1944083114:59:59','1944083123:59:59' ],
     ],
   1944 =>
     [
        [ [1944,8,31,15,0,0],[1944,9,1,0,30,0],'+09:30:00',[9,30,0],
          'CST',0,[1963,12,31,14,29,59],[1963,12,31,23,59,59],
          '1944083115:00:00','1944090100:30:00','1963123114:29:59','1963123123:59:59' ],
     ],
   1963 =>
     [
        [ [1963,12,31,14,30,0],[1963,12,31,23,30,0],'+09:00:00',[9,0,0],
          'EIT',0,[9999,12,31,0,0,0],[9999,12,31,9,0,0],
          '1963123114:30:00','1963123123:30:00','9999123100:00:00','9999123109:00:00' ],
     ],
);

%LastRule      = (
);

1;
