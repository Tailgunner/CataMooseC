package Date::Manip::TZ::asaden00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:30 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::asaden00 - Support for the Asia/Aden time zone

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
        [ [1,1,2,0,0,0],[1,1,2,3,0,48],'+03:00:48',[3,0,48],
          'LMT',0,[1949,12,31,20,59,11],[1949,12,31,23,59,59],
          '0001010200:00:00','0001010203:00:48','1949123120:59:11','1949123123:59:59' ],
     ],
   1949 =>
     [
        [ [1949,12,31,20,59,12],[1949,12,31,23,59,12],'+03:00:00',[3,0,0],
          'AST',0,[9999,12,31,0,0,0],[9999,12,31,3,0,0],
          '1949123120:59:12','1949123123:59:12','9999123100:00:00','9999123103:00:00' ],
     ],
);

%LastRule      = (
);

1;
