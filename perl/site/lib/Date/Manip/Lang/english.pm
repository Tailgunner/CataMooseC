package Date::Manip::Lang::english;
# Copyright (c) 1995-2010 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
########################################################################

=pod

=head1 NAME

Date::Manip::Lang::english - English language support.

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
  - at
day_abb: 
  - 
    - Mon
  - 
    - Tue
    - ''
    - Tues
  - 
    - Wed
  - 
    - Thu
    - ''
    - Thur
  - 
    - Fri
  - 
    - Sat
  - 
    - Sun
day_char: 
  - 
    - M
  - 
    - T
  - 
    - W
  - 
    - Th
  - 
    - F
  - 
    - Sa
  - 
    - S
day_name: 
  - 
    - Monday
  - 
    - Tuesday
  - 
    - Wednesday
  - 
    - Thursday
  - 
    - Friday
  - 
    - Saturday
  - 
    - Sunday
each: 
  - each
  - ''
  - every
fields: 
  - 
    - years
    - ''
    - 'y'
    - yr
    - year
    - yrs
  - 
    - months
    - ''
    - m
    - mon
    - month
  - 
    - weeks
    - ''
    - w
    - wk
    - wks
    - week
  - 
    - days
    - ''
    - d
    - day
  - 
    - hours
    - ''
    - h
    - hr
    - hrs
    - hour
  - 
    - minutes
    - ''
    - mn
    - min
    - minute
  - 
    - seconds
    - ''
    - s
    - sec
    - second
last: 
  - last
  - ''
  - final
mode: 
  - 
    - exactly
    - ''
    - approximately
  - 
    - business
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
    - May
  - 
    - Jun
  - 
    - Jul
  - 
    - Aug
  - 
    - Sep
    - ''
    - Sept
  - 
    - Oct
  - 
    - Nov
  - 
    - Dec
month_name: 
  - 
    - January
  - 
    - February
  - 
    - March
  - 
    - April
  - 
    - May
  - 
    - June
  - 
    - July
  - 
    - August
  - 
    - September
  - 
    - October
  - 
    - November
  - 
    - December
nextprev: 
  - 
    - next
  - 
    - previous
    - ''
    - last
nth: 
  - 
    - 1st
    - ''
    - first
  - 
    - 2nd
    - ''
    - second
  - 
    - 3rd
    - ''
    - third
  - 
    - 4th
    - ''
    - fourth
  - 
    - 5th
    - ''
    - fifth
  - 
    - 6th
    - ''
    - sixth
  - 
    - 7th
    - ''
    - seventh
  - 
    - 8th
    - ''
    - eighth
  - 
    - 9th
    - ''
    - ninth
  - 
    - 10th
    - ''
    - tenth
  - 
    - 11th
    - ''
    - eleventh
  - 
    - 12th
    - ''
    - twelfth
  - 
    - 13th
    - ''
    - thirteenth
  - 
    - 14th
    - ''
    - fourteenth
  - 
    - 15th
    - ''
    - fifteenth
  - 
    - 16th
    - ''
    - sixteenth
  - 
    - 17th
    - ''
    - seventeenth
  - 
    - 18th
    - ''
    - eighteenth
  - 
    - 19th
    - ''
    - nineteenth
  - 
    - 20th
    - ''
    - twentieth
  - 
    - 21st
    - ''
    - twenty-first
  - 
    - 22nd
    - ''
    - twenty-second
  - 
    - 23rd
    - ''
    - twenty-third
  - 
    - 24th
    - ''
    - twenty-fourth
  - 
    - 25th
    - ''
    - twenty-fifth
  - 
    - 26th
    - ''
    - twenty-sixth
  - 
    - 27th
    - ''
    - twenty-seventh
  - 
    - 28th
    - ''
    - twenty-eighth
  - 
    - 29th
    - ''
    - twenty-ninth
  - 
    - 30th
    - ''
    - thirtieth
  - 
    - 31st
    - ''
    - thirty-first
of: 
  - of
  - ''
  - in
offset_date: 
  ereyesterday: -0:0:0:2:0:0:0
  overmorrow: +0:0:0:2:0:0:0
  today: 0:0:0:0:0:0:0
  tomorrow: +0:0:0:1:0:0:0
  yesterday: -0:0:0:1:0:0:0
offset_time: 
  now: 0:0:0:0:0:0:0
'on': 
  - 'on'
times: 
  midnight: 00:00:00
  noon: 12:00:00
when: 
  - 
    - ago
    - ''
    - past
    - in the past
  - 
    - in
    - ''
    - later
    - future
    - in the future
    - from now
