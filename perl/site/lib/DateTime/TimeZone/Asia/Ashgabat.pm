# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.07) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/n2Um8ztXy_/asia.  Olson data version 2010l
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Asia::Ashgabat;

use strict;

use Class::Singleton;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Asia::Ashgabat::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY,
60694517188,
DateTime::TimeZone::NEG_INFINITY,
60694531200,
14012,
0,
'LMT'
    ],
    [
60694517188,
60888139200,
60694531588,
60888153600,
14400,
0,
'ASHT'
    ],
    [
60888139200,
62490596400,
60888157200,
62490614400,
18000,
0,
'ASHT'
    ],
    [
62490596400,
62506404000,
62490618000,
62506425600,
21600,
1,
'ASHST'
    ],
    [
62506404000,
62522132400,
62506422000,
62522150400,
18000,
0,
'ASHT'
    ],
    [
62522132400,
62537940000,
62522154000,
62537961600,
21600,
1,
'ASHST'
    ],
    [
62537940000,
62553668400,
62537958000,
62553686400,
18000,
0,
'ASHT'
    ],
    [
62553668400,
62569476000,
62553690000,
62569497600,
21600,
1,
'ASHST'
    ],
    [
62569476000,
62585290800,
62569494000,
62585308800,
18000,
0,
'ASHT'
    ],
    [
62585290800,
62601022800,
62585312400,
62601044400,
21600,
1,
'ASHST'
    ],
    [
62601022800,
62616747600,
62601040800,
62616765600,
18000,
0,
'ASHT'
    ],
    [
62616747600,
62632472400,
62616769200,
62632494000,
21600,
1,
'ASHST'
    ],
    [
62632472400,
62648197200,
62632490400,
62648215200,
18000,
0,
'ASHT'
    ],
    [
62648197200,
62663922000,
62648218800,
62663943600,
21600,
1,
'ASHST'
    ],
    [
62663922000,
62679646800,
62663940000,
62679664800,
18000,
0,
'ASHT'
    ],
    [
62679646800,
62695371600,
62679668400,
62695393200,
21600,
1,
'ASHST'
    ],
    [
62695371600,
62711096400,
62695389600,
62711114400,
18000,
0,
'ASHT'
    ],
    [
62711096400,
62726821200,
62711118000,
62726842800,
21600,
1,
'ASHST'
    ],
    [
62726821200,
62742546000,
62726839200,
62742564000,
18000,
0,
'ASHT'
    ],
    [
62742546000,
62758270800,
62742567600,
62758292400,
21600,
1,
'ASHST'
    ],
    [
62758270800,
62773995600,
62758288800,
62774013600,
18000,
0,
'ASHT'
    ],
    [
62773995600,
62790325200,
62774017200,
62790346800,
21600,
1,
'ASHST'
    ],
    [
62790325200,
62806050000,
62790343200,
62806068000,
18000,
0,
'ASHT'
    ],
    [
62806050000,
62821778400,
62806068000,
62821796400,
18000,
1,
'ASHST'
    ],
    [
62821778400,
62824190400,
62821792800,
62824204800,
14400,
0,
'ASHT'
    ],
    [
62824190400,
62831455200,
62824204800,
62831469600,
14400,
0,
'TMT'
    ],
    [
62831455200,
DateTime::TimeZone::INFINITY,
62831473200,
DateTime::TimeZone::INFINITY,
18000,
0,
'TMT'
    ],
];

sub olson_version { '2010l' }

sub has_dst_changes { 11 }

sub _max_year { 2020 }

sub _new_instance
{
    return shift->_init( @_, spans => $spans );
}



1;

