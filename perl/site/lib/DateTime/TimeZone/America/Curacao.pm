# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.07) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from /tmp/n2Um8ztXy_/southamerica.  Olson data version 2010l
#
# Do not edit this file directly.
#
package DateTime::TimeZone::America::Curacao;

use strict;

use Class::Singleton;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::America::Curacao::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY,
60308944544,
DateTime::TimeZone::NEG_INFINITY,
60308928000,
-16544,
0,
'LMT'
    ],
    [
60308944544,
61977933000,
60308928344,
61977916800,
-16200,
0,
'ANT'
    ],
    [
61977933000,
DateTime::TimeZone::INFINITY,
61977918600,
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
