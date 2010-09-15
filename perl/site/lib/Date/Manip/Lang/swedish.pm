package Date::Manip::Lang::swedish;
# Copyright (c) 1996-2010 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
########################################################################

=pod

=head1 NAME

Date::Manip::Lang::swedish - Swedish language support.

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
  - kl
  - ''
  - kl.
  - klockan
day_abb: 
  - 
    - Man
    - "M\xE5n"
  - 
    - Tis
  - 
    - Ons
  - 
    - Tor
  - 
    - Fre
  - 
    - Lor
    - "L\xF6r"
  - 
    - Son
    - "S\xF6n"
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
    - "M\xE5ndag"
  - 
    - Tisdag
  - 
    - Onsdag
  - 
    - Torsdag
  - 
    - Fredag
  - 
    - Lordag
    - "L\xF6rdag"
  - 
    - Sondag
    - "S\xF6ndag"
each: 
  - varje
fields: 
  - 
    - ar
    - "\xE5r"
  - 
    - manader
    - "m\xE5nader"
    - man
    - manad
    - "m\xE5n"
    - "m\xE5nad"
  - 
    - veckor
    - ''
    - v
    - vecka
  - 
    - dagar
    - ''
    - d
    - dag
  - 
    - timmar
    - ''
    - t
    - tim
    - timme
  - 
    - minuter
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
  - forra
  - "f\xF6rra"
  - senaste
mode: 
  - 
    - exakt
    - ''
    - ungefar
    - "ungef\xE4r"
  - 
    - arbetsdag
    - ''
    - arbetsdagar
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
    - Januari
  - 
    - Februari
  - 
    - Mars
  - 
    - April
  - 
    - Maj
  - 
    - Juni
  - 
    - Juli
  - 
    - Augusti
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
    - "n\xE4sta"
  - 
    - forra
    - "f\xF6rra"
nth: 
  - 
    - 1:a
    - ''
    - forsta
    - "f\xF6rsta"
  - 
    - 2:a
    - ''
    - andra
  - 
    - 3:e
    - ''
    - tredje
  - 
    - 4:e
    - ''
    - fjarde
    - "fj\xE4rde"
  - 
    - 5:e
    - ''
    - femte
  - 
    - 6:e
    - ''
    - sjatte
    - "sj\xE4tte"
  - 
    - 7:e
    - ''
    - sjunde
  - 
    - 8:e
    - ''
    - attonde
    - "\xE5ttonde"
  - 
    - 9:e
    - ''
    - nionde
  - 
    - 10:e
    - ''
    - tionde
  - 
    - 11:e
    - ''
    - elfte
  - 
    - 12:e
    - ''
    - tolfte
  - 
    - 13:e
    - ''
    - trettonde
  - 
    - 14:e
    - ''
    - fjortonde
  - 
    - 15:e
    - ''
    - femtonde
  - 
    - 16:e
    - ''
    - sextonde
  - 
    - 17:e
    - ''
    - sjuttonde
  - 
    - 18:e
    - ''
    - artonde
  - 
    - 19:e
    - ''
    - nittonde
  - 
    - 20:e
    - ''
    - tjugonde
  - 
    - 21:a
    - ''
    - tjugoforsta
    - "tjugof\xF6rsta"
  - 
    - 22:a
    - ''
    - tjugoandra
  - 
    - 23:e
    - ''
    - tjugotredje
  - 
    - 24:e
    - ''
    - tjugofjarde
    - "tjugofj\xE4rde"
  - 
    - 25:e
    - ''
    - tjugofemte
  - 
    - 26:e
    - ''
    - tjugosjatte
    - "tjugosj\xE4tte"
  - 
    - 27:e
    - ''
    - tjugosjunde
  - 
    - 28:e
    - ''
    - tjugoattonde
    - "tjugo\xE5ttonde"
  - 
    - 29:e
    - ''
    - tjugonionde
  - 
    - 30:e
    - ''
    - trettionde
  - 
    - 31:a
    - ''
    - trettioforsta
    - "trettiof\xF6rsta"
of: 
  - om
offset_date: 
  idag: 0:0:0:0:0:0:0
  igar: -0:0:0:1:0:0:0
  "ig\xE5r": -0:0:0:1:0:0:0
  imorgon: +0:0:0:1:0:0:0
offset_time: 
  nu: 0:0:0:0:0:0:0
'on': 
  - pa
  - "p\xE5"
sephm:
  - "[.]"
sepms:
  - "[:]"
times: 
  midnatt: 00:00:00
  mitt pa dagen: 12:00:00
  "mitt p\xE5 dagen": 12:00:00
when: 
  - 
    - sedan
  - 
    - om
    - ''
    - senare
