package Date::Manip::Lang::polish;
# Copyright (c) 1998-2010 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
########################################################################

=pod

=head1 NAME

Date::Manip::Lang::polish - Polish language support.

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
  - o
  - ''
  - u
day_abb: 
  - 
    - po.
  - 
    - wt.
  - 
    - sr.
    - "\x9Cr."
  - 
    - cz.
  - 
    - pi.
  - 
    - so.
  - 
    - ni.
day_char: 
  - 
    - p
  - 
    - w
  - 
    - e
    - "\x9C."
  - 
    - c
  - 
    - p
  - 
    - s
  - 
    - 'n'
day_name: 
  - 
    - poniedzialek
    - "poniedzia\x81\xB3ek"
  - 
    - wtorek
  - 
    - sroda
    - "\x9Croda"
  - 
    - czwartek
  - 
    - piatek
    - "pi\x81\xB9tek"
  - 
    - sobota
  - 
    - niedziela
each: 
  - kazdy
  - "ka\x81\xBFdy"
  - kazdym
  - "ka\x81\xBFdym"
fields: 
  - 
    - rok
    - ''
    - lat
    - lata
    - latach
  - 
    - miesiac
    - "miesi\x81\xB9c"
    - m.
    - m
    - miesiecy
    - "miesi\x81\xEAcy"
    - miesiacu
    - "miesi\x81\xB9cu"
  - 
    - tydzien
    - "tydzie\x81\xF1"
    - ty.
    - tygodniu
  - 
    - dzien
    - "dzie\x81\xF1"
    - d.
    - dni
  - 
    - godzinie
    - ''
    - g.
    - godzina
    - godziny
  - 
    - minuty
    - ''
    - mn.
    - min.
    - minut
  - 
    - sekundy
    - ''
    - s.
    - sekund
last: 
  - ostatni
  - ''
  - ostatna
mode: 
  - 
    - doklandnie
    - "dok\x81\xB3andnie"
    - w przyblizeniu
    - "w przybli\x81\xBFeniu"
    - mniej wiecej
    - "mniej wi\x81\xEAcej"
    - okolo
    - "oko\x81\xB3o"
  - 
    - sluzbowy
    - "s\x81\xB3u\x81\xBFbowy"
    - sluzbowym
    - "s\x81\xB3u\x81\xBFbowym"
month_abb: 
  - 
    - sty.
  - 
    - lut.
  - 
    - mar.
  - 
    - kwi.
  - 
    - maj
  - 
    - cze.
  - 
    - lip.
  - 
    - sie.
  - 
    - wrz.
  - 
    - paz.
    - "pa\x9F."
  - 
    - lis.
  - 
    - gru.
month_name: 
  - 
    - stycznia
  - 
    - luty
  - 
    - marca
  - 
    - kwietnia
  - 
    - maja
  - 
    - czerwca
  - 
    - lipca
  - 
    - sierpnia
  - 
    - wrzesnia
    - "wrze\x9Cnia"
  - 
    - pazdziernika
    - "pa\x9Fdziernika"
  - 
    - listopada
  - 
    - grudnia
nextprev: 
  - 
    - nastepny
    - "nast\x81\xEApny"
    - nastepnym
    - "nast\x81\xEApnym"
    - przyszly
    - "przysz\x81\xB3y"
    - przyszlym
    - "przysz\x81\xB3ym"
  - 
    - zeszly
    - "zesz\x81\xB3y"
    - zeszlym
    - "zesz\x81\xB3ym"
nth: 
  - 
    - 1.
    - ''
    - pierwszego
  - 
    - 2.
    - ''
    - drugiego
  - 
    - 3.
    - ''
    - trzeczego
  - 
    - 4.
    - ''
    - czwartego
  - 
    - 5.
    - ''
    - piatego
    - "pi\x81\xB9tego"
  - 
    - 6.
    - ''
    - szostego
    - "sz\x81\xF3stego"
  - 
    - 7.
    - ''
    - siodmego
    - "si\x81\xF3dmego"
  - 
    - 8.
    - ''
    - osmego
    - "\x81\xF3smego"
  - 
    - 9.
    - ''
    - dziewiatego
    - "dziewi\x81\xB9tego"
  - 
    - 10.
    - ''
    - dziesiatego
    - "dziesi\x81\xB9tego"
  - 
    - 11.
    - ''
    - jedenastego
  - 
    - 12.
    - ''
    - dwunastego
  - 
    - 13.
    - ''
    - trzynastego
  - 
    - 14.
    - ''
    - czternastego
  - 
    - 15.
    - ''
    - pietnastego
    - "pi\x81\xEAtnastego"
  - 
    - 16.
    - ''
    - szestnastego
  - 
    - 17.
    - ''
    - siedemnastego
  - 
    - 18.
    - ''
    - osiemnastego
  - 
    - 19.
    - ''
    - dziewietnastego
  - 
    - 20.
    - ''
    - dwudziestego
  - 
    - 21.
    - ''
    - dwudziestego pierwszego
  - 
    - 22.
    - ''
    - dwudziestego drugiego
  - 
    - 23.
    - ''
    - dwudziestego trzeczego
  - 
    - 24.
    - ''
    - dwudziestego czwartego
  - 
    - 25.
    - ''
    - dwudziestego piatego
    - "dwudziestego pi\x81\xB9tego"
  - 
    - 26.
    - ''
    - dwudziestego szostego
    - "dwudziestego sz\x81\xF3stego"
  - 
    - 27.
    - ''
    - dwudziestego siodmego
    - "dwudziestego si\x81\xF3dmego"
  - 
    - 28.
    - ''
    - dwudziestego osmego
    - "dwudziestego \x81\xF3smego"
  - 
    - 29.
    - ''
    - dwudziestego dziewiatego
    - "dwudziestego dziewi\x81\xB9tego"
  - 
    - 30.
    - ''
    - trzydziestego
  - 
    - 31.
    - ''
    - trzydziestego pierwszego
of: 
  - w
  - ''
  - z
offset_date: 
  dzisaj: 0:0:0:0:0:0:0
  jutro: +0:0:1:0:0:0
  wczoraj: -0:0:1:0:0:0
offset_time: 
  teraz: 0:0:0:0:0:0:0
'on': 
  - na
times: 
  polnoc: 00:00:00
  poludnie: 12:00:00
  "po\x81\xB3udnie": 12:00:00
  "p\x81\xF3\x81\xB3noc": 00:00:00
when: 
  - 
    - temu
  - 
    - za
    - ''
    - later
