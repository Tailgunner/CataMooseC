package Date::Manip::Lang::french;
# Copyright (c) 1996-2010 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
########################################################################

=pod

=head1 NAME

Date::Manip::Lang::french - French language support.

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
    - du matin
  - 
    - du soir
at: 
  - a
  - "\xE1"
day_abb: 
  - 
    - lun
  - 
    - mar
  - 
    - mer
  - 
    - jeu
  - 
    - ven
  - 
    - sam
  - 
    - dim
day_char: 
  - 
    - l
  - 
    - ma
  - 
    - me
  - 
    - j
  - 
    - v
  - 
    - s
  - 
    - d
day_name: 
  - 
    - lundi
  - 
    - mardi
  - 
    - mercredi
  - 
    - jeudi
  - 
    - vendredi
  - 
    - samedi
  - 
    - dimanche
each: 
  - chaque
  - ''
  - tous les
  - toutes les
fields: 
  - 
    - annees
    - "ann\xE9es"
    - an
    - annee
    - ans
    - "ann\xE9e"
  - 
    - mois
    - ''
    - m
  - 
    - semaine
    - ''
    - sem
  - 
    - jours
    - ''
    - j
    - jour
  - 
    - heures
    - ''
    - h
    - heure
  - 
    - minutes
    - ''
    - mn
    - min
    - minute
  - 
    - secondes
    - ''
    - s
    - sec
    - seconde
last: 
  - dernier
mode: 
  - 
    - exactement
    - ''
    - approximativement
  - 
    - professionel
month_abb: 
  - 
    - jan
  - 
    - fev
    - "f\xE9v"
  - 
    - mar
  - 
    - avr
  - 
    - mai
  - 
    - juin
  - 
    - juil
  - 
    - aout
    - "ao\xFBt"
  - 
    - sept
  - 
    - oct
  - 
    - nov
  - 
    - dec
    - "d\xE9c"
month_name: 
  - 
    - janvier
  - 
    - fevrier
    - "f\xE9vrier"
  - 
    - mars
  - 
    - avril
  - 
    - mai
  - 
    - juin
  - 
    - juillet
  - 
    - aout
    - "ao\xFBt"
  - 
    - septembre
  - 
    - octobre
  - 
    - novembre
  - 
    - decembre
    - "d\xE9cembre"
nextprev: 
  - 
    - suivant
  - 
    - precedent
    - "pr\xE9c\xE9dent"
nth: 
  - 
    - 1er
    - ''
    - 1re
    - premier
  - 
    - 2e
    - ''
    - deux
  - 
    - 3e
    - ''
    - trois
  - 
    - 4e
    - ''
    - quatre
  - 
    - 5e
    - ''
    - cinq
  - 
    - 6e
    - ''
    - six
  - 
    - 7e
    - ''
    - sept
  - 
    - 8e
    - ''
    - huit
  - 
    - 9e
    - ''
    - neuf
  - 
    - 10e
    - ''
    - dix
  - 
    - 11e
    - ''
    - onze
  - 
    - 12e
    - ''
    - douze
  - 
    - 13e
    - ''
    - treize
  - 
    - 14e
    - ''
    - quatorze
  - 
    - 15e
    - ''
    - quinze
  - 
    - 16e
    - ''
    - seize
  - 
    - 17e
    - ''
    - dix-sept
  - 
    - 18e
    - ''
    - dix-huit
  - 
    - 19e
    - ''
    - dix-neuf
  - 
    - 20e
    - ''
    - vingt
  - 
    - 21e
    - ''
    - vingt et un
  - 
    - 22e
    - ''
    - vingt-deux
  - 
    - 23e
    - ''
    - vingt-trois
  - 
    - 24e
    - ''
    - vingt-quatre
  - 
    - 25e
    - ''
    - vingt-cinq
  - 
    - 26e
    - ''
    - vingt-six
  - 
    - 27e
    - ''
    - vingt-sept
  - 
    - 28e
    - ''
    - vingt-huit
  - 
    - 29e
    - ''
    - vingt-neuf
  - 
    - 30e
    - ''
    - trente
  - 
    - 31e
    - ''
    - trente et un
of: 
  - de
  - ''
  - en
offset_date: 
  aujourd'hui: 0:0:0:0:0:0:0
  demain: +0:0:0:1:0:0:0
  hier: -0:0:0:1:0:0:0
offset_time: 
  maintenant: 0:0:0:0:0:0:0
'on': 
  - sur
sephm: 
  - "[h]"
sepms: 
  - "[:]"
times: 
  midi: 12:00:00
  minuit: 00:00:00
when: 
  - 
    - il y a
  - 
    - en
    - ''
    - plus tard
