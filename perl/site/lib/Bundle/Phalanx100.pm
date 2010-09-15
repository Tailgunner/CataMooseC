package Bundle::Phalanx100;

$Bundle::Phalanx100::VERSION = '0.07';

1;

__END__


=head1 NAME
                                                                                
Bundle::Phalanx100 - A bundle to install modules on the Phalanx 100 module list. 
                                                                                
=head1 SYNOPSIS

C<perl -MCPAN -e 'install "Bundle::Phalanx100"'>

=head1 CONTENTS

Test::Harness

Test::Reporter

Test::Builder

Test::Builder::Tester

Sub::Uplevel

Test::Exception

Test::Tester

Test::NoWarnings

Test::Tester

Pod::Escapes

Pod::Simple

Test::Pod

YAML

Cwd

Archive::Tar

Module::Build

Devel::Symdump

Pod::Coverage - needed for Test::Pod::Coverage

Test::Pod::Coverage

Compress::Zlib

IO::Zlib

Archive::Zip

Archive::Tar

Storable

Digest::MD5

URI

HTML::Tagset

HTML::Parser

LWP

IPC::Run

CPANPLUS

DBI

GD

MIME::Base64

Net::SSLeay

Net::LDAP

XML::Parser 

Apache::ASP

CGI

Date::Manip

DBD::Oracle

DBD::Pg

Digest::SHA1

Digest::HMAC

HTML::Tagset

HTML::Template

Net::Cmd

Mail::Mailer

MIME::Body

Net::DNS

Time::HiRes

Apache::DBI

Apache::Session

Apache::Test

AppConfig

App::Info

Authen::PAM

Authen::SASL

BerkeleyDB

Bit::Vector

Carp::Clan

Chart::Bars

Class::DBI

Compress::Zlib::Perl

Config::IniFiles

Convert::ASN1

Convert::TNEF

Convert::UUlib

CPAN

Crypt::CBC

Crypt::DES

Crypt::SSLeay

Data::Dumper

Date::Calc

DateTime

DBD::DB2

DBD::ODBC

DBD::SQLite

DBD::Sybase

Device::SerialPort

Digest::SHA

Encode

Event

Excel::Template

Expect

ExtUtils::MakeMaker

File::Scan

File::Spec

File::Tail

File::Temp

GD::Graph

GD::Text

Getopt::Long

HTML::Mason

Image::Size

IMAP::Admin

Parse::RecDescent

Inline

IO

Spiffy

IO::All

IO::Socket::SSL

IO::String

IO::Stringy

XML::SAX2Perl

Mail::Audit

Mail::ClamAV

Mail::Sendmail

Math::Pari

MD5

MIME::Lite

MP3::Info

Net::Daemon

Net::FTP::Common

Net::Ping

Net::Server

Net::SNMP

Net::SSH::Perl

Net::Telnet

OLE::Storage_Lite

Params::Validate

Image::Magick

RPC::PlServer

Pod::Parser

POE

SNMP

SOAP::Lite

Spreadsheet::ParseExcel

Spreadsheet::WriteExcel

Spreadsheet::WriteExcelXML

Storable

Template

Term::ReadKey

Term::ReadLine::Perl

Text::Iconv

Date::Parse

Time::Timezone

Unicode::String

Unix::Syslog

Verilog::Parser

WWW::Mechanize

XML::DOM

XML::Generator

XML::LibXML

XML::NamespaceSupport

XML::SAX

XML::Simple

XML::Writer

=head1 DESCRIPTION

This bundle includes the modules defined as part of the "The Phalanx 100".  To
find out more about this project, please see the project website at
L<http://qa.perl.org/phalanx>.

=head1 TODO

=over

=item *

Make the list a bit more intelligently, so that prerequisite modules are 
installed prior to the modules that depend on them.  This is mostly done, but I
just trying to decide whether to install ALL the the required modules, whether they
are part of the "Phalanx 100" or not.

=item *

See if there is a way to do some additional checks before attempting to 
install modules that are destined to fail.  For example, attempting to 
install a DBD module for a database not installed on the system.

=back

=head1 BUGS

Currently, there are no known bugs.  If you find any, patches are appreciated!
 
=head1 AUTHOR

Steve Peters E<lt>steve@fisharerojo.org>

=head1 SEE ALSO

L<CPAN>, L<http://qa.perl.org/phalanx>

=head1 COPYRIGHT

Copyright (c) 2003-2005, Steve Peters.  All Rights Reserved.
This module is free software.  It may be used, redistributed
and/or modified under the same terms as Perl itself.

=cut 
