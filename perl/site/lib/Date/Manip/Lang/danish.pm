package Date::Manip::Lang::danish;
# Copyright (c) 2001-2010 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
########################################################################

=pod

=head1 NAME

Date::Manip::Lang::danish - Danish language support.

=head1 SYNPOSIS

This module contains a list of words and expressions supporting
the language. It is not intended to be used directly (other
Date::Manip modules will load it as needed).

=cut

require 5.010000;
use YAML::Syck;

use strict;
use warnings;

use vars qw($VERSION);
$VERSION='6.11';

use vars qw($Language);

my @in    = <DATA>;
$Language = Load(join('',@in));

1;
__DATA__
---
ampm:
  -
    - FM
  -
    - EM
at:
  - klokken
  - ''
  - kl
  - kl.
day_abb:
  -
    - Man
  -
    - Tir
  -
    - Ons
  -
    - Tor
  -
    - Fre
  -
    - Lor
    - "L\xF8r"
  -
    - Son
    - "S\xF8n"
day_char:
  -
    - M
  -
    - Ti
  -
    - O
  -
    - To
  -
    - F
  -
    - L
  -
    - S
day_name:
  -
    - Mandag
  -
    - Tirsdag
  -
    - Onsdag
  -
    - Torsdag
  -
    - Fredag
  -
    - Lordag
    - "L\xF8rdag"
  -
    - Sondag
    - "S\xF8ndag"
each:
  - hver
fields:
  -
    - ar
    - "\xE5r"
  -
    - maneder
    - "m\xE5neder"
    - man
    - maned
    - "m\xE5n"
    - "m\xE5ned"
  -
    - uger
    - ''
    - u
    - uge
  -
    - dage
    - ''
    - d
    - dag
  -
    - timer
    - ''
    - t
    - tim
    - time
  -
    - minutter
    - ''
    - m
    - min
    - minut
  -
    - sekunder
    - ''
    - s
    - sek
    - sekund
last:
  - forrige
  - ''
  - sidste
  - nyeste
mode:
  -
    - pracist
    - "pr\xE6cist"
    - circa
  -
    - arbejdsdag
    - ''
    - arbejdsdage
month_abb:
  -
    - Jan
  -
    - Feb
  -
    - Mar
  -
    - Apr
  -
    - Maj
  -
    - Jun
  -
    - Jul
  -
    - Aug
  -
    - Sep
  -
    - Okt
  -
    - Nov
  -
    - Dec
month_name:
  -
    - Januar
  -
    - Februar
  -
    - Marts
  -
    - April
  -
    - Maj
  -
    - Juni
  -
    - Juli
  -
    - August
  -
    - September
  -
    - Oktober
  -
    - November
  -
    - December
nextprev:
  -
    - nasta
    - "n\xE6ste"
  -
    - forrige
nth:
  -
    - 1:e
    - ''
    - forste
    - "f\xF8rste"
  -
    - 2:e
    - ''
    - anden
  -
    - 3:e
    - ''
    - tredie
  -
    - 4:e
    - ''
    - fjerde
  -
    - 5:e
    - ''
    - femte
  -
    - 6:e
    - ''
    - sjette
  -
    - 7:e
    - ''
    - syvende
  -
    - 8:e
    - ''
    - ottende
  -
    - 9:e
    - ''
    - niende
  -
    - 10:e
    - ''
    - tiende
  -
    - 11:e
    - ''
    - elfte
  -
    - 12:e
    - ''
    - tolvte
  -
    - 13:e
    - ''
    - trettende
  -
    - 14:e
    - ''
    - fjortende
  -
    - 15:e
    - ''
    - femtende
  -
    - 16:e
    - ''
    - sekstende
  -
    - 17:e
    - ''
    - syttende
  -
    - 18:e
    - ''
    - attende
  -
    - 19:e
    - ''
    - nittende
  -
    - 20:e
    - ''
    - tyvende
  -
    - 21:e
    - ''
    - enogtyvende
  -
    - 22:e
    - ''
    - toogtyvende
  -
    - 23:e
    - ''
    - treogtyvende
  -
    - 24:e
    - ''
    - fireogtyvende
  -
    - 25:e
    - ''
    - femogtyvende
  -
    - 26:e
    - ''
    - seksogtyvende
  -
    - 27:e
    - ''
    - syvogtyvende
  -
    - 28:e
    - ''
    - otteogtyvende
  -
    - 29:e
    - ''
    - niogtyvende
  -
    - 30:e
    - ''
    - tredivte
  -
    - 31:e
    - ''
    - enogtredivte
of:
  - om
offset_date:
  idag: 0:0:0:0:0:0:0
  igar: -0:0:0:1:0:0:0
  "ig\xE5r": -0:0:0:1:0:0:0
  imorgen: +0:0:0:1:0:0:0
offset_time:
  nu: 0:0:0:0:0:0:0
'on':
  - pa
  - "p\xE5"
sephm:
  - .
sepms:
  - ':'
times:
  midnat: 00:00:00
  midt pa dagen: 12:00:00
  "midt p\xE5 dagen": 12:00:00
when:
  -
    - siden
  -
    - om
    - ''
    - senere
