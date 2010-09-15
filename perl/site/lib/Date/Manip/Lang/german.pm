package Date::Manip::Lang::german;
# Copyright (c) 1998-2010 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
########################################################################

=pod

=head1 NAME

Date::Manip::Lang::german - German language support.

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
  - um
day_abb:
  -
    - Mo
  -
    - Di
  -
    - Mi
  -
    - Do
  -
    - Fr
  -
    - Sa
  -
    - So
day_char:
  -
    - M
  -
    - Di
  -
    - Mi
  -
    - Do
  -
    - F
  -
    - Sa
  -
    - So
day_name:
  -
    - Montag
  -
    - Dienstag
  -
    - Mittwoch
  -
    - Donnerstag
  -
    - Freitag
  -
    - Samstag
  -
    - Sonntag
each:
  - jeden
fields:
  -
    - Jahren
    - ''
    - j
    - Jahr
    - Jahre
  -
    - Monaten
    - ''
    - m
    - Monat
    - Monate
  -
    - Wochen
    - ''
    - w
    - Woche
  -
    - Tagen
    - ''
    - t
    - Tag
    - Tage
  -
    - Stunden
    - ''
    - h
    - std
    - Stunde
  -
    - Minuten
    - ''
    - min
    - Minute
  -
    - Sekunden
    - ''
    - s
    - sek
    - Sekunde
last:
  - letzten
  - ''
  - letzte
mode:
  -
    - genau
    - ''
    - ungefahr
    - "ungef\xE4hr"
  -
    - Arbeitstag
month_abb:
  -
    - Jan
    - "J\xE4n"
  -
    - Feb
  -
    - Mar
    - "M\xE4r"
  -
    - Apr
  -
    - Mai
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
    - Dez
month_name:
  -
    - Januar
    - "J\xE4nner"
  -
    - Februar
  -
    - Maerz
    - "M\xE4rz"
  -
    - April
  -
    - Mai
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
    - Dezember
nextprev:
  -
    - nachsten
    - "n\xE4chsten"
    - nachste
    - "n\xE4chste"
  -
    - vorherigen
    - ''
    - vorherige
    - letzte
    - letzten
nth:
  -
    - 1.
    - ''
    - erste
    - erster
  -
    - 2.
    - ''
    - zweite
  -
    - 3.
    - ''
    - dritte
  -
    - 4.
    - ''
    - vierte
  -
    - 5.
    - ''
    - funfte
    - "f\xFCnfte"
  -
    - 6.
    - ''
    - sechste
  -
    - 7.
    - ''
    - siebente
  -
    - 8.
    - ''
    - achte
  -
    - 9.
    - ''
    - neunte
  -
    - 10.
    - ''
    - zehnte
  -
    - 11.
    - ''
    - elfte
  -
    - 12.
    - ''
    - zwolfte
    - "zw\xF6lfte"
  -
    - 13.
    - ''
    - dreizehnte
  -
    - 14.
    - ''
    - vierzehnte
  -
    - 15.
    - ''
    - funfzehnte
    - "f\xFCnfzehnte"
  -
    - 16.
    - ''
    - sechzehnte
  -
    - 17.
    - ''
    - siebzehnte
  -
    - 18.
    - ''
    - achtzehnte
  -
    - 19.
    - ''
    - neunzehnte
  -
    - 20.
    - ''
    - zwanzigste
  -
    - 21.
    - ''
    - einundzwanzigste
  -
    - 22.
    - ''
    - zweiundzwanzigste
  -
    - 23.
    - ''
    - dreiundzwanzigste
  -
    - 24.
    - ''
    - vierundzwanzigste
  -
    - 25.
    - ''
    - funfundzwanzigste
    - "f\xFCnfundzwanzigste"
  -
    - 26.
    - ''
    - sechundzwanzigste
  -
    - 27.
    - ''
    - siebundzwanzigste
  -
    - 28.
    - ''
    - achtundzwanzigste
  -
    - 29.
    - ''
    - neunundzwanzigste
  -
    - 30.
    - ''
    - dreibigste
    - "drei\xDFigste"
  -
    - 31.
    - ''
    - einunddreibigste
    - "einunddrei\xDFigste"
of:
  - der
  - ''
  - im
  - des
offset_date:
  gestern: -0:0:0:1:0:0:0
  heute: 0:0:0:0:0:0:0
  morgen: +0:0:0:1:0:0:0
  "\xFCbermorgen": +0:0:0:2:0:0:0
offset_time:
  jetzt: 0:0:0:0:0:0:0
'on':
  - am
times:
  mittag: 12:00:00
  mitternacht: 00:00:00
when:
  -
    - vor
  -
    - in
    - ''
    - spater
    - "sp\xE4ter"
