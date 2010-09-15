package Date::Manip::Lang::spanish;
# Copyright (c) 1998-2010 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
########################################################################

=pod

=head1 NAME

Date::Manip::Lang::spanish - Spanish language support.

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
  - a
day_abb: 
  - 
    - Lun
  - 
    - Mar
  - 
    - Mie
  - 
    - Jue
  - 
    - Vie
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
    - Lunes
  - 
    - Martes
  - 
    - Miercoles
  - 
    - Jueves
  - 
    - Viernes
  - 
    - Sabado
  - 
    - Domingo
each: 
  - cada
fields: 
  - 
    - anos
    - ''
    - a
    - ano
    - ano
    - anos
  - 
    - meses
    - ''
    - m
    - mes
    - mes
  - 
    - semanas
    - ''
    - sem
    - semana
    - semana
  - 
    - dias
    - ''
    - d
    - dia
  - 
    - horas
    - ''
    - hr
    - hrs
    - hora
  - 
    - minutos
    - ''
    - min
    - min
    - minuto
  - 
    - segundos
    - ''
    - s
    - seg
    - segundo
last: 
  - ultimo
mode: 
  - 
    - exactamente
    - ''
    - aproximadamente
  - 
    - laborales
month_abb: 
  - 
    - Ene
  - 
    - Feb
  - 
    - Mar
  - 
    - Abr
  - 
    - May
  - 
    - Jun
  - 
    - Jul
  - 
    - Ago
  - 
    - Sep
  - 
    - Oct
  - 
    - Nov
  - 
    - Dic
month_name: 
  - 
    - Enero
  - 
    - Febrero
  - 
    - Marzo
  - 
    - Abril
  - 
    - Mayo
  - 
    - Junio
  - 
    - Julio
  - 
    - Agosto
  - 
    - Septiembre
  - 
    - Octubre
  - 
    - Noviembre
  - 
    - Diciembre
nextprev: 
  - 
    - siguiente
  - 
    - anterior
nth: 
  - 
    - 1o
    - ''
    - 1a
    - Primero
    - Primera
  - 
    - 2o
    - ''
    - 2a
    - Segundo
    - Segunda
  - 
    - 3o
    - ''
    - 3a
    - Tercero
    - Tercera
  - 
    - 4o
    - ''
    - 4a
    - Cuarto
    - Cuarta
  - 
    - 5o
    - ''
    - 5a
    - Quinto
    - Quinta
  - 
    - 6o
    - ''
    - 6a
    - Sexto
    - Sexta
  - 
    - 7o
    - ''
    - 7a
    - Septimo
    - Septima
  - 
    - 8o
    - ''
    - 8a
    - Octavo
    - Octava
  - 
    - 9o
    - ''
    - 9a
    - Noveno
    - Novena
  - 
    - 10o
    - ''
    - 10a
    - Decimo
    - Decima
  - 
    - 11o
    - ''
    - 11a
    - Decimo Primero
    - Decimo Primera
  - 
    - 12o
    - ''
    - 12a
    - Decimo Segundo
    - Decimo Segunda
  - 
    - 13o
    - ''
    - 13a
    - Decimo Tercero
    - Decimo Tercera
  - 
    - 14o
    - ''
    - 14a
    - Decimo Cuarto
    - Decimo Cuarta
  - 
    - 15o
    - ''
    - 15a
    - Decimo Quinto
    - Decimo Quinta
  - 
    - 16o
    - ''
    - 16a
    - Decimo Sexto
    - Decimo Sexta
  - 
    - 17o
    - ''
    - 17a
    - Decimo Septimo
    - Decimo Septima
  - 
    - 18o
    - ''
    - 18a
    - Decimo Octavo
    - Decimo Octava
  - 
    - 19o
    - ''
    - 19a
    - Decimo Noveno
    - Decimo Novena
  - 
    - 20o
    - ''
    - 20a
    - Vigesimo
    - Vigesima
  - 
    - 21o
    - ''
    - 21a
    - Vigesimo Primero
    - Vigesimo Primera
  - 
    - 22o
    - ''
    - 22a
    - Vigesimo Segundo
    - Vigesimo Segunda
  - 
    - 23o
    - ''
    - 23a
    - Vigesimo Tercero
    - Vigesimo Tercera
  - 
    - 24o
    - ''
    - 24a
    - Vigesimo Cuarto
    - Vigesimo Cuarta
  - 
    - 25o
    - ''
    - 25a
    - Vigesimo Quinto
    - Vigesimo Quinta
  - 
    - 26o
    - ''
    - 26a
    - Vigesimo Sexto
    - Vigesimo Sexta
  - 
    - 27o
    - ''
    - 27a
    - Vigesimo Septimo
    - Vigesimo Septima
  - 
    - 28o
    - ''
    - 28a
    - Vigesimo Octavo
    - Vigesimo Octava
  - 
    - 29o
    - ''
    - 29a
    - Vigesimo Noveno
    - Vigesimo Novena
  - 
    - 30o
    - ''
    - 30a
    - Trigesimo
    - Trigesima
  - 
    - 31o
    - ''
    - 31a
    - Trigesimo Primero
    - Trigesimo Primera
of: 
  - en
  - ''
  - de
offset_date: 
  Hoy: 0:0:0:0:0:0:0
  ayer: -0:0:0:1:0:0:0
  manana: +0:0:0:1:0:0:0
offset_time: 
  Ahora: 0:0:0:0:0:0:0
'on': 
  - el
times: 
  medianoche: 00:00:00
  mediodia: 12:00:00
when: 
  - 
    - hace
  - 
    - en
    - ''
    - later
