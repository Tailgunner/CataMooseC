package Date::Manip::Lang::italian;
# Copyright (c) 1999-2010 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
########################################################################

=pod

=head1 NAME

Date::Manip::Lang::italian - Italian language support.

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
  - 
    - PM
at: 
  - alle
day_abb: 
  - 
    - Lun
  - 
    - Mar
  - 
    - Mer
  - 
    - Gio
  - 
    - Ven
  - 
    - Sab
  - 
    - Dom
day_char: 
  - 
    - L
  - 
    - Ma
  - 
    - Me
  - 
    - G
  - 
    - V
  - 
    - S
  - 
    - D
day_name: 
  - 
    - Lunedi
    - "Luned\xEC"
  - 
    - Martedi
    - "Marted\xEC"
  - 
    - Mercoledi
    - "Mercoled\xEC"
  - 
    - Giovedi
    - "Gioved\xEC"
  - 
    - Venerdi
    - "Venerd\xEC"
  - 
    - Sabato
  - 
    - Domenica
each: 
  - ogni
fields: 
  - 
    - anni
    - ''
    - anno
    - a
  - 
    - mesi
    - ''
    - mese
    - mes
    - m
  - 
    - settimane
    - ''
    - settimana
    - sett
  - 
    - giorni
    - ''
    - giorno
    - g
  - 
    - ore
    - ''
    - ora
    - h
  - 
    - minuti
    - ''
    - minuto
    - min
  - 
    - secondi
    - ''
    - s
    - secondo
    - sec
last: 
  - ultimo
mode: 
  - 
    - esattamente
    - ''
    - circa
  - 
    - lavorativi
    - ''
    - lavorativo
month_abb: 
  - 
    - Gen
  - 
    - Feb
  - 
    - Mar
  - 
    - Apr
  - 
    - Mag
  - 
    - Giu
  - 
    - Lug
  - 
    - Ago
  - 
    - Set
  - 
    - Ott
  - 
    - Nov
  - 
    - Dic
month_name: 
  - 
    - Gennaio
  - 
    - Febbraio
  - 
    - Marzo
  - 
    - Aprile
  - 
    - Maggio
  - 
    - Giugno
  - 
    - Luglio
  - 
    - Agosto
  - 
    - Settembre
  - 
    - Ottobre
  - 
    - Novembre
  - 
    - Dicembre
nextprev: 
  - 
    - prossimo
  - 
    - ultimo
nth: 
  - 
    - 1mo
    - ''
    - primo
  - 
    - 2do
    - ''
    - secondo
  - 
    - 3zo
    - ''
    - terzo
  - 
    - 4to
    - ''
    - quarto
  - 
    - 5to
    - ''
    - quinto
  - 
    - 6to
    - ''
    - sesto
  - 
    - 7mo
    - ''
    - settimo
  - 
    - 8vo
    - ''
    - ottavo
  - 
    - 9no
    - ''
    - nono
  - 
    - 10mo
    - ''
    - decimo
  - 
    - 11mo
    - ''
    - undicesimo
  - 
    - 12mo
    - ''
    - dodicesimo
  - 
    - 13mo
    - ''
    - tredicesimo
  - 
    - 14mo
    - ''
    - quattordicesimo
  - 
    - 15mo
    - ''
    - quindicesimo
  - 
    - 16mo
    - ''
    - sedicesimo
  - 
    - 17mo
    - ''
    - diciassettesimo
  - 
    - 18mo
    - ''
    - diciottesimo
  - 
    - 19mo
    - ''
    - diciannovesimo
  - 
    - 20mo
    - ''
    - ventesimo
  - 
    - 21mo
    - ''
    - ventunesimo
  - 
    - 22mo
    - ''
    - ventiduesimo
  - 
    - 23mo
    - ''
    - ventitreesimo
  - 
    - 24mo
    - ''
    - ventiquattresimo
  - 
    - 25mo
    - ''
    - venticinquesimo
  - 
    - 26mo
    - ''
    - ventiseiesimo
  - 
    - 27mo
    - ''
    - ventisettesimo
  - 
    - 28mo
    - ''
    - ventottesimo
  - 
    - 29mo
    - ''
    - ventinovesimo
  - 
    - 3mo
    - ''
    - trentesimo
  - 
    - 31mo
    - ''
    - trentunesimo
of: 
  - della
  - ''
  - del
offset_date: 
  domani: +0:0:0:1:0:0:0
  ieri: -0:0:0:1:0:0:0
  oggi: 0:0:0:0:0:0:0
offset_time: 
  adesso: 0:0:0:0:0:0:0
'on': 
  - di
times: 
  mezzanotte: 00:00:00
  mezzogiorno: 12:00:00
when: 
  - 
    - fa
  - 
    - fra
    - ''
    - dopo
