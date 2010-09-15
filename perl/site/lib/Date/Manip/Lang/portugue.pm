package Date::Manip::Lang::portugue;
# Copyright (c) 1999-2010 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
########################################################################

=pod

=head1 NAME

Date::Manip::Lang::portugue - Portuguese language support.

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
  - as
  - "\xE0s"
day_abb: 
  - 
    - Seg
  - 
    - Ter
  - 
    - Qua
  - 
    - Qui
  - 
    - Sex
  - 
    - Sab
    - "S\xE1b"
  - 
    - Dom
day_char: 
  - 
    - Sg
  - 
    - T
  - 
    - Qa
  - 
    - Qi
  - 
    - Sx
  - 
    - Sb
  - 
    - D
day_name: 
  - 
    - Segunda
  - 
    - Terca
    - "Ter\xE7a"
  - 
    - Quarta
  - 
    - Quinta
  - 
    - Sexta
  - 
    - Sabado
    - "S\xE1bado"
  - 
    - Domingo
each: 
  - cada
fields: 
  - 
    - anos
    - ''
    - ano
    - ans
    - an
    - a
  - 
    - meses
    - ''
    - "m\xEAs"
    - mes
    - m
  - 
    - semanas
    - ''
    - semana
    - sem
    - sems
    - s
  - 
    - dias
    - ''
    - dia
    - d
  - 
    - horas
    - ''
    - hora
    - hr
    - hrs
  - 
    - minutos
    - ''
    - minuto
    - min
    - mn
  - 
    - segundos
    - ''
    - segundo
    - seg
    - sg
last: 
  - ultimo
  - "\xFAltimo"
mode: 
  - 
    - exactamente
    - ''
    - aproximadamente
  - 
    - util
    - ''
    - uteis
month_abb: 
  - 
    - Jan
  - 
    - Fev
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
    - Out
  - 
    - Nov
  - 
    - Dez
month_name: 
  - 
    - Janeiro
  - 
    - Fevereiro
  - 
    - Marco
    - "Mar\xE7o"
  - 
    - Abril
  - 
    - Maio
  - 
    - Junho
  - 
    - Julho
  - 
    - Agosto
  - 
    - Setembro
  - 
    - Outubro
  - 
    - Novembro
  - 
    - Dezembro
nextprev: 
  - 
    - proxima
    - "pr\xF3xima"
    - proximo
    - "pr\xF3ximo"
  - 
    - ultima
    - "\xFAltima"
    - ultimo
    - "\xFAltimo"
nth: 
  - 
    - "1\xBA"
    - ''
    - primeiro
  - 
    - "2\xBA"
    - ''
    - segundo
  - 
    - "3\xBA"
    - ''
    - terceiro
  - 
    - "4\xBA"
    - ''
    - quarto
  - 
    - "5\xBA"
    - ''
    - quinto
  - 
    - "6\xBA"
    - ''
    - sexto
  - 
    - "7\xBA"
    - ''
    - setimo
    - "s\xE9timo"
  - 
    - "8\xBA"
    - ''
    - oitavo
  - 
    - "9\xBA"
    - ''
    - nono
  - 
    - "10\xBA"
    - ''
    - decimo
    - "d\xE9cimo"
  - 
    - "11\xBA"
    - ''
    - decimo primeiro
    - "d\xE9cimo primeiro"
  - 
    - "12\xBA"
    - ''
    - decimo segundo
    - "d\xE9cimo segundo"
  - 
    - "13\xBA"
    - ''
    - decimo terceiro
    - "d\xE9cimo terceiro"
  - 
    - "14\xBA"
    - ''
    - decimo quarto
    - "d\xE9cimo quarto"
  - 
    - "15\xBA"
    - ''
    - decimo quinto
    - "d\xE9cimo quinto"
  - 
    - "16\xBA"
    - ''
    - decimo sexto
    - "d\xE9cimo sexto"
  - 
    - "17\xBA"
    - ''
    - decimo setimo
    - "d\xE9cimo s\xE9timo"
  - 
    - "18\xBA"
    - ''
    - decimo oitavo
    - "d\xE9cimo oitavo"
  - 
    - "19\xBA"
    - ''
    - decimo nono
    - "d\xE9cimo nono"
  - 
    - "20\xBA"
    - ''
    - vigesimo
    - "vig\xE9simo"
  - 
    - "21\xBA"
    - ''
    - vigesimo primeiro
    - "vig\xE9simo primeiro"
  - 
    - "22\xBA"
    - ''
    - vigesimo segundo
    - "vig\xE9simo segundo"
  - 
    - "23\xBA"
    - ''
    - vigesimo terceiro
    - "vig\xE9simo terceiro"
  - 
    - "24\xBA"
    - ''
    - vigesimo quarto
    - "vig\xE9simo quarto"
  - 
    - "25\xBA"
    - ''
    - vigesimo quinto
    - "vig\xE9simo quinto"
  - 
    - "26\xBA"
    - ''
    - vigesimo sexto
    - "vig\xE9simo sexto"
  - 
    - "27\xBA"
    - ''
    - vigesimo setimo
    - "vig\xE9simo s\xE9timo"
  - 
    - "28\xBA"
    - ''
    - vigesimo oitavo
    - "vig\xE9simo oitavo"
  - 
    - "29\xBA"
    - ''
    - vigesimo nono
    - "vig\xE9simo nono"
  - 
    - "30\xBA"
    - ''
    - trigesimo
    - "trig\xE9simo"
  - 
    - "31\xBA"
    - ''
    - trigesimo primeiro
    - "trig\xE9simo primeiro"
of: 
  - da
  - ''
  - do
offset_date: 
  amanha: +0:0:0:1:0:0:0
  "amanh\xE3": +0:0:0:1:0:0:0
  hoje: 0:0:0:0:0:0:0
  ontem: -0:0:0:1:0:0:0
offset_time: 
  agora: 0:0:0:0:0:0:0
'on': 
  - na
  - ''
  - 'no'
times: 
  meia-noite: 00:00:00
  meio-dia: 12:00:00
when: 
  - 
    - a
    - "\xE0"
  - 
    - em
    - ''
    - passadas
    - passados
