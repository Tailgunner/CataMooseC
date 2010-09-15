package Date::Manip::TZ::ammeri00;
# Copyright (c) 2008-2010 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Tue Apr 27 10:29:34 EDT 2010
#    Data version: tzdata2010i
#    Code version: tzcode2010f

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://elsie.nci.nih.gov/pub

=pod

=head1 NAME

Date::Manip::TZ::ammeri00 - Support for the America/Merida time zone

=head1 SYNPOSIS

This module contains data from the Olsen database for the time zone. It
is not intended to be used directly (other Date::Manip modules will
load it as needed).

=cut

use strict;
use warnings;
require 5.010000;

use vars qw(%Dates %LastRule);

use vars qw($VERSION);
$VERSION='6.11';

%Dates         = (
   1    =>
     [
        [ [1,1,2,0,0,0],[1,1,1,18,1,32],'-05:58:28',[-5,-58,-28],
          'LMT',0,[1922,1,1,5,59,59],[1922,1,1,0,1,31],
          '0001010200:00:00','0001010118:01:32','1922010105:59:59','1922010100:01:31' ],
     ],
   1922 =>
     [
        [ [1922,1,1,6,0,0],[1922,1,1,0,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[1981,12,23,5,59,59],[1981,12,22,23,59,59],
          '1922010106:00:00','1922010100:00:00','1981122305:59:59','1981122223:59:59' ],
     ],
   1981 =>
     [
        [ [1981,12,23,6,0,0],[1981,12,23,1,0,0],'-05:00:00',[-5,0,0],
          'EST',0,[1982,12,2,4,59,59],[1982,12,1,23,59,59],
          '1981122306:00:00','1981122301:00:00','1982120204:59:59','1982120123:59:59' ],
     ],
   1982 =>
     [
        [ [1982,12,2,5,0,0],[1982,12,1,23,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[1996,4,7,7,59,59],[1996,4,7,1,59,59],
          '1982120205:00:00','1982120123:00:00','1996040707:59:59','1996040701:59:59' ],
     ],
   1996 =>
     [
        [ [1996,4,7,8,0,0],[1996,4,7,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[1996,10,27,6,59,59],[1996,10,27,1,59,59],
          '1996040708:00:00','1996040703:00:00','1996102706:59:59','1996102701:59:59' ],
        [ [1996,10,27,7,0,0],[1996,10,27,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[1997,4,6,7,59,59],[1997,4,6,1,59,59],
          '1996102707:00:00','1996102701:00:00','1997040607:59:59','1997040601:59:59' ],
     ],
   1997 =>
     [
        [ [1997,4,6,8,0,0],[1997,4,6,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[1997,10,26,6,59,59],[1997,10,26,1,59,59],
          '1997040608:00:00','1997040603:00:00','1997102606:59:59','1997102601:59:59' ],
        [ [1997,10,26,7,0,0],[1997,10,26,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[1998,4,5,7,59,59],[1998,4,5,1,59,59],
          '1997102607:00:00','1997102601:00:00','1998040507:59:59','1998040501:59:59' ],
     ],
   1998 =>
     [
        [ [1998,4,5,8,0,0],[1998,4,5,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[1998,10,25,6,59,59],[1998,10,25,1,59,59],
          '1998040508:00:00','1998040503:00:00','1998102506:59:59','1998102501:59:59' ],
        [ [1998,10,25,7,0,0],[1998,10,25,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[1999,4,4,7,59,59],[1999,4,4,1,59,59],
          '1998102507:00:00','1998102501:00:00','1999040407:59:59','1999040401:59:59' ],
     ],
   1999 =>
     [
        [ [1999,4,4,8,0,0],[1999,4,4,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[1999,10,31,6,59,59],[1999,10,31,1,59,59],
          '1999040408:00:00','1999040403:00:00','1999103106:59:59','1999103101:59:59' ],
        [ [1999,10,31,7,0,0],[1999,10,31,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2000,4,2,7,59,59],[2000,4,2,1,59,59],
          '1999103107:00:00','1999103101:00:00','2000040207:59:59','2000040201:59:59' ],
     ],
   2000 =>
     [
        [ [2000,4,2,8,0,0],[2000,4,2,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2000,10,29,6,59,59],[2000,10,29,1,59,59],
          '2000040208:00:00','2000040203:00:00','2000102906:59:59','2000102901:59:59' ],
        [ [2000,10,29,7,0,0],[2000,10,29,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2001,5,6,7,59,59],[2001,5,6,1,59,59],
          '2000102907:00:00','2000102901:00:00','2001050607:59:59','2001050601:59:59' ],
     ],
   2001 =>
     [
        [ [2001,5,6,8,0,0],[2001,5,6,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2001,9,30,6,59,59],[2001,9,30,1,59,59],
          '2001050608:00:00','2001050603:00:00','2001093006:59:59','2001093001:59:59' ],
        [ [2001,9,30,7,0,0],[2001,9,30,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2002,4,7,7,59,59],[2002,4,7,1,59,59],
          '2001093007:00:00','2001093001:00:00','2002040707:59:59','2002040701:59:59' ],
     ],
   2002 =>
     [
        [ [2002,4,7,8,0,0],[2002,4,7,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2002,10,27,6,59,59],[2002,10,27,1,59,59],
          '2002040708:00:00','2002040703:00:00','2002102706:59:59','2002102701:59:59' ],
        [ [2002,10,27,7,0,0],[2002,10,27,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2003,4,6,7,59,59],[2003,4,6,1,59,59],
          '2002102707:00:00','2002102701:00:00','2003040607:59:59','2003040601:59:59' ],
     ],
   2003 =>
     [
        [ [2003,4,6,8,0,0],[2003,4,6,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2003,10,26,6,59,59],[2003,10,26,1,59,59],
          '2003040608:00:00','2003040603:00:00','2003102606:59:59','2003102601:59:59' ],
        [ [2003,10,26,7,0,0],[2003,10,26,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2004,4,4,7,59,59],[2004,4,4,1,59,59],
          '2003102607:00:00','2003102601:00:00','2004040407:59:59','2004040401:59:59' ],
     ],
   2004 =>
     [
        [ [2004,4,4,8,0,0],[2004,4,4,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2004,10,31,6,59,59],[2004,10,31,1,59,59],
          '2004040408:00:00','2004040403:00:00','2004103106:59:59','2004103101:59:59' ],
        [ [2004,10,31,7,0,0],[2004,10,31,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2005,4,3,7,59,59],[2005,4,3,1,59,59],
          '2004103107:00:00','2004103101:00:00','2005040307:59:59','2005040301:59:59' ],
     ],
   2005 =>
     [
        [ [2005,4,3,8,0,0],[2005,4,3,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2005,10,30,6,59,59],[2005,10,30,1,59,59],
          '2005040308:00:00','2005040303:00:00','2005103006:59:59','2005103001:59:59' ],
        [ [2005,10,30,7,0,0],[2005,10,30,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2006,4,2,7,59,59],[2006,4,2,1,59,59],
          '2005103007:00:00','2005103001:00:00','2006040207:59:59','2006040201:59:59' ],
     ],
   2006 =>
     [
        [ [2006,4,2,8,0,0],[2006,4,2,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2006,10,29,6,59,59],[2006,10,29,1,59,59],
          '2006040208:00:00','2006040203:00:00','2006102906:59:59','2006102901:59:59' ],
        [ [2006,10,29,7,0,0],[2006,10,29,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2007,4,1,7,59,59],[2007,4,1,1,59,59],
          '2006102907:00:00','2006102901:00:00','2007040107:59:59','2007040101:59:59' ],
     ],
   2007 =>
     [
        [ [2007,4,1,8,0,0],[2007,4,1,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2007,10,28,6,59,59],[2007,10,28,1,59,59],
          '2007040108:00:00','2007040103:00:00','2007102806:59:59','2007102801:59:59' ],
        [ [2007,10,28,7,0,0],[2007,10,28,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2008,4,6,7,59,59],[2008,4,6,1,59,59],
          '2007102807:00:00','2007102801:00:00','2008040607:59:59','2008040601:59:59' ],
     ],
   2008 =>
     [
        [ [2008,4,6,8,0,0],[2008,4,6,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2008,10,26,6,59,59],[2008,10,26,1,59,59],
          '2008040608:00:00','2008040603:00:00','2008102606:59:59','2008102601:59:59' ],
        [ [2008,10,26,7,0,0],[2008,10,26,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2009,4,5,7,59,59],[2009,4,5,1,59,59],
          '2008102607:00:00','2008102601:00:00','2009040507:59:59','2009040501:59:59' ],
     ],
   2009 =>
     [
        [ [2009,4,5,8,0,0],[2009,4,5,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2009,10,25,6,59,59],[2009,10,25,1,59,59],
          '2009040508:00:00','2009040503:00:00','2009102506:59:59','2009102501:59:59' ],
        [ [2009,10,25,7,0,0],[2009,10,25,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2010,4,4,7,59,59],[2010,4,4,1,59,59],
          '2009102507:00:00','2009102501:00:00','2010040407:59:59','2010040401:59:59' ],
     ],
   2010 =>
     [
        [ [2010,4,4,8,0,0],[2010,4,4,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2010,10,31,6,59,59],[2010,10,31,1,59,59],
          '2010040408:00:00','2010040403:00:00','2010103106:59:59','2010103101:59:59' ],
        [ [2010,10,31,7,0,0],[2010,10,31,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2011,4,3,7,59,59],[2011,4,3,1,59,59],
          '2010103107:00:00','2010103101:00:00','2011040307:59:59','2011040301:59:59' ],
     ],
   2011 =>
     [
        [ [2011,4,3,8,0,0],[2011,4,3,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2011,10,30,6,59,59],[2011,10,30,1,59,59],
          '2011040308:00:00','2011040303:00:00','2011103006:59:59','2011103001:59:59' ],
        [ [2011,10,30,7,0,0],[2011,10,30,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2012,4,1,7,59,59],[2012,4,1,1,59,59],
          '2011103007:00:00','2011103001:00:00','2012040107:59:59','2012040101:59:59' ],
     ],
   2012 =>
     [
        [ [2012,4,1,8,0,0],[2012,4,1,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2012,10,28,6,59,59],[2012,10,28,1,59,59],
          '2012040108:00:00','2012040103:00:00','2012102806:59:59','2012102801:59:59' ],
        [ [2012,10,28,7,0,0],[2012,10,28,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2013,4,7,7,59,59],[2013,4,7,1,59,59],
          '2012102807:00:00','2012102801:00:00','2013040707:59:59','2013040701:59:59' ],
     ],
   2013 =>
     [
        [ [2013,4,7,8,0,0],[2013,4,7,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2013,10,27,6,59,59],[2013,10,27,1,59,59],
          '2013040708:00:00','2013040703:00:00','2013102706:59:59','2013102701:59:59' ],
        [ [2013,10,27,7,0,0],[2013,10,27,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2014,4,6,7,59,59],[2014,4,6,1,59,59],
          '2013102707:00:00','2013102701:00:00','2014040607:59:59','2014040601:59:59' ],
     ],
   2014 =>
     [
        [ [2014,4,6,8,0,0],[2014,4,6,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2014,10,26,6,59,59],[2014,10,26,1,59,59],
          '2014040608:00:00','2014040603:00:00','2014102606:59:59','2014102601:59:59' ],
        [ [2014,10,26,7,0,0],[2014,10,26,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2015,4,5,7,59,59],[2015,4,5,1,59,59],
          '2014102607:00:00','2014102601:00:00','2015040507:59:59','2015040501:59:59' ],
     ],
   2015 =>
     [
        [ [2015,4,5,8,0,0],[2015,4,5,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2015,10,25,6,59,59],[2015,10,25,1,59,59],
          '2015040508:00:00','2015040503:00:00','2015102506:59:59','2015102501:59:59' ],
        [ [2015,10,25,7,0,0],[2015,10,25,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2016,4,3,7,59,59],[2016,4,3,1,59,59],
          '2015102507:00:00','2015102501:00:00','2016040307:59:59','2016040301:59:59' ],
     ],
   2016 =>
     [
        [ [2016,4,3,8,0,0],[2016,4,3,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2016,10,30,6,59,59],[2016,10,30,1,59,59],
          '2016040308:00:00','2016040303:00:00','2016103006:59:59','2016103001:59:59' ],
        [ [2016,10,30,7,0,0],[2016,10,30,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2017,4,2,7,59,59],[2017,4,2,1,59,59],
          '2016103007:00:00','2016103001:00:00','2017040207:59:59','2017040201:59:59' ],
     ],
   2017 =>
     [
        [ [2017,4,2,8,0,0],[2017,4,2,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2017,10,29,6,59,59],[2017,10,29,1,59,59],
          '2017040208:00:00','2017040203:00:00','2017102906:59:59','2017102901:59:59' ],
        [ [2017,10,29,7,0,0],[2017,10,29,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2018,4,1,7,59,59],[2018,4,1,1,59,59],
          '2017102907:00:00','2017102901:00:00','2018040107:59:59','2018040101:59:59' ],
     ],
   2018 =>
     [
        [ [2018,4,1,8,0,0],[2018,4,1,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2018,10,28,6,59,59],[2018,10,28,1,59,59],
          '2018040108:00:00','2018040103:00:00','2018102806:59:59','2018102801:59:59' ],
        [ [2018,10,28,7,0,0],[2018,10,28,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2019,4,7,7,59,59],[2019,4,7,1,59,59],
          '2018102807:00:00','2018102801:00:00','2019040707:59:59','2019040701:59:59' ],
     ],
   2019 =>
     [
        [ [2019,4,7,8,0,0],[2019,4,7,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2019,10,27,6,59,59],[2019,10,27,1,59,59],
          '2019040708:00:00','2019040703:00:00','2019102706:59:59','2019102701:59:59' ],
        [ [2019,10,27,7,0,0],[2019,10,27,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2020,4,5,7,59,59],[2020,4,5,1,59,59],
          '2019102707:00:00','2019102701:00:00','2020040507:59:59','2020040501:59:59' ],
     ],
   2020 =>
     [
        [ [2020,4,5,8,0,0],[2020,4,5,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2020,10,25,6,59,59],[2020,10,25,1,59,59],
          '2020040508:00:00','2020040503:00:00','2020102506:59:59','2020102501:59:59' ],
        [ [2020,10,25,7,0,0],[2020,10,25,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2021,4,4,7,59,59],[2021,4,4,1,59,59],
          '2020102507:00:00','2020102501:00:00','2021040407:59:59','2021040401:59:59' ],
     ],
   2021 =>
     [
        [ [2021,4,4,8,0,0],[2021,4,4,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2021,10,31,6,59,59],[2021,10,31,1,59,59],
          '2021040408:00:00','2021040403:00:00','2021103106:59:59','2021103101:59:59' ],
        [ [2021,10,31,7,0,0],[2021,10,31,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2022,4,3,7,59,59],[2022,4,3,1,59,59],
          '2021103107:00:00','2021103101:00:00','2022040307:59:59','2022040301:59:59' ],
     ],
   2022 =>
     [
        [ [2022,4,3,8,0,0],[2022,4,3,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2022,10,30,6,59,59],[2022,10,30,1,59,59],
          '2022040308:00:00','2022040303:00:00','2022103006:59:59','2022103001:59:59' ],
        [ [2022,10,30,7,0,0],[2022,10,30,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2023,4,2,7,59,59],[2023,4,2,1,59,59],
          '2022103007:00:00','2022103001:00:00','2023040207:59:59','2023040201:59:59' ],
     ],
   2023 =>
     [
        [ [2023,4,2,8,0,0],[2023,4,2,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2023,10,29,6,59,59],[2023,10,29,1,59,59],
          '2023040208:00:00','2023040203:00:00','2023102906:59:59','2023102901:59:59' ],
        [ [2023,10,29,7,0,0],[2023,10,29,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2024,4,7,7,59,59],[2024,4,7,1,59,59],
          '2023102907:00:00','2023102901:00:00','2024040707:59:59','2024040701:59:59' ],
     ],
   2024 =>
     [
        [ [2024,4,7,8,0,0],[2024,4,7,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2024,10,27,6,59,59],[2024,10,27,1,59,59],
          '2024040708:00:00','2024040703:00:00','2024102706:59:59','2024102701:59:59' ],
        [ [2024,10,27,7,0,0],[2024,10,27,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2025,4,6,7,59,59],[2025,4,6,1,59,59],
          '2024102707:00:00','2024102701:00:00','2025040607:59:59','2025040601:59:59' ],
     ],
   2025 =>
     [
        [ [2025,4,6,8,0,0],[2025,4,6,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2025,10,26,6,59,59],[2025,10,26,1,59,59],
          '2025040608:00:00','2025040603:00:00','2025102606:59:59','2025102601:59:59' ],
        [ [2025,10,26,7,0,0],[2025,10,26,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2026,4,5,7,59,59],[2026,4,5,1,59,59],
          '2025102607:00:00','2025102601:00:00','2026040507:59:59','2026040501:59:59' ],
     ],
   2026 =>
     [
        [ [2026,4,5,8,0,0],[2026,4,5,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2026,10,25,6,59,59],[2026,10,25,1,59,59],
          '2026040508:00:00','2026040503:00:00','2026102506:59:59','2026102501:59:59' ],
        [ [2026,10,25,7,0,0],[2026,10,25,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2027,4,4,7,59,59],[2027,4,4,1,59,59],
          '2026102507:00:00','2026102501:00:00','2027040407:59:59','2027040401:59:59' ],
     ],
   2027 =>
     [
        [ [2027,4,4,8,0,0],[2027,4,4,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2027,10,31,6,59,59],[2027,10,31,1,59,59],
          '2027040408:00:00','2027040403:00:00','2027103106:59:59','2027103101:59:59' ],
        [ [2027,10,31,7,0,0],[2027,10,31,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2028,4,2,7,59,59],[2028,4,2,1,59,59],
          '2027103107:00:00','2027103101:00:00','2028040207:59:59','2028040201:59:59' ],
     ],
   2028 =>
     [
        [ [2028,4,2,8,0,0],[2028,4,2,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2028,10,29,6,59,59],[2028,10,29,1,59,59],
          '2028040208:00:00','2028040203:00:00','2028102906:59:59','2028102901:59:59' ],
        [ [2028,10,29,7,0,0],[2028,10,29,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2029,4,1,7,59,59],[2029,4,1,1,59,59],
          '2028102907:00:00','2028102901:00:00','2029040107:59:59','2029040101:59:59' ],
     ],
   2029 =>
     [
        [ [2029,4,1,8,0,0],[2029,4,1,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2029,10,28,6,59,59],[2029,10,28,1,59,59],
          '2029040108:00:00','2029040103:00:00','2029102806:59:59','2029102801:59:59' ],
        [ [2029,10,28,7,0,0],[2029,10,28,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2030,4,7,7,59,59],[2030,4,7,1,59,59],
          '2029102807:00:00','2029102801:00:00','2030040707:59:59','2030040701:59:59' ],
     ],
   2030 =>
     [
        [ [2030,4,7,8,0,0],[2030,4,7,3,0,0],'-05:00:00',[-5,0,0],
          'CDT',1,[2030,10,27,6,59,59],[2030,10,27,1,59,59],
          '2030040708:00:00','2030040703:00:00','2030102706:59:59','2030102701:59:59' ],
        [ [2030,10,27,7,0,0],[2030,10,27,1,0,0],'-06:00:00',[-6,0,0],
          'CST',0,[2031,4,6,7,59,59],[2031,4,6,1,59,59],
          '2030102707:00:00','2030102701:00:00','2031040607:59:59','2031040601:59:59' ],
     ],
);

%LastRule      = (
   'zone'   => {
                'dstoff' => '-05:00:00',
                'stdoff' => '-06:00:00',
               },
   'rules'  => {
                '04' => {
                         'flag'    => 'ge',
                         'dow'     => '7',
                         'num'     => '1',
                         'type'    => 'w',
                         'time'    => '02:00:00',
                         'isdst'   => '1',
                         'abb'     => 'CDT',
                        },
                '10' => {
                         'flag'    => 'last',
                         'dow'     => '7',
                         'num'     => '0',
                         'type'    => 'w',
                         'time'    => '02:00:00',
                         'isdst'   => '0',
                         'abb'     => 'CST',
                        },
               },
);

1;