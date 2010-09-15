# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.07) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/n2Um8ztXy_/asia.  Olson data version 2010l
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Asia::Pyongyang;

use strict;

use Class::Singleton;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Asia::Pyongyang::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY,
59611131420,
DateTime::TimeZone::NEG_INFINITY,
59611161600,
30180,
0,
'LMT'
    ],
    [
59611131420,
60081751800,
59611162020,
60081782400,
30600,
0,
'KST'
    ],
    [
60081751800,
60810188400,
60081784200,
60810220800,
32400,
0,
'KST'
    ],
    [
60810188400,
60936420600,
60810219000,
60936451200,
30600,
0,
'KST'
    ],
    [
60936420600,
61637554800,
60936453000,
61637587200,
32400,
0,
'KST'
    ],
    [
61637554800,
61870752000,
61637583600,
61870780800,
28800,
0,
'KST'
    ],
    [
61870752000,
DateTime::TimeZone::INFINITY,
61870784400,
DateTime::TimeZone::INFINITY,
32400,
0,
'KST'
    ],
];

sub olson_version { '2010l' }

sub has_dst_changes { 0 }

sub _max_year { 2020 }

sub _new_instance
{
    return shift->_init( @_, spans => $spans );
}



1;

