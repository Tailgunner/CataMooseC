package Date::Manip::Lang::romanian;
# Copyright (c) 1999-2010 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
########################################################################

=pod

=head1 NAME

Date::Manip::Lang::romanian - Romanian language support.

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
    - AM
    - ''
    - A.M.
  - 
    - PM
    - ''
    - P.M.
at: 
  - la
day_abb: 
  - 
    - lun
  - 
    - mar
  - 
    - mie
  - 
    - joi
  - 
    - vin
  - 
    - sim
    - "s\xEEm"
  - 
    - dum
day_char: 
  - 
    - L
  - 
    - Ma
  - 
    - Mi
  - 
    - J
  - 
    - V
  - 
    - S
  - 
    - D
day_name: 
  - 
    - luni
  - 
    - marti
    - "mar\xFEi"
  - 
    - miercuri
  - 
    - joi
  - 
    - vineri
  - 
    - simbata
    - "s\xEEmb\xE3t\xE3"
  - 
    - duminica
    - "duminic\xE3"
each: 
  - fiecare
fields: 
  - 
    - ani
    - ''
    - an
    - a
  - 
    - luna
    - "lun\xE3"
    - luni
    - l
  - 
    - saptamini
    - "s\xE3pt\xE3m\xEEni"
    - saptamina
    - "s\xE3pt\xE3m\xEEna"
    - sapt
    - "s\xE3pt"
  - 
    - zile
    - ''
    - zi
    - z
  - 
    - ora
    - "or\xE3"
    - ore
    - h
  - 
    - minute
    - ''
    - min
    - m
  - 
    - secunde
    - ''
    - sec
    - s
last: 
  - ultima
mode: 
  - 
    - exact
    - ''
    - aproximativ
  - 
    - lucratoare
    - "lucr\xE3toare"
    - de lucru
month_abb: 
  - 
    - ian
  - 
    - febr
    - ''
    - feb
  - 
    - mart
  - 
    - apr
  - 
    - mai
  - 
    - iun
  - 
    - iul
  - 
    - aug
  - 
    - sept
  - 
    - oct
  - 
    - nov
  - 
    - dec
month_name: 
  - 
    - ianuarie
  - 
    - februarie
  - 
    - martie
  - 
    - aprilie
  - 
    - mai
  - 
    - iunie
  - 
    - iulie
  - 
    - august
  - 
    - septembrie
  - 
    - octombrie
  - 
    - noiembrie
  - 
    - decembrie
nextprev: 
  - 
    - urmatoarea
    - "urm\xE3toarea"
  - 
    - precedenta
    - ''
    - ultima
nth: 
  - 
    - prima
    - ''
    - prima
    - intii
    - "\xEEnt\xEEi"
  - 
    - a doua
    - ''
    - a doua
    - doi
  - 
    - a 3-a
    - ''
    - a treia
    - trei
  - 
    - a 4-a
    - ''
    - a patra
    - patru
  - 
    - a 5-a
    - ''
    - a cincea
    - cinci
  - 
    - a 6-a
    - ''
    - a sasea
    - "a \xBAasea"
    - sase
    - "\xBAase"
  - 
    - a 7-a
    - ''
    - a saptea
    - "a \xBAaptea"
    - sapte
    - "\xBAapte"
  - 
    - a 8-a
    - ''
    - a opta
    - opt
  - 
    - a 9-a
    - ''
    - a noua
    - noua
    - "nou\xE3"
  - 
    - a 10-a
    - ''
    - a zecea
    - zece
  - 
    - a 11-a
    - ''
    - a unsprezecea
    - unsprezece
  - 
    - a 12-a
    - ''
    - a doisprezecea
    - doisprezece
  - 
    - a 13-a
    - ''
    - a treisprezecea
    - treisprezece
  - 
    - a 14-a
    - ''
    - a patrusprezecea
    - patrusprezece
  - 
    - a 15-a
    - ''
    - a cincisprezecea
    - cincisprezece
  - 
    - a 16-a
    - ''
    - a saiprezecea
    - "a \xBAaiprezecea"
    - saiprezece
    - "\xBAaiprezece"
  - 
    - a 17-a
    - ''
    - a saptesprezecea
    - "a \xBAaptesprezecea"
    - saptesprezece
    - "\xBAaptesprezece"
  - 
    - a 18-a
    - ''
    - a optsprezecea
    - optsprezece
  - 
    - a 19-a
    - ''
    - a nouasprezecea
    - "a nou\xE3sprezecea"
    - nouasprezece
    - "nou\xE3sprezece"
  - 
    - a 20-a
    - ''
    - a douazecea
    - "a dou\xE3zecea"
    - douazeci
    - "dou\xE3zeci"
  - 
    - a 21-a
    - ''
    - a douazecisiuna
    - "a dou\xE3zeci\xBAiuna"
    - douazecisiunu
    - "dou\xE3zeci\xBAiunu"
  - 
    - a 22-a
    - ''
    - a douazecisidoua
    - "a dou\xE3zeci\xBAidoua"
    - douazecisidoi
    - "dou\xE3zeci\xBAidoi"
  - 
    - a 23-a
    - ''
    - a douazecisitreia
    - "a dou\xE3zeci\xBAitreia"
    - douazecisitrei
    - "dou\xE3zeci\xBAitrei"
  - 
    - a 24-a
    - ''
    - a douazecisipatra
    - "a dou\xE3zeci\xBAipatra"
    - douazecisipatru
    - "dou\xE3zecisipatru"
  - 
    - a 25-a
    - ''
    - a douazecisicincea
    - "a dou\xE3zeci\xBAicincea"
    - douazecisicinci
    - "dou\xE3zeci\xBAicinci"
  - 
    - a 26-a
    - ''
    - a douazecisisasea
    - "a dou\xE3zeci\xBAi\xBAasea"
    - douazecisisase
    - "dou\xE3zeci\xBAi\xBAase"
  - 
    - a 27-a
    - ''
    - a douazecisisaptea
    - "a dou\xE3zeci\xBAi\xBAaptea"
    - douazecisisapte
    - "dou\xE3zeci\xBAi\xBAapte"
  - 
    - a 28-a
    - ''
    - a douazecisiopta
    - "a dou\xE3zeci\xBAiopta"
    - douazecisiopt
    - "dou\xE3zeci\xBAiopt"
  - 
    - a 29-a
    - ''
    - a douazecisinoua
    - "a dou\xE3zeci\xBAinoua"
    - douazecisinoua
    - "dou\xE3zeci\xBAinou\xE3"
  - 
    - a 30-a
    - ''
    - a treizecea
    - treizeci
  - 
    - a 31-a
    - ''
    - a treizecisiuna
    - "a treizeci\xBAiuna"
    - treizecisiunu
    - "treizeci\xBAiunu"
of: 
  - din
  - ''
  - in
  - 'n'
offset_date: 
  alaltaieri: -0:0:0:2:0:0:0
  "alalt\xE3ieri": -0:0:0:2:0:0:0
  astazi: 0:0:0:0:0:0:0
  "ast\xE3zi": 0:0:0:0:0:0:0
  azi: 0:0:0:0:0:0:0
  ieri: -0:0:0:1:0:0:0
  miine: +0:0:0:1:0:0:0
  "m\xEEine": +0:0:0:1:0:0:0
  poimiine: +0:0:0:2:0:0:0
  "poim\xEEine": +0:0:0:2:0:0:0
offset_time: 
  acum: 0:0:0:0:0:0:0
'on': 
  - 'on'
times: 
  amiaza: 12:00:00
  "amiaz\xE3": 12:00:00
  miezul noptii: 00:00:00
  "miezul nop\xFEii": 00:00:00
when: 
  - 
    - in urma
    - "\xEEn urm\xE3"
  - 
    - in
    - "\xEEn"
    - mai tirziu
    - "mai t\xEErziu"
