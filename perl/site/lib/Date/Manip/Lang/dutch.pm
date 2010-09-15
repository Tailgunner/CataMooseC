package Date::Manip::Lang::dutch;
# Copyright (c) 1998-2010 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
########################################################################

=pod

=head1 NAME

Date::Manip::Lang::dutch - Dutch language support.

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
    - am
    - ''
    - a.m.
    - vm
    - v.m.
    - voormiddag
    - "'s_ochtends"
    - ochtend
    - "'s_nachts"
    - nacht
  - 
    - pm
    - ''
    - p.m.
    - nm
    - n.m.
    - namiddag
    - "'s_middags"
    - middag
    - "'s_avonds"
    - avond
at: 
  - om
day_abb: 
  - 
    - ma
  - 
    - di
  - 
    - wo
  - 
    - do
  - 
    - vr
  - 
    - zat
    - ''
    - za
  - 
    - zon
    - ''
    - zo
day_char: 
  - 
    - M
  - 
    - D
  - 
    - W
  - 
    - D
  - 
    - V
  - 
    - Za
  - 
    - Zo
day_name: 
  - 
    - maandag
  - 
    - dinsdag
  - 
    - woensdag
  - 
    - donderdag
  - 
    - vrijdag
  - 
    - zaterdag
  - 
    - zondag
each: 
  - elke
  - ''
  - elk
fields: 
  - 
    - jaren
    - ''
    - jaar
    - ja
    - j
  - 
    - maanden
    - ''
    - maand
    - mnd
  - 
    - weken
    - ''
    - week
    - w
  - 
    - dagen
    - ''
    - dag
    - d
  - 
    - uren
    - ''
    - uur
    - u
    - h
  - 
    - minuten
    - ''
    - m
    - minuut
    - min
  - 
    - seconden
    - ''
    - seconde
    - sec
    - s
last: 
  - laatste
mode: 
  - 
    - exact
    - ''
    - precies
    - nauwkeurig
    - ongeveer
    - ong
    - ong.
    - circa
    - ca
    - ca.
  - 
    - werk
    - ''
    - zakelijke
    - zakelijk
month_abb: 
  - 
    - jan
  - 
    - feb
  - 
    - maa
    - ''
    - mrt
  - 
    - apr
  - 
    - mei
  - 
    - jun
  - 
    - jul
  - 
    - aug
  - 
    - sep
  - 
    - oct
    - ''
    - okt
  - 
    - nov
  - 
    - dec
month_name: 
  - 
    - januari
  - 
    - februari
  - 
    - maart
  - 
    - april
  - 
    - mei
  - 
    - juni
  - 
    - juli
  - 
    - augustus
  - 
    - september
  - 
    - oktober
  - 
    - november
  - 
    - december
nextprev: 
  - 
    - volgende
    - ''
    - volgend
  - 
    - voorgaande
    - ''
    - voorgaand
nth: 
  - 
    - 1ste
    - ''
    - eerste
    - een
  - 
    - 2de
    - ''
    - tweede
    - twee
  - 
    - 3de
    - ''
    - derde
    - drie
  - 
    - 4de
    - ''
    - vierde
    - vier
  - 
    - 5de
    - ''
    - vijfde
    - vijf
  - 
    - 6de
    - ''
    - zesde
    - zes
  - 
    - 7de
    - ''
    - zevende
    - zeven
  - 
    - 8ste
    - ''
    - achtste
    - acht
  - 
    - 9de
    - ''
    - negende
    - negen
  - 
    - 10de
    - ''
    - tiende
    - tien
  - 
    - 11de
    - ''
    - elfde
    - elf
  - 
    - 12de
    - ''
    - twaalfde
    - twaalf
  - 
    - 13de
    - ''
    - dertiende
    - dertien
  - 
    - 14de
    - ''
    - veertiende
    - veertien
  - 
    - 15de
    - ''
    - vijftiende
    - vijftien
  - 
    - 16de
    - ''
    - zestiende
    - zestien
  - 
    - 17de
    - ''
    - zeventiende
    - zeventien
  - 
    - 18de
    - ''
    - achttiende
    - achttien
  - 
    - 19de
    - ''
    - negentiende
    - negentien
  - 
    - 20ste
    - ''
    - twintigstetiende
    - twintigtien
  - 
    - 21ste
    - ''
    - eenentwintigstetiende
    - een-en-twintigste
    - eenentwintigtien
    - een-en-twintig
  - 
    - 22ste
    - ''
    - tweeentwintigstetiende
    - twee-en-twintigste
    - tweeentwintigtien
    - twee-en-twintig
  - 
    - 23ste
    - ''
    - drieentwintigstetiende
    - drie-en-twintigste
    - drieentwintigtien
    - drie-en-twintig
  - 
    - 24ste
    - ''
    - vierentwintigstetiende
    - vier-en-twintigste
    - vierentwintigtien
    - vier-en-twintig
  - 
    - 25ste
    - ''
    - vijfentwintigstetiende
    - vijf-en-twintigste
    - vijfentwintigtien
    - vijf-en-twintig
  - 
    - 26ste
    - ''
    - zesentwintigstetiende
    - zes-en-twintigste
    - zesentwintigtien
    - zes-en-twintig
  - 
    - 27ste
    - ''
    - zevenentwintigstetiende
    - zeven-en-twintigste
    - zevenentwintigtien
    - zeven-en-twintig
  - 
    - 28ste
    - ''
    - achtentwintigstetiende
    - acht-en-twintigste
    - achtentwintigtien
    - acht-en-twintig
  - 
    - 29ste
    - ''
    - negenentwintigstetiende
    - negen-en-twintigste
    - negenentwintigtien
    - negen-en-twintig
  - 
    - 30ste
    - ''
    - dertigsteentwintigstetiende
    - dertigste-en-twintigste
    - dertigentwintigtien
    - dertig-en-twintig
  - 
    - 31ste
    - ''
    - eenendertigsteentwintigstetiende
    - een-en-dertigste-en-twintigste
    - eenendertigentwintigtien
    - een-en-dertig-en-twintig
of: 
  - in
  - ''
  - van
offset_date: 
  eergisteren: -0::00:2:0:0:0
  gisteren: -0:0:0:1:0:0:0
  morgen: +0:0:0:1:0:0:0
  overmorgen: +0:0:0:2:0:0:0
  vandaag: 0:0:0:0:0:0:0
offset_time: 
  nou: 0:0:0:0:0:0:0
  nu: 0:0:0:0:0:0:0
'on': 
  - op
sephm: 
  - "[.]"
  - "[uh]"
sepms: 
  - "[.]"
  - "[m]"
times: 
  middernacht: 00:00:00
  noen: 12:00:00
when: 
  - 
    - geleden
    - ''
    - vroeger
    - eerder
  - 
    - over
    - ''
    - later
