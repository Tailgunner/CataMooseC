package Date::Manip::Lang::catalan;
# Copyright (c) 2003-2010 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
########################################################################

=pod

=head1 NAME

Date::Manip::Lang::catalan - Catalan language support.

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
  - a les
  - ''
  - a
  - al
day_abb: 
  - 
    - Dll
  - 
    - Dmt
    - ''
    - Dim
  - 
    - Dmc
    - ''
    - Dic
  - 
    - Dij
  - 
    - Div
  - 
    - Dis
  - 
    - Diu
day_char: 
  - 
    - Dl
    - ''
    - L
  - 
    - Dm
    - ''
    - M
  - 
    - Dc
    - ''
    - X
  - 
    - Dj
    - ''
    - J
  - 
    - Dv
    - ''
    - V
  - 
    - Ds
    - ''
    - S
  - 
    - Du
    - ''
    - U
day_name: 
  - 
    - Dilluns
  - 
    - Dimarts
  - 
    - Dimecres
  - 
    - Dijous
  - 
    - Divendres
  - 
    - Dissabte
  - 
    - Diumenge
each: 
  - cadascuna
  - ''
  - cada
  - cadascun
fields: 
  - 
    - anys
    - ''
    - a
    - an
    - any
  - 
    - mes
    - ''
    - m
    - me
    - ms
  - 
    - setmanes
    - ''
    - s
    - se
    - set
    - setm
    - setmana
  - 
    - dies
    - ''
    - d
    - dia
  - 
    - hores
    - ''
    - h
    - ho
    - hora
  - 
    - minuts
    - ''
    - mn
    - min
    - minut
  - 
    - segons
    - ''
    - s
    - seg
    - segon
last: 
  - darrer
  - "\xFAltim"
  - darrera
  - "\xFAltima"
mode: 
  - 
    - exactament
    - ''
    - approximadament
  - 
    - empresa
month_abb: 
  - 
    - Gen
  - 
    - Feb
  - 
    - Mar
  - 
    - Abr
  - 
    - Mai
  - 
    - Jun
  - 
    - Jul
  - 
    - Ago
  - 
    - Set
  - 
    - Oct
  - 
    - Nov
  - 
    - Des
    - ''
    - Dec
month_name: 
  - 
    - Gener
  - 
    - Febrer
  - 
    - Marc
    - "Mar\xE7"
    - Marc,
  - 
    - Abril
  - 
    - Maig
  - 
    - Juny
  - 
    - Juliol
  - 
    - Agost
  - 
    - Setembre
  - 
    - Octubre
  - 
    - Novembre
  - 
    - Desembre
nextprev: 
  - 
    - proper
  - 
    - passat
    - ''
    - proppassat
    - anterior
nth: 
  - 
    - 1er
    - ''
    - primer
  - 
    - 2n
    - ''
    - segon
  - 
    - 3r
    - ''
    - tercer
  - 
    - 4t
    - ''
    - quart
  - 
    - 5e
    - "5\xE8"
    - cinque
    - "cinqu\xE8"
  - 
    - 6e
    - "6\xE8"
    - sise
    - "sis\xE8"
  - 
    - 7e
    - "7\xE8"
    - sete
    - "set\xE8"
  - 
    - 8e
    - "8\xE8"
    - vuite
    - "vuit\xE8"
  - 
    - 9e
    - "9\xE8"
    - nove
    - "nov\xE8"
  - 
    - 10e
    - "10\xE8"
    - dese
    - "des\xE8"
  - 
    - 11e
    - "11\xE8"
    - onze
    - "onz\xE8"
  - 
    - 12e
    - "12\xE8"
    - dotze
    - "dotz\xE8"
  - 
    - 13e
    - "13\xE8"
    - tretze
    - "tretz\xE8"
  - 
    - 14e
    - "14\xE8"
    - catorze
    - "catorz\xE8"
  - 
    - 15e
    - "15\xE8"
    - quinze
    - "quinz\xE8"
  - 
    - 16e
    - "16\xE8"
    - setze
    - "setz\xE8"
  - 
    - 17e
    - "17\xE8"
    - dissete
    - "disset\xE8"
  - 
    - 18e
    - "18\xE8"
    - divuite
    - "divuit\xE8"
  - 
    - 19e
    - "19\xE8"
    - dinove
    - "dinov\xE8"
  - 
    - 20e
    - "20\xE8"
    - vinte
    - "vint\xE8"
  - 
    - 21e
    - "21\xE8"
    - vint-i-une
    - "vint-i-un\xE8"
  - 
    - 22e
    - "22\xE8"
    - vint-i-dose
    - "vint-i-dos\xE8"
  - 
    - 23e
    - "23\xE8"
    - vint-i-trese
    - "vint-i-tres\xE8"
  - 
    - 24e
    - "24\xE8"
    - vint-i-quatre
    - "vint-i-quatr\xE8"
  - 
    - 25e
    - "25\xE8"
    - vint-i-cinque
    - "vint-i-cinqu\xE8"
  - 
    - 26e
    - "26\xE8"
    - vint-i-sise
    - "vint-i-sis\xE8"
  - 
    - 27e
    - "27\xE8"
    - vint-i-sete
    - "vint-i-set\xE8"
  - 
    - 28e
    - "28\xE8"
    - vint-i-vuite
    - "vint-i-vuit\xE8"
  - 
    - 29e
    - "29\xE8"
    - vint-i-nove
    - "vint-i-nov\xE8"
  - 
    - 30e
    - "30\xE8"
    - trente
    - "trent\xE8"
  - 
    - 31e
    - "31\xE8"
    - trenta-une
    - "trenta-un\xE8"
of: 
  - de
  - ''
  - d'
offset_date: 
  abans d'ahir: -0:0:0:2:0:0:0
  ahir: -0:0:0:1:0:0:0
  "dem\xE0": +0:0:0:1:0:0:0
  "dem\xE0 passat": +0:0:0:2:0:0:0
  idag: 0:0:0:0:0:0:0
offset_time: 
  avui: 0:0:0:0:0:0:0
  ara: 0:0:0:0:0:0:0
'on': 
  - el
times: 
  migdia: 12:00:00
  mitjanit: 00:00:00
when: 
  - 
    - fa
  - 
    - d'aqui a
    - "d'aqu\xED a"
    - mes tard
    - "m\xE9s tard"
