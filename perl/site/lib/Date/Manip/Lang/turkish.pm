package Date::Manip::Lang::turkish;
# Copyright (c) 2001-2010 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
########################################################################

=pod

=head1 NAME

Date::Manip::Lang::turkish - Turkish language support.

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
    - ogleden once
    - "\xF6gleden \xF6nce"
  - 
    - ogleden sonra
    - "\xF6\xF0leden sonra"
at: 
  - saat
day_abb: 
  - 
    - pzt
  - 
    - sal
  - 
    - car
    - "\xE7ar"
  - 
    - per
  - 
    - cum
  - 
    - cts
  - 
    - paz
day_char: 
  - 
    - Pt
  - 
    - S
  - 
    - Cr
    - "\xC7"
  - 
    - Pr
  - 
    - C
  - 
    - Ct
  - 
    - P
day_name: 
  - 
    - pazartesi
  - 
    - sali
    - "sal\xFD"
  - 
    - carsamba
    - "\xE7ar\xFEamba"
  - 
    - persembe
    - "per\xFEembe"
  - 
    - cuma
  - 
    - cumartesi
  - 
    - pazar
each: 
  - her
fields: 
  - 
    - yil
    - ''
    - 'y'
  - 
    - ay
    - ''
    - a
  - 
    - hafta
    - ''
    - h
  - 
    - gun
    - ''
    - g
  - 
    - saat
    - ''
    - s
  - 
    - dakika
    - ''
    - dak
    - d
  - 
    - saniye
    - ''
    - sn
last: 
  - son
  - ''
  - sonuncu
mode: 
  - 
    - tam
    - ''
    - yaklasik
    - "yakla\xFE\xFDk"
  - 
    - is
    - "i\xFE"
    - "\xE7al\xFD\xFEma"
    - calisma
month_abb: 
  - 
    - oca
  - 
    - sub
    - "\xFEub"
  - 
    - mar
  - 
    - nis
  - 
    - may
  - 
    - haz
  - 
    - tem
  - 
    - agu
    - "a\xF0u"
  - 
    - eyl
  - 
    - eki
  - 
    - kas
  - 
    - ara
month_name: 
  - 
    - ocak
  - 
    - subat
    - "\xFEubat"
  - 
    - mart
  - 
    - nisan
  - 
    - mayis
    - "may\xFDs"
  - 
    - haziran
  - 
    - temmuz
  - 
    - agustos
    - "a\xF0ustos"
  - 
    - eylul
    - "eyl\xFCl"
  - 
    - ekim
  - 
    - kasim
    - "kas\xFDm"
  - 
    - aralik
    - "aral\xFDk"
nextprev: 
  - 
    - gelecek
    - ''
    - sonraki
  - 
    - onceki
    - "\xF6nceki"
nth: 
  - 
    - 1.
    - ''
    - birinci
  - 
    - 2.
    - ''
    - ikinci
  - 
    - 3.
    - ''
    - ucuncu
    - "\xFC\xE7\xFCnc\xFC"
  - 
    - 4.
    - ''
    - dorduncu
    - "d\xF6rd\xFCnc\xFC"
  - 
    - 5.
    - ''
    - besinci
    - "be\xFEinci"
  - 
    - 6.
    - ''
    - altinci
    - "alt\xFDnc\xFD"
  - 
    - 7.
    - ''
    - yedinci
  - 
    - 8.
    - ''
    - sekizinci
  - 
    - 9.
    - ''
    - dokuzuncu
  - 
    - 10.
    - ''
    - onuncu
  - 
    - 11.
    - ''
    - onbirinci
  - 
    - 12.
    - ''
    - onikinci
  - 
    - 13.
    - ''
    - onucuncu
    - "on\xFC\xE7\xFCnc\xFC"
  - 
    - 14.
    - ''
    - ondordoncu
    - "ond\xF6rd\xFCnc\xFC"
  - 
    - 15.
    - ''
    - onbesinci
    - "onbe\xFEinci"
  - 
    - 16.
    - ''
    - onaltinci
    - "onalt\xFDnc\xFD"
  - 
    - 17.
    - ''
    - onyedinci
  - 
    - 18.
    - ''
    - onsekizinci
  - 
    - 19.
    - ''
    - ondokuzuncu
  - 
    - 20.
    - ''
    - yirminci
  - 
    - 21.
    - ''
    - yirmibirinci
  - 
    - 22.
    - ''
    - yirmikinci
  - 
    - 23.
    - ''
    - yirmiucuncu
    - "yirmi\xFC\xE7\xFCnc\xFC"
  - 
    - 24.
    - ''
    - yirmidorduncu
    - "yirmid\xF6rd\xFCnc\xFC"
  - 
    - 25.
    - ''
    - yirmibesinci
    - "yirmibe\xFEinci"
  - 
    - 26.
    - ''
    - yirmialtinci
    - "yirmialt\xFDnc\xFD"
  - 
    - 27.
    - ''
    - yirmiyedinci
  - 
    - 28.
    - ''
    - yirmisekizinci
  - 
    - 29.
    - ''
    - yirmidokuzuncu
  - 
    - 30.
    - ''
    - otuzuncu
  - 
    - 31.
    - ''
    - otuzbirinci
of: 
  - of
offset_date: 
  bugun: 0:0:0:0:0:0:0
  "bug\xFCn": 0:0:0:0:0:0:0
  dun: -0:0:0:1:0:0:0
  "d\xFCn": -0:0:0:1:0:0:0
  yarin: +0:0:0:1:0:0:0
  "yar\xFDn": +0:0:0:1:0:0:0
offset_time: 
  simdi: 0:0:0:0:0:0:0
  "\xFEimdi": 0:0:0:0:0:0:0
'on': 
  - 'on'
times: 
  gece yarisi: 00:00:00
  "gece yar\xFDs\xFD": 00:00:00
  oglen: 12:00:00
  yarim: 12:30:00
  "yar\xFDm": 12:30:00
  "\xF6\xF0len": 12:00:00
when: 
  - 
    - gecmis
    - "ge\xE7mi\xFE"
    - gecen
    - "ge\xE7en"
  - 
    - gelecek
    - ''
    - sonra
