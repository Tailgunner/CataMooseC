package Date::Manip::Lang::index;
# Copyright (c) 2003-2010 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
########################################################################

=pod

=head1 NAME

Date::Manip::Lang::index - An index of languages supported by Date::Manip

=head1 SYNPOSIS

This module is not intended to be used directly. Other Date::Manip
modules will load it as needed.

=cut

require 5.010000;

use strict;
use warnings;

use vars qw($VERSION);
$VERSION='6.11';

use vars qw(%Lang);

# A list of languages, and their module name

%Lang = qw( english     english
            italian     italian
            french      french
            romanian    romanian
            swedish     swedish
            german      german
            dutch       dutch
            nederlands  dutch
            polish      polish
            spanish     spanish
            portuguese  portugue
            russian     russian
            turkish     turkish
            danish      danish
            catalan     catalan
         );

1;
