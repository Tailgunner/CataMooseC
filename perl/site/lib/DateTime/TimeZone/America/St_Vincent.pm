# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.07) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/n2Um8ztXy_/northamerica.  Olson data version 2010l
#
# Do not edit this file directly.
#
package DateTime::TimeZone::America::St_Vincent;

use strict;

use Class::Singleton;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::America::St_Vincent::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY,
59611176296,
DateTime::TimeZone::NEG_INFINITY,
59611161600,
-14696,
0,
'LMT'
    ],
    [
59611176296,
60305313896,
59611161600,
60305299200,
-14696,
0,
'KMT'
    ],
    [
60305313896,
DateTime::TimeZone::INFINITY,
60305299496,
DateTime::TimeZone::INFINITY,
-14400,
0,
'AST'
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
