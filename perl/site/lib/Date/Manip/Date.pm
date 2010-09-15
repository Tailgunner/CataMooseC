package Date::Manip::Date;
# Copyright (c) 1995-2010 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
# Any routine that starts with an underscore (_) is NOT intended for
# public use.  They are for internal use in the the Date::Manip
# modules and are subject to change without warning or notice.
#
# ABSOLUTELY NO USER SUPPORT IS OFFERED FOR THESE ROUTINES!
########################################################################

use Date::Manip::Obj;
@ISA = ('Date::Manip::Obj');

require 5.010000;
use warnings;
use strict;
use integer;
use IO::File;
use feature 'switch';
#use re 'debug';

use Date::Manip::Base;
use Date::Manip::TZ;

use vars qw($VERSION);
$VERSION='6.11';

########################################################################
# BASE METHODS
########################################################################

# Call this every time a new date is put in to make sure everything is
# correctly initialized.
#
sub _init {
   my($self) = @_;

   $$self{'err'}              = '';

   $$self{'data'} =
     {
      'set'    => 0,         # 1 if the date has been set
                             # 2 if the date is in the process of being set

      # The date as input
      'in'     => '',        # the string that was parsed (if any)
      'zin'    => '',        # the timezone that was parsed (if any)

      # The date in the parsed timezone
      'date'   => [],        # the parsed date split
      'def'    => [0,0,0,0,0,0],

      # 1 for each field that came from
      # defaults rather than parsed
      # '' for an implied field
      'tz'     => '',        # the timezone of the date
      'isdst'  => '',        # 1 if the date is in DST.
      'offset' => [],        # The offset from GMT
      'abb'    => '',        # The timezone abbreviation.
      'f'      => {},        # fields used in printing a date

      # The date in GMT
      'gmt'    => [],        # the date converted to GMT

      # The date in local timezone
      'loc'    => [],        # the date converted to local timezone
     };
}

sub _init_args {
   my($self) = @_;

   my @args = @{ $$self{'args'} };
   if (@args) {
      if ($#args == 0) {
         $self->parse($args[0]);
      } else {
         warn "WARNING: [new] invalid arguments: @args\n";
      }
   }
}

########################################################################
# DATE PARSING
########################################################################

sub parse {
   my($self,$string,@opts) = @_;
   $self->_init();
   my $noupdate = 0;

   if (! $string) {
      $$self{'err'} = '[parse] Empty date string';
      return 1;
   }

   my %opts     = map { $_,1 } @opts;
   my $instring = $string;

   my $dmb = $$self{'objs'}{'base'};

   my($done,$y,$m,$d,$h,$mn,$s,$tzstring,$zone,$abb,$off,$dow);
   my $got_time     = 0;
   my $default_time = 0;

   # Put parse in a simple loop for an easy exit.
 PARSE: {
      my(@tmp,$tmp);

      # Check the standard date format

      $tmp = $dmb->split('date',$string);
      if (defined($tmp)) {
         ($y,$m,$d,$h,$mn,$s) = @$tmp;
         $got_time = 1;
         last PARSE;
      }

      # Parse ISO 8601 dates now (which may have a timezone).

      unless (exists $opts{'noiso8601'}) {
         ($done,@tmp) = $self->_parse_datetime_iso8601($string,\$noupdate);
         if ($done) {
            ($y,$m,$d,$h,$mn,$s,$tzstring,$zone,$abb,$off) = @tmp;
            $got_time = 1;
            last PARSE;
         }
      }

      # There's lots of ways that commas may be included. Remove
      # them.

      $string =~ s/,/ /g;

      # Some special full date/time formats

      unless (exists $opts{'nospecial'}) {
         ($done,@tmp) = $self->_parse_datetime_other($string,\$noupdate);
         if ($done) {
            ($y,$m,$d,$h,$mn,$s,$tzstring,$zone,$abb,$off) = @tmp;
            $got_time = 1;
            last PARSE;
         }
      }

      # Parse (and remove) the time

      ($got_time,@tmp) = $self->_parse_time('parse',$string,\$noupdate,%opts);
      if ($got_time) {
         ($string,$h,$mn,$s,$tzstring,$zone,$abb,$off) = @tmp;
      }

      if (! $string) {
         ($y,$m,$d) = $self->_def_date($y,$m,$d,\$noupdate);
         last;
      }

      # Parse (and remove) the day of week. Also, handle the simple DoW
      # formats.

      unless (exists $opts{'nodow'}) {
         ($done,@tmp) = $self->_parse_dow($string,\$noupdate);
         if (@tmp) {
            if ($done) {
               ($y,$m,$d)    = @tmp;
               $default_time = 1;
               last PARSE;
            } else {
               ($string,$dow) = @tmp;
            }
         }
      }
      $dow = 0  if (! $dow);

      (@tmp) = $self->_parse_date($string,$dow,\$noupdate,%opts);
      if (@tmp) {
         ($y,$m,$d,$dow) = @tmp;
         $default_time = 1;
         last PARSE;
      }

      # Parse deltas
      #
      # Occasionally, a delta is entered for a date (which is interpreted
      # as the date relative to now). There can be some confusion between
      # a date and a delta, but the most important conflicts are the
      # ISO 8601 dates (many of which could be interpreted as a delta),
      # but those have already been taken care of.

      unless (exists $opts{'nodelta'}) {
         ($done,@tmp) = $self->_parse_delta($string,$dow,$got_time,$h,$mn,$s,\$noupdate);
         if (@tmp) {
            ($y,$m,$d,$h,$mn,$s) = @tmp;
            $got_time = 1;
            $dow = '';
         }
         last PARSE  if ($done);
      }

      $$self{'err'} = '[parse] Invalid date string';
      return 1;
   }

   return 1  if ($$self{'err'});

   # Make sure that a time is set

   if (! $got_time) {
      if ($default_time) {
         if ($dmb->_config('defaulttime') eq 'midnight') {
            ($h,$mn,$s) = (0,0,0);
         } else {
            ($h,$mn,$s) = $dmb->_now('time',$noupdate);
            $noupdate = 1;
         }
         $got_time = 1;
      } else {
         ($h,$mn,$s) = $self->_def_time(undef,undef,undef,\$noupdate);
      }
   }

   $$self{'data'}{'set'} = 2;
   return $self->_parse_check('parse',$instring,
                              $y,$m,$d,$h,$mn,$s,$dow,$tzstring,$zone,$abb,$off);
}

sub parse_time {
   my($self,$string) = @_;
   my $noupdate = 0;

   if (! $string) {
      $$self{'err'} = '[parse_time] Empty time string';
      return 1;
   }

   my($y,$m,$d,$h,$mn,$s);

   if ($$self{'err'}) {
      $self->_init();
   }
   if ($$self{'data'}{'set'}) {
      ($y,$m,$d,$h,$mn,$s) = @{ $$self{'data'}{'date'} };
   } else {
      my $dmb = $$self{'objs'}{'base'};
      ($y,$m,$d,$h,$mn,$s) = $dmb->_now('now',$noupdate);
      $noupdate = 1;
   }
   my($tzstring,$zone,$abb,$off);

   ($h,$mn,$s,$tzstring,$zone,$abb,$off) =
     $self->_parse_time('parse_time',$string,\$noupdate);

   return 1  if ($$self{'err'});

   $$self{'data'}{'set'} = 2;
   return $self->_parse_check('parse_time','',
                              $y,$m,$d,$h,$mn,$s,'',$tzstring,$zone,$abb,$off);
}

sub parse_date {
   my($self,$string,@opts) = @_;
   my %opts     = map { $_,1 } @opts;
   my $noupdate = 0;

   if (! $string) {
      $$self{'err'} = '[parse_date] Empty date string';
      return 1;
   }

   my $dmb = $$self{'objs'}{'base'};
   my($y,$m,$d,$h,$mn,$s);

   if ($$self{'err'}) {
      $self->_init();
   }
   if ($$self{'data'}{'set'}) {
      ($y,$m,$d,$h,$mn,$s) = @{ $$self{'data'}{'date'} };
   } else {
      ($h,$mn,$s) = (0,0,0);
   }

   # Put parse in a simple loop for an easy exit.
   my($done,@tmp,$dow);
 PARSE: {

      # Parse ISO 8601 dates now

      unless (exists $opts{'noiso8601'}) {
         ($done,@tmp) = $self->_parse_date_iso8601($string,\$noupdate);
         if ($done) {
            ($y,$m,$d) = @tmp;
            last PARSE;
         }
      }

      (@tmp) = $self->_parse_date($string,undef,\$noupdate,%opts);
      if (@tmp) {
         ($y,$m,$d,$dow) = @tmp;
         last PARSE;
      }

      $$self{'err'} = '[parse_date] Invalid date string';
      return 1;
   }

   return 1  if ($$self{'err'});

   $y = $dmb->_fix_year($y);

   $$self{'data'}{'set'} = 2;
   return $self->_parse_check('parse_date','',$y,$m,$d,$h,$mn,$s,$dow);
}

sub _parse_date {
   my($self,$string,$dow,$noupdate,%opts) = @_;

   # There's lots of ways that commas may be included. Remove
   # them.
   #
   # Also remove some words we should ignore.

   $string =~ s/,/ /g;

   my $dmb = $$self{'objs'}{'base'};
   my $ign = (exists $$dmb{'data'}{'rx'}{'other'}{'ignore'} ?
              $$dmb{'data'}{'rx'}{'other'}{'ignore'} :
              $self->_other_rx('ignore'));
   $string =~ s/$ign/ /g;

   $string =~ s/\s*$//;
   return ()  if (! $string);

   my($done,$y,$m,$d,@tmp);

   # Put parse in a simple loop for an easy exit.
 PARSE: {

      # Parse (and remove) the day of week. Also, handle the simple DoW
      # formats.

      unless (exists $opts{'nodow'}) {
         if (! defined($dow)) {
            ($done,@tmp) = $self->_parse_dow($string,$noupdate);
            if (@tmp) {
               if ($done) {
                  ($y,$m,$d) = @tmp;
                  last PARSE;
               } else {
                  ($string,$dow) = @tmp;
               }
            }
            $dow = 0  if (! $dow);
         }
      }

      # Parse common dates

      unless (exists $opts{'nocommon'}) {
         (@tmp) = $self->_parse_date_common($string,$noupdate);
         if (@tmp) {
            ($y,$m,$d) = @tmp;
            last PARSE;
         }
      }

      # Parse less common dates

      unless (exists $opts{'noother'}) {
         (@tmp) = $self->_parse_date_other($string,$dow,$noupdate);
         if (@tmp) {
            ($y,$m,$d,$dow) = @tmp;
            last PARSE;
         }
      }

      return ();
   }

   return($y,$m,$d,$dow);
}

sub parse_format {
   my($self,$format,$string) = @_;
   $self->_init();
   my $noupdate = 0;

   if (! $string) {
      $$self{'err'} = '[parse_format] Empty date string';
      return 1;
   }

   my $dmb = $$self{'objs'}{'base'};
   my $dmt = $$self{'objs'}{'tz'};

   my($err,$re) = $self->_format_regexp($format);
   return $err  if ($err);
   return 1     if ($string !~ $re);

   my($y,$m,$d,$h,$mn,$s,
      $mon_name,$mon_abb,$dow_name,$dow_abb,$dow_char,$dow_num,
      $doy,$nth,$ampm,$epochs,$epocho,
      $tzstring,$off,$abb,$zone,
      $g,$w,$l,$u) =
        @+{qw(y m d h mn s
              mon_name mon_abb dow_name dow_abb dow_char dow_num doy
              nth ampm epochs epocho tzstring off abb zone g w l u)};

   while (1) {
      # Get y/m/d/h/mn/s from:
      #     $epochs,$epocho

      if (defined($epochs)) {
         ($y,$m,$d,$h,$mn,$s) = @{ $dmb->secs_since_1970($epochs) };
         my $z;
         if ($zone) {
            $z = $dmt->_zone($zone);
            return 'Invalid zone'  if (! $z);
         } elsif ($abb  ||  $off) {
            $z = $dmt->zone($off,$abb);
            return 'Invalid zone'  if (! $z);
         } else {
            ($z) = $dmb->_now('tz',$noupdate);
            $noupdate = 1;
         }
         ($y,$m,$d,$h,$mn,$s) =
           @{ $dmb->convert_from_gmt([$y,$m,$d,$h,$mn,$s],$z) };
         last;
      }

      if (defined($epocho)) {
         ($y,$m,$d,$h,$mn,$s) = @{ $dmb->secs_since_1970($epocho) };
         last;
      }

      # Get y/m/d from:
      #     $y,$m,$d,
      #     $mon_name,$mon_abb
      #     $doy,$nth
      #     $g/$w,$l/$u

      if ($mon_name) {
         $m = $$dmb{'data'}{'wordmatch'}{'month_name'}{lc($mon_name)};
      } elsif ($mon_abb) {
         $m = $$dmb{'data'}{'wordmatch'}{'month_abb'}{lc($mon_abb)};
      }

      if ($nth) {
         $d = $$dmb{'data'}{'wordmatch'}{'nth'}{lc($nth)};
      }

      if ($doy) {
         ($y) = $dmb->_now('y',$noupdate)  if (! $y);
         $noupdate = 1;
         ($y,$m,$d) = @{ $dmb->day_of_year($y,$doy) };

      } elsif ($g) {
         ($y) = $dmb->_now('y',$noupdate)  if (! $y);
         $noupdate = 1;
         ($y,$m,$d) = @{ $dmb->_week_of_year($g,$w,1) };

      } elsif ($l) {
         ($y) = $dmb->_now('y',$noupdate)  if (! $y);
         $noupdate = 1;
         ($y,$m,$d) = @{ $dmb->_week_of_year($l,$u,7) };

      } elsif ($m) {
         ($y,$m,$d) = $self->_def_date($y,$m,$d,\$noupdate);
      }

      # Get h/mn/s from:
      #     $h,$mn,$s,$ampm

      if ($h) {
         ($h,$mn,$s) = $self->_def_time($h,$mn,$s,\$noupdate);
      }

      if ($ampm) {
         if ($$dmb{'data'}{'wordmatch'}{'ampm'}{lc($ampm)} == 2) {
            # pm times
            $h+=12  unless ($h==12);
         } else {
            # am times
            $h=0  if ($h==12);
         }
      }

      # Get dow from:
      #     $dow_name,$dow_abb,$dow_char,$dow_num

      if ($dow_name) {
         $dow_num = $$dmb{'data'}{'wordmatch'}{'day_name'}{lc($dow_name)};
      } elsif ($dow_abb) {
         $dow_num = $$dmb{'data'}{'wordmatch'}{'day_abb'}{lc($dow_abb)};
      } elsif ($dow_char) {
         $dow_num = $$dmb{'data'}{'wordmatch'}{'day_char'}{lc($dow_char)};
      }

      last;
   }

   if (! $m) {
      ($y,$m,$d) = $dmb->_now('now',$noupdate);
      $noupdate = 1;
   }
   if (! $h) {
      ($h,$mn,$s) = (0,0,0);
   }

   $$self{'data'}{'set'} = 2;
   return $self->_parse_check('parse_format',$string,
                              $y,$m,$d,$h,$mn,$s,$dow_num,
                              $tzstring,$zone,$abb,$off);
}

sub _format_regexp {
   my($self,$format) = @_;
   my $dmb = $$self{'objs'}{'base'};
   my $dmt = $$self{'objs'}{'tz'};

   if (exists $$dmb{'data'}{'format'}{$format}) {
      return @{ $$dmb{'data'}{'format'}{$format} };
   }

   my $re;
   my $err;
   my($y,$m,$d,$h,$mn,$s) = (0,0,0,0,0,0);
   my($dow,$ampm,$zone,$G,$W,$L,$U) = (0,0,0,0,0,0,0);

   while ($format) {
      last  if ($format eq '%');

      if ($format =~ s/^([^%]+)//) {
         $re .= $1;
         next;
      }

      $format =~ s/^%(.)//;
      my $f = $1;

      given ($f) {

         when (['Y','y','s','o','G','L']) {
            if ($y) {
               $err = 'Year specified multiple times';
               last;
            }
            $y = 1;
            continue ;
         }

         when (['m','f','b','h','B','j','s','o','W','U']) {
            if ($m) {
               $err = 'Month specified multiple times';
               last;
            }
            $m = 1;
            continue ;
         }

         when (['j','d','e','E','s','o','W','U']) {
            if ($d) {
               $err = 'Day specified multiple times';
               last;
            }
            $d = 1;
            continue ;
         }

         when (['H','I','k','i','s','o']) {
            if ($h) {
               $err = 'Hour specified multiple times';
               last;
            }
            $h = 1;
            continue ;
         }

         when (['M','s','o']) {
            if ($mn) {
               $err = 'Minutes specified multiple times';
               last;
            }
            $mn = 1;
            continue ;
         }

         when (['S','s','o']) {
            if ($s) {
               $err = 'Seconds specified multiple times';
               last;
            }
            $s = 1;
            continue ;
         }

         when (['v','a','A','w']) {
            if ($dow) {
               $err = 'Day-of-week specified multiple times';
               last;
            }
            $dow = 1;
            continue ;
         }

         when (['p','s','o']) {
            if ($ampm) {
               $err = 'AM/PM specified multiple times';
               last;
            }
            $ampm = 1;
            continue ;
         }

         when (['Z','z','N']) {
            if ($zone) {
               $err = 'Zone specified multiple times';
               last;
            }
            $zone = 1;
            continue ;
         }

         when (['G']) {
            if ($G) {
               $err = 'G specified multiple times';
               last;
            }
            $G = 1;
            continue ;
         }

         when (['W']) {
            if ($W) {
               $err = 'W specified multiple times';
               last;
            }
            $W = 1;
            continue ;
         }

         when (['L']) {
            if ($L) {
               $err = 'L specified multiple times';
               last;
            }
            $L = 1;
            continue ;
         }

         when (['U']) {
            if ($U) {
               $err = 'U specified multiple times';
               last;
            }
            $U = 1;
            continue ;
         }

         ###

         when ('Y') {
            $re .= '(?<y>\d\d\d\d)';
         }
         when ('y') {
            $re .= '(?<y>\d\d)';
         }

         when ('m') {
            $re .= '(?<m>\d\d)';
         }
         when ('f') {
            $re .= '(?:(?<m>\d\d)| (?<m>\d))';
         }

         when (['b','h','B']) {
            my $abb = $$dmb{'data'}{'rx'}{'month_abb'}[0];
            my $nam = $$dmb{'data'}{'rx'}{'month_name'}[0];
            $re .= "(?:(?<mon_name>$nam)|(?<mon_abb>$abb))";
         }

         when ('j') {
            $re .= '(?<doy>\d\d\d)';
         }

         when ('d') {
            $re .= '(?<d>\d\d)';
         }
         when ('e') {
            $re .= '(?:(?<d>\d\d)| ?(?<d>\d))';
         }

         when (['v','a','A']) {
            my $abb  = $$dmb{'data'}{'rx'}{'day_abb'}[0];
            my $name = $$dmb{'data'}{'rx'}{'day_name'}[0];
            my $char = $$dmb{'data'}{'rx'}{'day_char'}[0];
            $re .= "(?:(?<dow_name>$name)|(?<dow_abb>$abb)|(?<dow_char>$char))";
         }

         when ('w') {
            $re .= '(?<dow_num>[1-7])';
         }

         when ('E') {
            my $nth = $$dmb{'data'}{'rx'}{'nth'}[0];
            $re .= "(?<nth>$nth)"
         }

         when (['H','I']) {
            $re .= '(?<h>\d\d)';
         }
         when (['k','i']) {
            $re .= '(?:(?<h>\d\d)| (?<h>\d))';
         }

         when ('p') {
            my $ampm = $$dmb{data}{rx}{ampm}[0];
            $re .= "(?<ampm>$ampm)";
         }

         when ('M') {
            $re .= '(?<mn>\d\d)';
         }
         when ('S') {
            $re .= '(?<s>\d\d)';
         }

         when (['Z','z','N']) {
            $re .= $dmt->_zrx();
         }

         when ('s') {
            $re .= '(?<epochs>\d+)';
         }
         when ('o') {
            $re .= '(?<epocho>\d+)';
         }

         when ('G') {
            $re .= '(?<g>\d\d\d\d)';
         }
         when ('W') {
            $re .= '(?<w>\d\d)';
         }
         when ('L') {
            $re .= '(?<l>\d\d\d\d)';
         }
         when ('U') {
            $re .= '(?<u>\d\d)';
         }

         when ('c') {
            $format = '%a %b %e %H:%M:%S %Y' . $format;
         }
         when (['C','u']) {
            $format = '%a %b %e %H:%M:%S %Z %Y' . $format;
         }
         when ('g') {
            $format = '%a, %d %b %Y %H:%M:%S %Z' . $format;
         }
         when ('D') {
            $format = '%m/%d/%y' . $format;
         }
         when ('r') {
            $format = '%I:%M:%S %p' . $format;
         }
         when ('R') {
            $format = '%H:%M' . $format;
         }
         when (['T','X']) {
            $format = '%H:%M:%S' . $format;
         }
         when ('V') {
            $format = '%m%d%H%M%y' . $format;
         }
         when ('Q') {
            $format = '%Y%m%d' . $format;
         }
         when ('q') {
            $format = '%Y%m%d%H%M%S' . $format;
         }
         when ('P') {
            $format = '%Y%m%d%H:%M:%S' . $format;
         }
         when ('O') {
            $format = '%Y\\-%m\\-%dT%H:%M:%S' . $format;
         }
         when ('F') {
            $format = '%A, %B %e, %Y' . $format;
         }
         when ('K') {
            $format = '%Y-%j' . $format;
         }
         when ('J') {
            $format = '%G-W%W-%w' . $format;
         }

         when ('x') {
            if ($dmb->_config('dateformat') eq 'US') {
               $format = '%m/%d/%y' . $format;
            } else {
               $format = '%d/%m/%y' . $format;
            }
         }

         when ('t') {
            $re .= "\t";
         }
         when ('%') {
            $re .= '%';
         }
         when ('+') {
            $re .= '\\+';
         }
      }
   }

   if ($m != $d) {
      $err = 'Date not fully specified';
   } elsif ( ($h || $mn || $s)  &&  (! $h  ||  ! $mn) ) {
      $err = 'Time not fully specified';
   } elsif ($ampm  &&  ! $h) {
      $err = 'Time not fully specified';
   } elsif ($G != $W) {
      $err = 'G/W must both be specified';
   } elsif ($L != $U) {
      $err = 'L/U must both be specified';
   }

   if ($err) {
      $$dmb{'data'}{'format'}{$format} = [$err];
      return ($err);
   }

   $$dmb{'data'}{'format'}{$format} = [0, qr/$re/i];
   return @{ $$dmb{'data'}{'format'}{$format} };
}

########################################################################
# DATE FORMATS
########################################################################

sub _parse_check {
   my($self,$caller,$instring,
      $y,$m,$d,$h,$mn,$s,$dow,$tzstring,$zone,$abb,$off) = @_;
   my $dmb = $$self{'objs'}{'base'};
   my $dmt = $$self{'objs'}{'tz'};

   # Check day_of_week for validity BEFORE converting 24:00:00 to the
   # next day

   if ($dow) {
      my $tmp = $dmb->day_of_week([$y,$m,$d]);
      if ($tmp != $dow) {
         $$self{'err'} = "[$caller] Day of week invalid";
         return 1;
      }
   }

   # Handle 24:00:00 times.

   if ($h == 24) {
      ($h,$mn,$s) = (0,0,0);
      ($y,$m,$d)  = @{ $dmb->calc_date_days([$y,$m,$d],1) };
   }

   if (! $dmb->check([$y,$m,$d,$h,$mn,$s])) {
      $$self{'err'} = "[$caller] Invalid date";
      return 1;
   }

   # Interpret timezone information and check that date is valid
   # in the timezone.

   my $zonename;
   if (defined($zone)) {
      $zonename = $dmt->_zone($zone);

      if (! $zonename) {
         $$self{'err'} = "[$caller] Unable to determine timezone: $zone";
         return 1;
      }

   } elsif (defined($abb) ||  defined($off)) {
      my (@tmp,$err);
      push(@tmp,[$y,$m,$d,$h,$mn,$s]);
      push(@tmp,$off)     if (defined $off);
      push(@tmp,$abb)     if (defined $abb);
      $zonename = $dmt->zone(@tmp);

      if (! $zonename) {
         $$self{'err'} = 'Unable to determine timezone';
         return 1;
      }

   } else {
      ($zonename) = $dmb->_now('tz',1);
   }

   # Store the date

   $self->set('zdate',$zonename,[$y,$m,$d,$h,$mn,$s]);
   $$self{'data'}{'in'}    = $instring;
   $$self{'data'}{'zin'}   = $zone  if (defined($zone));

   return 0;
}

# Set up the regular expressions for ISO 8601 parsing. Returns the
# requested regexp. $rx can be:
#    cdate    : regular expression for a complete date
#    tdate    : regular expression for a truncated date
#    ctime    : regular expression for a complete time
#    ttime    : regular expression for a truncated time
#    date     : regular expression for a date only
#    time     : regular expression for a time only
#    UNDEF    : regular expression for a valid date and/or time
#
# Date matches are:
#    y m d doy w dow yod c
# Time matches are:
#    h h24 mn s fh fm
#
sub _iso8601_rx {
   my($self,$rx) = @_;
   my $dmb       = $$self{'objs'}{'base'};
   $rx           = '_'  if (! defined $rx);

   return $$dmb{'data'}{'rx'}{'iso'}{$rx}
     if (exists $$dmb{'data'}{'rx'}{'iso'}{$rx});

   given($rx) {

      when (['cdate','tdate']) {
         my $y4  = '(?<y>\d\d\d\d)';
         my $y2  = '(?<y>\d\d)';
         my $m   = '(?<m>\d\d)';
         my $d   = '(?<d>\d\d)';
         my $doy = '(?<doy>\d\d\d)';
         my $w   = '(?<w>\d\d)';
         my $dow = '(?<dow>\d)';
         my $yod = '(?<yod>\d)';
         my $cc  = '(?<c>\d\d)';

         my $cdaterx =
           "${y4}${m}${d}|" .                 # CCYYMMDD
           "${y4}\\-${m}\\-${d}|" .           # CCYY-MM-DD
             "\\-${y2}${m}${d}|" .            # -YYMMDD
             "\\-${y2}\\-${m}\\-${d}|" .      # -YY-MM-DD
             "\\-?${y2}${m}${d}|" .           # YYMMDD
             "\\-?${y2}\\-${m}\\-${d}|" .     # YY-MM-DD
             "\\-\\-${m}\\-?${d}|" .          # --MM-DD   --MMDD
             "\\-\\-\\-${d}|" .               # ---DD

             "${y4}\\-?${doy}|" .             # CCYY-DoY  CCYYDoY
             "\\-?${y2}\\-?${doy}|" .         # YY-DoY    -YY-DoY
                                              # YYDoY     -YYDoY
             "\\-${doy}|" .                   # -DoY

             "${y4}W${w}${dow}|" .            # CCYYWwwD
             "${y4}\\-W${w}\\-${dow}|" .      # CCYY-Www-D
             "\\-?${y2}W${w}${dow}|" .        # YYWwwD    -YYWwwD
             "\\-?${y2}\\-W${w}\\-${dow}|" .  # YY-Www-D  -YY-Www-D

             "\\-?${yod}W${w}${dow}|" .       # YWwwD     -YWwwD
             "\\-?${yod}\\-W${w}\\-${dow}|" . # Y-Www-D   -Y-Www-D
             "\\-W${w}\\-?${dow}|" .          # -Www-D    -WwwD
             "\\-W\\-${dow}|" .               # -W-D
             "\\-\\-\\-${dow}";               # ---D
         $cdaterx = qr/(?:$cdaterx)/i;

         my $tdaterx =
           "${y4}\\-${m}|" .                  # CCYY-MM
           "${y4}|" .                         # CCYY
           "\\-${y2}\\-?${m}|" .              # -YY-MM    -YYMM
           "\\-${y2}|" .                      # -YY
           "\\-\\-${m}|" .                    # --MM

           "${y4}\\-?W${w}|" .                # CCYYWww   CCYY-Www
           "\\-?${y2}\\-?W${w}|" .            # YY-Www    YYWww
                                              # -YY-Www   -YYWww
           "\\-?W${w}|" .                     # -Www      Www

           "${cc}";                           # CC
         $tdaterx = qr/(?:$tdaterx)/i;

         $$dmb{'data'}{'rx'}{'iso'}{'cdate'} = $cdaterx;
         $$dmb{'data'}{'rx'}{'iso'}{'tdate'} = $tdaterx;
      }

      when (['ctime','ttime']) {
         my $hh     = '(?<h>[0-1][0-9]|2[0-3])';
         my $mn     = '(?<mn>[0-5][0-9])';
         my $ss     = '(?<s>[0-5][0-9])';
         my $h24a   = '(?<h24>24(?::00){0,2})';
         my $h24b   = '(?<h24>24(?:00){0,2})';

         my $fh     = '(?:[\.,](?<fh>\d*))'; # fractional hours (keep)
         my $fm     = '(?:[\.,](?<fm>\d*))'; # fractional seconds (keep)
         my $fs     = '(?:[\.,]\d*)'; # fractional hours (discard)

         my $dmt    = $$self{'objs'}{'tz'};
         my $zrx    = $dmt->_zrx();

         my $ctimerx =
           "${hh}${mn}${ss}${fs}?|" .         # HHMNSS[,S+]
           "${hh}:${mn}:${ss}${fs}?|" .       # HH:MN:SS[,S+]
           "${hh}:?${mn}${fm}|" .             # HH:MN,M+       HHMN,M+
           "${hh}${fh}|" .                    # HH,H+
           "\\-${mn}:?${ss}${fs}?|" .         # -MN:SS[,S+]    -MNSS[,S+]
           "\\-${mn}${fm}|" .                 # -MN,M+
           "\\-\\-${ss}${fs}?|" .             # --SS[,S+]
           "${hh}:?${mn}|" .                  # HH:MN          HHMN
           "${h24a}|" .                       # 24:00:00       24:00       24
           "${h24b}";                         # 240000         2400
         $ctimerx = qr/(?:$ctimerx)(?:\s*$zrx)?/;

         my $ttimerx =
           "${hh}|" .                         # HH
           "\\-${mn}";                        # -MN
         $ttimerx = qr/(?:$ttimerx)/;

         $$dmb{'data'}{'rx'}{'iso'}{'ctime'} = $ctimerx;
         $$dmb{'data'}{'rx'}{'iso'}{'ttime'} = $ttimerx;
      }

      when ('date') {
         my $cdaterx = $self->_iso8601_rx('cdate');
         my $tdaterx = $self->_iso8601_rx('tdate');
         $$dmb{'data'}{'rx'}{'iso'}{'date'} = qr/(?:$cdaterx|$tdaterx)/;
      }

      when ('time') {
         my $ctimerx = $self->_iso8601_rx('ctime');
         my $ttimerx = $self->_iso8601_rx('ttime');
         $$dmb{'data'}{'rx'}{'iso'}{'time'} = qr/(?:$ctimerx|$ttimerx)/;
      }

      default {
         # A parseable string contains:
         #   a complete date and complete time
         #   a complete date and truncated time
         #   a truncated date
         #   a complete time
         #   a truncated time

         # If the string contains both a time and date, they may be adjacent
         # or separated by:
         #   whitespace
         #   T (which must be followed by a number)
         #   a dash

         my $cdaterx = $self->_iso8601_rx('cdate');
         my $tdaterx = $self->_iso8601_rx('tdate');
         my $ctimerx = $self->_iso8601_rx('ctime');
         my $ttimerx = $self->_iso8601_rx('ttime');

         my $sep     = qr/(?:T|\-|\s*)/i;

         my $daterx  = qr/^\s*(?: $cdaterx(?:$sep(?:$ctimerx|$ttimerx))? |
                             $tdaterx |
                             $ctimerx |
                             $ttimerx
                          )\s*$/x;

         $$dmb{'data'}{'rx'}{'iso'}{'_'} = $daterx;
      }
   }

   return $$dmb{'data'}{'rx'}{'iso'}{$rx};
}

sub _parse_datetime_iso8601 {
   my($self,$string,$noupdate) = @_;
   my $dmb           = $$self{'objs'}{'base'};
   my $daterx        = $self->_iso8601_rx();

   my($y,$m,$d,$h,$mn,$s,$tzstring,$zone,$abb,$off);
   my($doy,$dow,$yod,$c,$w,$fh,$fm,$h24);

   if ($string =~ $daterx) {
      ($y,$m,$d,$h,$mn,$s,$doy,$dow,$yod,$c,$w,$fh,$fm,$h24,
       $tzstring,$zone,$abb,$off) =
         @+{qw(y m d h mn s doy dow yod c w fh fm h24 tzstring zone abb off)};

      if (defined $w  ||  defined $dow) {
         ($y,$m,$d)   = $self->_def_date_dow($y,$w,$dow,$noupdate);
      } elsif (defined $doy) {
         ($y,$m,$d) = $self->_def_date_doy($y,$doy,$noupdate);
      } else {
         $y = $c . '00'  if (defined $c);
         ($y,$m,$d) = $self->_def_date($y,$m,$d,$noupdate);
      }

      ($h,$mn,$s) = $self->_time($h,$mn,$s,$fh,$fm,$h24,undef,$noupdate);
   } else {
      return (0);
   }

   return (1,$y,$m,$d,$h,$mn,$s,$tzstring,$zone,$abb,$off);
}

sub _parse_date_iso8601 {
   my($self,$string,$noupdate) = @_;
   my $dmb           = $$self{'objs'}{'base'};
   my $daterx        = $self->_iso8601_rx('date');

   my($y,$m,$d);
   my($doy,$dow,$yod,$c,$w);

   if ($string =~ /^$daterx$/) {
      ($y,$m,$d,$doy,$dow,$yod,$c,$w) =
        @+{qw(y m d doy dow yod c w)};

      if (defined $w  ||  defined $dow) {
         ($y,$m,$d)   = $self->_def_date_dow($y,$w,$dow,$noupdate);
      } elsif (defined $doy) {
         ($y,$m,$d) = $self->_def_date_doy($y,$doy,$noupdate);
      } else {
         $y = $c . '00'  if (defined $c);
         ($y,$m,$d) = $self->_def_date($y,$m,$d,$noupdate);
      }
   } else {
      return (0);
   }

   return (1,$y,$m,$d);
}

# Handle all of the time fields.
#
no integer;
sub _time {
   my($self,$h,$mn,$s,$fh,$fm,$h24,$ampm,$noupdate) = @_;

   if (defined($ampm)  &&  $ampm) {
      my $dmb = $$self{'objs'}{'base'};
      if ($$dmb{'data'}{'wordmatch'}{'ampm'}{lc($ampm)} == 2) {
         # pm times
         $h+=12  unless ($h==12);
      } else {
         # am times
         $h=0  if ($h==12);
      }
   }

   if (defined $h24) {
      return(24,0,0);
   } elsif (defined $fh  &&  $fh ne "") {
      $fh = "0.$fh";
      $s  = int($fh * 3600);
      $mn = int($s/60);
      $s -= $mn*60;
   } elsif (defined $fm  &&  $fm ne "") {
      $fm = "0.$fm";
      $s  = int($fm*60);
   }
   ($h,$mn,$s) = $self->_def_time($h,$mn,$s,$noupdate);
   return($h,$mn,$s);
}
use integer;

# Set up the regular expressions for other date and time formats. Returns the
# requested regexp.
#
sub _other_rx {
   my($self,$rx) = @_;
   my $dmb       = $$self{'objs'}{'base'};
   $rx           = '_'  if (! defined $rx);

   if ($rx eq 'time') {

      my $h24    = '(2[0-3]|1[0-9]|0?[0-9])'; # 0-23      00-23
      my $h12    = '(1[0-2]|0?[1-9])';        # 1-12      01-12
      my $mn     = '([0-5][0-9])';            # 00-59
      my $ss     = '([0-5][0-9])';            # 00-59

      # how to express fractions

      my($f1,$f2,$sepfr);
      if (exists $$dmb{'data'}{'rx'}{'sepfr'}  &&
          $$dmb{'data'}{'rx'}{'sepfr'}) {
         $sepfr = $$dmb{'data'}{'rx'}{'sepfr'};
      } else {
         $sepfr = '';
      }

      if ($sepfr) {
         $f1 = "(?:[.,]|$sepfr)";
         $f2 = "(?:[.,:]|$sepfr)";
      } else {
         $f1 = "[.,]";
         $f2 = "[.,:]";
      }
      my $fh     = "(?:$f1(\\d*))";  # fractional hours (keep)
      my $fm     = "(?:$f1(\\d*))";  # fractional minutes (keep)
      my $fs     = "(?:$f2\\d*)";    # fractional seconds

      # AM/PM

      my($ampm);
      if (exists $$dmb{'data'}{'rx'}{'ampm'}) {
         $ampm   = "(?:\\s*($$dmb{data}{rx}{ampm}[0]))";
      }

      # H:MN and MN:S separators

      my @hm = (':');
      my @ms = (':');
      if (exists $$dmb{'data'}{'rx'}{'sephm'}   &&
          defined $$dmb{'data'}{'rx'}{'sephm'}  &&
          exists $$dmb{'data'}{'rx'}{'sepms'}   &&
          defined $$dmb{'data'}{'rx'}{'sepms'}) {
         push(@hm,@{ $$dmb{'data'}{'rx'}{'sephm'} });
         push(@ms,@{ $$dmb{'data'}{'rx'}{'sepms'} });
      }

      # How to express the time
      #  matches = (H, FH, MN, FMN, S, AM, TZSTRING, ZONE, ABB, OFF, ABB)

      my @time   = ();
      for (my $i=0; $i<=$#hm; $i++) {
         push(@time,
              "${h12}()$hm[$i]${mn}()$ms[$i]${ss}${fs}?${ampm}?" # H:MN:SS[,S+] [AM]
             )  if ($ampm);
         push(@time,
              "${h24}()$hm[$i]${mn}()$ms[$i]${ss}${fs}?()",      # H:MN:SS[,S+]
              "(24)()$hm[$i](00)()$ms[$i](00)()"                 # 24:00:00
             );
      }
      for (my $i=0; $i<=$#hm; $i++) {
         push(@time,
              "${h12}()$hm[$i]${mn}${fm}()${ampm}?"              # H:MN,M+ [AM]
             ) if ($ampm);
         push(@time,
              "${h24}()$hm[$i]${mn}${fm}()()"                    # H:MN,M+
             );
      }
      push(@time,
           "${h12}${fh}()()()${ampm}?"                           # H,H+ [AM]
          )  if ($ampm);
      push(@time,
           "${h24}${fh}()()()()"                                 # H,H+
          );
      for (my $i=0; $i<=$#hm; $i++) {
         push(@time,
              "${h12}()$hm[$i]${mn}()()${ampm}?"                 # H:MN [AM]
             ) if ($ampm);
         push(@time,
              "${h24}()$hm[$i]${mn}()()()",                      # H:MN
              "(24)()$hm[$i](00)()()()"                          # 24:00
             );
      }
      push(@time,"${h12}()()()()${ampm}") if ($ampm);            # H AM

      my $dmt    = $$self{'objs'}{'tz'};
      my $zrx    = $dmt->_zrx();
      my $timerx = join('|',@time);
      my $at     = $$dmb{'data'}{'rx'}{'at'};
      my $atrx   = qr/(?:^|\s+)(?:$at)\s+/;
      $timerx    = qr/(?:$atrx|^|\s+)(?|$timerx)(?:\s*$zrx)?(?:\s+|$)/i;

      $$dmb{'data'}{'rx'}{'other'}{$rx} = $timerx;

   } elsif ($rx eq 'common_1') {

      # These are of the format M/D/Y

      # Do NOT replace <m> and <y> with a regular expression to
      # match 1-12 since the DateFormat config may reverse the two.
      my $y4  = '(?<y>\d\d\d\d)';
      my $y2  = '(?<y>\d\d)';
      my $m   = '(?<m>\d\d?)';
      my $d   = '(?<d>\d\d?)';
      my $sep = '(?<sep>[\s\.\/\-])';

      my $daterx =
        "${m}${sep}${d}\\k<sep>$y4|" .  # M/D/YYYY
        "${m}${sep}${d}\\k<sep>$y2|" .  # M/D/YY
        "${m}${sep}${d}";               # M/D

      $daterx = qr/^\s*(?:$daterx)\s*$/;
      $$dmb{'data'}{'rx'}{'other'}{$rx} = $daterx;

   } elsif ($rx eq 'common_2') {

      my $abb = $$dmb{'data'}{'rx'}{'month_abb'}[0];
      my $nam = $$dmb{'data'}{'rx'}{'month_name'}[0];

      my $y4  = '(?<y>\d\d\d\d)';
      my $y2  = '(?<y>\d\d)';
      my $m   = '(?<m>\d\d?)';
      my $d   = '(?<d>\d\d?)';
      my $dd  = '(?<d>\d\d)';
      my $mmm = "(?:(?<mmm>$abb)|(?<month>$nam))";
      my $sep = '(?<sep>[\s\.\/\-])';

      my $daterx =
        "${y4}${sep}${m}\\k<sep>$d|" .        # YYYY/M/D

        "${mmm}\\s*${dd}\\s*${y4}|" .         # mmmDDYYYY
        "${mmm}\\s*${dd}\\s*${y2}|" .         # mmmDDYY
        "${mmm}\\s*${d}|" .                   # mmmD
        "${d}\\s*${mmm}\\s*${y4}|" .          # DmmmYYYY
        "${d}\\s*${mmm}\\s*${y2}|" .          # DmmmYY
        "${d}\\s*${mmm}|" .                   # Dmmm
        "${y4}\\s*${mmm}\\s*${d}|" .          # YYYYmmmD

        "${mmm}${sep}${d}\\k<sep>${y4}|" .    # mmm/D/YYYY
        "${mmm}${sep}${d}\\k<sep>${y2}|" .    # mmm/D/YY
        "${mmm}${sep}${d}|" .                 # mmm/D
        "${d}${sep}${mmm}\\k<sep>${y4}|" .    # D/mmm/YYYY
        "${d}${sep}${mmm}\\k<sep>${y2}|" .    # D/mmm/YY
        "${d}${sep}${mmm}|" .                 # D/mmm
        "${y4}${sep}${mmm}\\k<sep>${d}|" .    # YYYY/mmm/D

        "${mmm}${sep}?${d}\\s+${y2}|" .       # mmmD YY      mmm/D YY
        "${mmm}${sep}?${d}\\s+${y4}|" .       # mmmD YYYY    mmm/D YYYY
        "${d}${sep}?${mmm}\\s+${y2}|" .       # Dmmm YY      D/mmm YY
        "${d}${sep}?${mmm}\\s+${y4}|" .       # Dmmm YYYY    D/mmm YYYY

        "${y2}\\s+${mmm}${sep}?${d}|" .       # YY   mmmD    YY   mmm/D
        "${y4}\\s+${mmm}${sep}?${d}|" .       # YYYY mmmD    YYYY mmm/D
        "${y2}\\s+${d}${sep}?${mmm}|" .       # YY   Dmmm    YY   D/mmm
        "${y4}\\s+${d}${sep}?${mmm}";         # YYYY Dmmm    YYYY D/mmm

      $daterx = qr/^\s*(?:$daterx)\s*$/i;
      $$dmb{'data'}{'rx'}{'other'}{$rx} = $daterx;

   } elsif ($rx eq 'dow') {

      my $day_abb  = $$dmb{'data'}{'rx'}{'day_abb'}[0];
      my $day_name = $$dmb{'data'}{'rx'}{'day_name'}[0];

      my $on     = $$dmb{'data'}{'rx'}{'on'};
      my $onrx   = qr/(?:^|\s+)(?:$on)\s+/;
      my $dowrx  = qr/(?:$onrx|^|\s+)(?<dow>$day_name|$day_abb)($|\s+)/i;

      $$dmb{'data'}{'rx'}{'other'}{$rx} = $dowrx;

   } elsif ($rx eq 'ignore') {

      my $of    = $$dmb{'data'}{'rx'}{'of'};

      my $ignrx = qr/(?:^|\s+)(?:$of)(\s+|$)/;
      $$dmb{'data'}{'rx'}{'other'}{$rx} = $ignrx;

   } elsif ($rx eq 'miscdatetime') {

      my $special  = $$dmb{'data'}{'rx'}{'offset_time'}[0];

      $special     = "(?<special>$special)";
      my $secs     = "(?<epoch>[-+]?\\d+)";

      my $daterx   =
        "${special}|" .       # now

        "epoch\\s+$secs";     # epoch SECS

      $daterx = qr/^\s*(?:$daterx)\s*$/i;
      $$dmb{'data'}{'rx'}{'other'}{$rx} = $daterx;

   } elsif ($rx eq 'misc') {

      my $abb      = $$dmb{'data'}{'rx'}{'month_abb'}[0];
      my $nam      = $$dmb{'data'}{'rx'}{'month_name'}[0];
      my $next     = $$dmb{'data'}{'rx'}{'nextprev'}[0];
      my $last     = $$dmb{'data'}{'rx'}{'last'};
      my $yf       = $$dmb{data}{rx}{fields}[1];
      my $mf       = $$dmb{data}{rx}{fields}[2];
      my $wf       = $$dmb{data}{rx}{fields}[3];
      my $df       = $$dmb{data}{rx}{fields}[4];
      my $nth      = $$dmb{'data'}{'rx'}{'nth'}[0];
      my $nth_wom  = $$dmb{'data'}{'rx'}{'nth_wom'}[0];
      my $special  = $$dmb{'data'}{'rx'}{'offset_date'}[0];

      my $y        = '(?:(?<y>\d\d\d\d)|(?<y>\d\d))';
      my $mmm      = "(?:(?<mmm>$abb)|(?<month>$nam))";
      $next        = "(?<next>$next)";
      $last        = "(?<last>$last)";
      $yf          = "(?<field_y>$yf)";
      $mf          = "(?<field_m>$mf)";
      $wf          = "(?<field_w>$wf)";
      $df          = "(?<field_d>$df)";
      my $fld      = "(?:$yf|$mf|$wf)";
      $nth         = "(?<nth>$nth)";
      $nth_wom     = "(?<nth>$nth_wom)";
      $special     = "(?<special>$special)";

      my $daterx   =
        "${mmm}\\s+${nth}\\s*$y?|" .    # Dec 1st [1970]
        "${nth}\\s+${mmm}\\s*$y?|" .    # 1st Dec [1970]
        "$y\\s+${mmm}\\s+${nth}|" .     # 1970 Dec 1st
        "$y\\s+${nth}\\s+${mmm}|" .     # 1970 1st Dec

        "${next}\\s+${fld}|" .          # next year, next month, next week
        "${next}|" .                    # next friday

        "${last}\\s+${mmm}\\s*$y?|" .   # last friday in october 95
        "${last}\\s+${df}\\s+${mmm}\\s*$y?|" .
                                        # last day in october 95
        "${last}\\s*$y?|" .             # last friday in 95

        "${nth_wom}\\s+${mmm}\\s*$y?|" .
                                        # nth DoW in MMM [YYYY]
        "${nth}\\s*$y?|" .              # nth DoW in [YYYY]

        "${nth}\\s+${wf}\\s*$y?|" .     # DoW Nth week [YYYY]
        "${wf}\\s+(?<n>\\d+)\\s*$y?|" . # DoW week N [YYYY]

        "${special}|" .                 # today, tomorrow
        "${special}\\s+${wf}|" .        # today week
                                        #   British: same as 1 week from today

        "${nth}|" .                     # nth

        "${wf}";                        # monday week
                                        #   British: same as 'in 1 week on monday'

      $daterx = qr/^\s*(?:$daterx)\s*$/i;
      $$dmb{'data'}{'rx'}{'other'}{$rx} = $daterx;

   }

   return $$dmb{'data'}{'rx'}{'other'}{$rx};
}

sub _parse_time {
   my($self,$caller,$string,$noupdate,%opts) = @_;
   my $dmb                   = $$self{'objs'}{'base'};

   # Make time substitutions (i.e. noon => 12:00:00)

   unless (exists $opts{'noother'}) {
      my @rx = @{ $$dmb{'data'}{'rx'}{'times'} };
      shift(@rx);
      foreach my $rx (@rx) {
         if ($string =~ $rx) {
            my $repl = $$dmb{'data'}{'wordmatch'}{'times'}{lc($1)};
            $string =~ s/$rx/$repl/g;
         }
      }
   }

   # Check to see if there is a time in the string

   my $timerx = (exists $$dmb{'data'}{'rx'}{'other'}{'time'} ?
                 $$dmb{'data'}{'rx'}{'other'}{'time'} :
                 $self->_other_rx('time'));
   my $got_time = 0;

   my($h,$mn,$s,$fh,$fm,$h24,$ampm,$tzstring,$zone,$abb,$off,$tmp);

   if ($string =~ s/$timerx/ /i) {
      ($h,$fh,$mn,$fm,$s,$ampm,$tzstring,$zone,$abb,$off,$tmp) =
        ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12);

      $off      = $tmp  if (! defined($off));
      $h24      = 1  if ($h == 24  &&  $mn == 0  &&  $s == 0);
      $string   =~ s/\s*$//;
      $got_time = 1;
   }

   # If we called this from $date->parse()
   #    returns the string and a list of time components

   if ($caller eq 'parse') {
      if ($got_time) {
         ($h,$mn,$s) = $self->_time($h,$mn,$s,$fh,$fm,$h24,$ampm,$noupdate);
         return ($got_time,$string,$h,$mn,$s,$tzstring,$zone,$abb,$off);
      } else {
         return (0);
      }
   }

   # If we called this from $date->parse_time()

   if (! $got_time  ||  $string) {
      $$self{'err'} = "[$caller] Invalid time string";
      return ();
   }

   ($h,$mn,$s) = $self->_time($h,$mn,$s,$fh,$fm,$h24,$ampm,$noupdate);
   return ($h,$mn,$s,$tzstring,$zone,$abb,$off);
}

# Parse common dates
sub _parse_date_common {
   my($self,$string,$noupdate) = @_;
   my $dmb           = $$self{'objs'}{'base'};

   # Since we want whitespace to be used as a separator, turn all
   # whitespace into single spaces. This is necessary since the
   # regexps do backreferences to make sure that separators are
   # not mixed.
   $string =~ s/\s+/ /g;

   my $daterx = (exists $$dmb{'data'}{'rx'}{'other'}{'common_1'} ?
                 $$dmb{'data'}{'rx'}{'other'}{'common_1'} :
                 $self->_other_rx('common_1'));

   if ($string =~ $daterx) {
      my($y,$m,$d) = @+{qw(y m d)};

      if ($dmb->_config('dateformat') ne 'US') {
         ($m,$d) = ($d,$m);
      }

      ($y,$m,$d) = $self->_def_date($y,$m,$d,$noupdate);
      return($y,$m,$d);
   }

   $daterx = (exists $$dmb{'data'}{'rx'}{'other'}{'common_2'} ?
              $$dmb{'data'}{'rx'}{'other'}{'common_2'} :
              $self->_other_rx('common_2'));

   if ($string =~ $daterx) {
      my($y,$m,$d,$mmm,$month) = @+{qw(y m d mmm month)};

      if ($mmm) {
         $m = $$dmb{'data'}{'wordmatch'}{'month_abb'}{lc($mmm)};
      } elsif ($month) {
         $m = $$dmb{'data'}{'wordmatch'}{'month_name'}{lc($month)};
      }

      ($y,$m,$d) = $self->_def_date($y,$m,$d,$noupdate);
      return($y,$m,$d);
   }

   return ();
}

sub _parse_dow {
   my($self,$string,$noupdate) = @_;
   my $dmb = $$self{'objs'}{'base'};
   my($y,$m,$d,$dow);

   # Remove the day of week

   my $rx = (exists $$dmb{'data'}{'rx'}{'other'}{'dow'} ?
             $$dmb{'data'}{'rx'}{'other'}{'dow'} :
             $self->_other_rx('dow'));
   if ($string =~ s/$rx/ /) {
      $dow = $+{'dow'};
      $dow = lc($dow);

      $dow = $$dmb{'data'}{'wordmatch'}{'day_abb'}{$dow}
        if (exists $$dmb{'data'}{'wordmatch'}{'day_abb'}{$dow});
      $dow = $$dmb{'data'}{'wordmatch'}{'day_name'}{$dow}
        if (exists $$dmb{'data'}{'wordmatch'}{'day_name'}{$dow});
   } else {
      return (0);
   }

   $string =~ s/\s*$//;

   return (0,$string,$dow)  if ($string);

   # Handle the simple DoW format

   ($y,$m,$d)  = $self->_def_date($y,$m,$d,$noupdate);

   my($w,$dow1);

   ($y,$w)       = $dmb->week_of_year([$y,$m,$d]);  # week of year
   ($y,$m,$d)    = @{ $dmb->week_of_year($y,$w) };  # first day
   $dow1         = $dmb->day_of_week([$y,$m,$d]);   # DoW of first day
   $dow1 -= 7    if ($dow1 > $dow);
   ($y,$m,$d)    = @{ $dmb->calc_date_days([$y,$m,$d],$dow-$dow1) };

   return(1,$y,$m,$d);
}

sub _parse_delta {
   my($self,$string,$dow,$got_time,$h,$mn,$s,$noupdate) = @_;
   my $dmb = $$self{'objs'}{'base'};
   my($y,$m,$d);

   my $delta = $self->new_delta();
   my $err   = $delta->parse($string);

   if (! $err) {
      my($dy,$dm,$dw,$dd,$dh,$dmn,$ds) = @{ $$delta{'data'}{'delta'} };

      if ($got_time  &&
          ($dh != 0  ||  $dmn != 0  ||  $ds != 0)) {
         $$self{'err'} = '[parse] Two times entered or implied';
         return (1);
      }

      if ($got_time) {
         ($y,$m,$d) = $self->_def_date($y,$m,$d,$noupdate);
      } else {
         ($y,$m,$d,$h,$mn,$s) = $dmb->_now('now',$$noupdate);
         $$noupdate = 1;
      }

      my $business = $$delta{'data'}{'business'};
      ($y,$m,$d,$h,$mn,$s) =
        @{ $self->__calc_date_delta($business,[$y,$m,$d,$h,$mn,$s],
                                    [$dy,$dm,$dw,$dd,$dh,$dmn,$ds],0) };

      if ($dow) {
         if ($dd != 0  ||  $dh != 0  || $dmn != 0  ||  $ds != 0) {
            $$self{'err'} = '[parse] Day of week not allowed';
            return (1);
         }

         my($w,$dow1);

         ($y,$w)       = $dmb->week_of_year([$y,$m,$d]); # week of year
         ($y,$m,$d)    = @{ $dmb->week_of_year($y,$w) }; # first day
         $dow1         = $dmb->day_of_week([$y,$m,$d]); # DoW of first day
         $dow1 -= 7    if ($dow1 > $dow);
         ($y,$m,$d)    = @{ $dmb->calc_date_days([$y,$m,$d],$dow-$dow1) };
      }

      return (1,$y,$m,$d,$h,$mn,$s);
   }

   return (0);
}

sub _parse_datetime_other {
   my($self,$string,$noupdate) = @_;
   my $dmb           = $$self{'objs'}{'base'};
   my $dmt           = $$self{'objs'}{'tz'};

   my $rx = (exists $$dmb{'data'}{'rx'}{'other'}{'miscdatetime'} ?
                 $$dmb{'data'}{'rx'}{'other'}{'miscdatetime'} :
                 $self->_other_rx('miscdatetime'));

   if ($string =~ $rx) {
      my ($special,$epoch) = @+{qw(special epoch)};

      if (defined($special)) {
         my $delta  = $$dmb{'data'}{'wordmatch'}{'offset_time'}{lc($special)};
         my @delta  = @{ $dmb->split('delta',$delta) };
         my @date   = $dmb->_now('now',$$noupdate);
         $$noupdate = 1;
         @date      = @{ $self->__calc_date_delta(0,[@date],[@delta]) };
         return (1,@date);

      } elsif (defined($epoch)) {
         my $date   = [1970,1,1,0,0,0];
         my @delta  = (0,0,$epoch);
         $date      = $dmb->calc_date_time($date,\@delta);
         my($err);
         ($err,$date) = $dmt->convert_from_gmt($date);
         return (1,@$date);
      }
   }

   return (0);
}

sub _parse_date_other {
   my($self,$string,$dow,$noupdate) = @_;
   my $dmb = $$self{'objs'}{'base'};
   my($y,$m,$d,$h,$mn,$s);

   my $rx = (exists $$dmb{'data'}{'rx'}{'other'}{'misc'} ?
                 $$dmb{'data'}{'rx'}{'other'}{'misc'} :
                 $self->_other_rx('misc'));

   my($mmm,$month,$nextprev,$last,$field_y,$field_m,$field_w,$field_d,$nth);
   my($special,$got_m,$n,$got_y);
   if ($string =~ $rx) {
      ($y,$mmm,$month,$nextprev,$last,$field_y,$field_m,$field_w,$field_d,$nth,
       $special,$n) =
         @+{qw(y mmm month next last field_y field_m field_w field_d nth special n)};

      if (defined($y)) {
         $y     = $dmb->_fix_year($y);
         $got_y = 1;
         return ()  if (! $y);
      } else {
         ($y)  = $dmb->_now('y',$$noupdate);
         $$noupdate = 1;
         $got_y = 0;
         $$self{'data'}{'def'}[0] = '';
      }

      if (defined($mmm)) {
         $m     = $$dmb{'data'}{'wordmatch'}{'month_abb'}{lc($mmm)};
         $got_m = 1;
      } elsif ($month) {
         $m     = $$dmb{'data'}{'wordmatch'}{'month_name'}{lc($month)};
         $got_m = 1;
      }

      if ($nth) {
         $nth   = $$dmb{'data'}{'wordmatch'}{'nth'}{lc($nth)};
      }

      if ($got_m  &&  $nth  &&  ! $dow) {
         # Dec 1st 1970
         # 1st Dec 1970
         # 1970 Dec 1st
         # 1970 1st Dec

         $d = $nth;

      } elsif ($nextprev) {

         my $next = 0;
         my $sign = -1;
         if ($$dmb{'data'}{'wordmatch'}{'nextprev'}{lc($nextprev)} == 1) {
            $next  = 1;
            $sign = 1;
         }

         if ($field_y || $field_m || $field_w) {
            # next/prev year/month/week

            my(@delta);
            if ($field_y) {
               @delta = ($sign*1,0,0,0,0,0,0);
            } elsif ($field_m) {
               @delta = (0,$sign*1,0,0,0,0,0);
            } else {
               @delta = (0,0,$sign*1,0,0,0,0);
            }

            my @now = $dmb->_now('now',$$noupdate);
            $$noupdate = 1;
            ($y,$m,$d,$h,$mn,$s) = @{ $self->__calc_date_delta(0,[@now],[@delta],0) };

         } else {
            # next/prev friday

            my @now = $dmb->_now('now',$$noupdate);
            $$noupdate = 1;
            ($y,$m,$d,$h,$mn,$s) = @{ $self->__next_prev(\@now,$next,$dow,0) };
            $dow = 0;
         }

      } elsif ($last) {

         if ($field_d  &&  $got_m) {
            # last day in october 95

            $d = $dmb->days_in_month($y,$m);

         } elsif ($dow  &&  $got_m) {
            # last friday in october 95

            $d = $dmb->days_in_month($y,$m);
            ($y,$m,$d,$h,$mn,$s) =
              @{ $self->__next_prev([$y,$m,$d,0,0,0],0,$dow,1) };
            $dow = 0;

         } elsif ($dow) {
            # last friday in 95

            ($y,$m,$d,$h,$mn,$s) =
              @{ $self->__next_prev([$y,12,31,0,0,0],0,$dow,0) };
         }

      } elsif ($nth  &&  $dow  &&  ! $field_w) {

         if ($got_m) {
            # nth DoW in MMM [YYYY]
            $d = 1;
            ($y,$m,$d,$h,$mn,$s) = @{ $self->__next_prev([$y,$m,1,0,0,0],1,$dow,1) };
            ($y,$m,$d) = @{ $dmb->calc_date_days([$y,$m,$d],7*($nth-1)) }  if ($nth > 1);

         } else {
            # nth DoW [in YYYY]

            ($y,$m,$d,$h,$mn,$s) = @{ $self->__next_prev([$y,1,1,0,0,0],1,$dow,1) };
            ($y,$m,$d) = @{ $dmb->calc_date_days([$y,$m,$d],7*($nth-1)) }  if ($nth > 1);
         }

      } elsif ($field_w  &&  $dow) {

         if (defined($n)  ||  $nth) {
            # sunday week 22 in 1996
            # sunday 22nd week in 1996

            $n = $nth  if ($nth);
            return ()  if (! $n);
            ($y,$m,$d) = @{ $dmb->week_of_year($y,$n) };
            ($y,$m,$d) = @{ $self->__next_prev([$y,$m,$d,0,0,0],1,$dow,1) };

         } else {
            # DoW week

            ($y,$m,$d) = $dmb->_now('now',$$noupdate);
            $$noupdate = 1;
            my $tmp    = $dmb->_config('firstday');
            ($y,$m,$d) = @{ $self->__next_prev([$y,$m,$d,0,0,0],1,$tmp,0) };
            ($y,$m,$d) = @{ $self->__next_prev([$y,$m,$d,0,0,0],1,$dow,1) };
         }

      } elsif ($nth  &&  ! $got_y) {
         ($y,$m,$d)    = $dmb->_now('now',$$noupdate);
         $$noupdate    = 1;
         $d            = $nth;

      } elsif ($special) {

         my $delta  = $$dmb{'data'}{'wordmatch'}{'offset_date'}{lc($special)};
         my @delta  = @{ $dmb->split('delta',$delta) };
         ($y,$m,$d) = $dmb->_now('now',$$noupdate);
         $$noupdate = 1;
         ($y,$m,$d) = @{ $self->__calc_date_delta(0,[$y,$m,$d,0,0,0],[@delta]) };

         if ($field_w) {
            ($y,$m,$d) = @{ $dmb->calc_date_days([$y,$m,$d],7) };
         }
      }

   } else {
      return ();
   }

   return($y,$m,$d,$dow);
}

# Supply defaults for missing values (Y/M/D)
sub _def_date {
   my($self,$y,$m,$d,$noupdate) = @_;
   $y                 = ''  if (! defined $y);
   $m                 = ''  if (! defined $m);
   $d                 = ''  if (! defined $d);
   my $defined        = 0;
   my $dmb            = $$self{'objs'}{'base'};

   # If year was not specified, defaults to current year.
   #
   # We'll also fix the year (turn 2-digit into 4-digit).

   if ($y eq '') {
      ($y)       = $dmb->_now('y',$$noupdate);
      $$noupdate = 1;
      $$self{'data'}{'def'}[0] = '';
   } else {
      $y       = $dmb->_fix_year($y);
      $defined = 1;
   }

   # If the month was not specifed, but the year was, a default of
   # 01 is supplied (this is a truncated date).
   #
   # If neither was specified, month defaults to the current month.

   if ($m ne '') {
      $defined = 1;
   } elsif ($defined) {
      $m = 1;
      $$self{'data'}{'def'}[1] = 1;
   } else {
      ($m) = $dmb->_now('m',$$noupdate);
      $$noupdate = 1;
      $$self{'data'}{'def'}[1] = '';
   }

   # If the day was not specified, but the year or month was, a default
   # of 01 is supplied (this is a truncated date).
   #
   # If none were specified, it default to the current day.

   if ($d ne '') {
      $defined = 1;
   } elsif ($defined) {
      $d = 1;
      $$self{'data'}{'def'}[2] = 1;
   } else {
      ($d) = $dmb->_now('d',$$noupdate);
      $$noupdate = 1;
      $$self{'data'}{'def'}[2] = '';
   }

   return($y,$m,$d);
}

# Supply defaults for missing values (Y/DoY)
sub _def_date_doy {
   my($self,$y,$doy,$noupdate) = @_;
   $y                = ''  if (! defined $y);
   my $dmb           = $$self{'objs'}{'base'};

   # If year was not specified, defaults to current year.
   #
   # We'll also fix the year (turn 2-digit into 4-digit).

   if ($y eq '') {
      ($y) = $dmb->_now('y',$$noupdate);
      $$noupdate = 1;
      $$self{'data'}{'def'}[0] = '';
   } else {
      $y = $dmb->_fix_year($y);
   }

   # DoY must be specified.

   my($m,$d);
   my $ymd = $dmb->day_of_year($y,$doy);

   return @$ymd;
}

# Supply defaults for missing values (YY/Www/D) and (Y/Www/D)
sub _def_date_dow {
   my($self,$y,$w,$dow,$noupdate) = @_;
   $y                   = ''  if (! defined $y);
   $w                   = ''  if (! defined $w);
   $dow                 = ''  if (! defined $dow);
   my $dmb              = $$self{'objs'}{'base'};

   # If year was not specified, defaults to current year.
   #
   # If it was specified and is a single digit, it is the
   # year in the current decade.
   #
   # We'll also fix the year (turn 2-digit into 4-digit).

   if ($y ne '') {
      if (length($y) == 1) {
         my ($tmp) = $dmb->_now('y',$$noupdate);
         $tmp      =~ s/.$/$y/;
         $y        = $tmp;
         $$noupdate = 1;

      } else {
         $y       = $dmb->_fix_year($y);

      }

   } else {
      ($y) = $dmb->_now('y',$$noupdate);
      $$noupdate = 1;
      $$self{'data'}{'def'}[0] = '';
   }

   # If week was not specified, it defaults to the current
   # week. Get the first day of the week.

   my($m,$d);
   if ($w ne '') {
      ($y,$m,$d) = @{ $dmb->week_of_year($y,$w) };
   } else {
      my($nowy,$nowm,$nowd) = $dmb->_now('now',$$noupdate);
      $$noupdate = 1;
      my $noww;
      ($nowy,$noww) = $dmb->week_of_year([$nowy,$nowm,$nowd]);
      ($y,$m,$d)    = @{ $dmb->week_of_year($nowy,$noww) };
   }

   # Handle the DoW

   if ($dow eq '') {
      $dow  = 1;
   }
   my $n    = $dmb->days_in_month($y,$m);
   $d      += ($dow-1);
   if ($d > $n) {
      $m++;
      if ($m==12) {
         $y++;
         $m = 1;
      }
      $d = $d-$n;
   }

   return($y,$m,$d);
}

# Supply defaults for missing values (HH:MN:SS)
sub _def_time {
   my($self,$h,$m,$s,$noupdate) = @_;
   $h                 = ''  if (! defined $h);
   $m                 = ''  if (! defined $m);
   $s                 = ''  if (! defined $s);
   my $defined        = 0;
   my $dmb            = $$self{'objs'}{'base'};

   # If no time was specified, defaults to 00:00:00.

   if ($h eq ''  &&
       $m eq ''  &&
       $s eq '') {
      $$self{'data'}{'def'}[3] = 1;
      $$self{'data'}{'def'}[4] = 1;
      $$self{'data'}{'def'}[5] = 1;
      return(0,0,0);
   }

   # If hour was not specified, defaults to current hour.

   if ($h ne '') {
      $defined = 1;
   } else {
      ($h) = $dmb->_now('h',$$noupdate);
      $$noupdate = 1;
      $$self{'data'}{'def'}[3] = '';
   }

   # If the minute was not specifed, but the hour was, a default of
   # 00 is supplied (this is a truncated time).
   #
   # If neither was specified, minute defaults to the current minute.

   if ($m ne '') {
      $defined = 1;
   } elsif ($defined) {
      $m = 0;
      $$self{'data'}{'def'}[4] = 1;
   } else {
      ($m) = $dmb->_now('mn',$$noupdate);
      $$noupdate = 1;
      $$self{'data'}{'def'}[4] = '';
   }

   # If the second was not specified (either the hour or the minute were),
   # a default of 00 is supplied (this is a truncated time).

   if ($s eq '') {
      $s = 0;
      $$self{'data'}{'def'}[5] = 1;
   }

   return($h,$m,$s);
}

########################################################################
# OTHER DATE METHODS
########################################################################

# Gets the date in the parsed timezone (if $type = ''), local timezone
# (if $type = 'local') or GMT timezone (if $type = 'gmt').
#
# Gets the string value in scalar context, the split value in list
# context.
#
sub value {
   my($self,$type) = @_;
   my $dmb         = $$self{'objs'}{'base'};
   my $dmt         = $$self{'objs'}{'tz'};
   my $date;

   while (1) {
      if (! $$self{'data'}{'set'}) {
         $$self{'err'} = '[value] Object does not contain a date';
         last;
      }

      $type           = ''  if (! $type);

      given($type) {

         when ('gmt') {
            if (! @{ $$self{'data'}{'gmt'} }) {
               my $zone = $$self{'data'}{'tz'};
               my $date = $$self{'data'}{'date'};

               if ($zone eq 'Etc/GMT') {
                  $$self{'data'}{'gmt'}      = $date;

               } else {
                  my $isdst   = $$self{'data'}{'isdst'};
                  my($err,$d) = $dmt->convert_to_gmt($date,$zone,$isdst);
                  if ($err) {
                     $$self{'err'} = '[value] Unable to convert date to GMT';
                     last;
                  }
                  $$self{'data'}{'gmt'}      = $d;
               }
            }
            $date = $$self{'data'}{'gmt'};
         }

         when ('local') {
            if (! @{ $$self{'data'}{'loc'} }) {
               my $zone  = $$self{'data'}{'tz'};
               $date     = $$self{'data'}{'date'};
               my ($local) = $dmb->_now('tz',1);

               if ($zone eq $local) {
                  $$self{'data'}{'loc'}      = $date;

               } else {
                  my $isdst   = $$self{'data'}{'isdst'};
                  my($err,$d) = $dmt->convert_to_local($date,$zone,$isdst);
                  if ($err) {
                     $$self{'err'} = '[value] Unable to convert date to localtime';
                     last;
                  }
                  $$self{'data'}{'loc'}      = $d;
               }
            }
            $date = $$self{'data'}{'loc'};
         }

         default {
            $date = $$self{'data'}{'date'};
         }
      }

      last;
   }

   if ($$self{'err'}) {
      if (wantarray) {
         return ();
      } else {
         return '';
      }
   }

   if (wantarray) {
      return @$date;
   } else {
      return $dmb->join('date',$date);
   }
}

sub cmp {
   my($self,$date) = @_;
   if ($$self{'err'}  ||  ! $$self{'data'}{'set'}) {
      warn "WARNING: [cmp] Arguments must be valid dates: date1\n";
      return undef;
   }

   if (! ref($date) eq 'Date::Manip::Date') {
      warn "WARNING: [cmp] Argument must be a Date::Manip::Date object\n";
      return undef;
   }
   if ($$date{'err'}  ||  ! $$date{'data'}{'set'}) {
      warn "WARNING: [cmp] Arguments must be valid dates: date2\n";
      return undef;
   }

   my($d1,$d2);
   if ($$self{'data'}{'tz'} eq $$date{'data'}{'tz'}) {
      $d1 = $self->value();
      $d2 = $date->value();
   } else {
      $d1 = $self->value('gmt');
      $d2 = $date->value('gmt');
   }

   return ($d1 cmp $d2);
}

sub set {
   my($self,$field,@val) = @_;
   $field    = lc($field);
   my $dmb   = $$self{'objs'}{'base'};
   my $dmt   = $$self{'objs'}{'tz'};

   # Make sure $self includes a valid date (unless the entire date is
   # being set, in which case it doesn't matter).

   my($date,@def,$tz,$isdst);

   if ($field eq 'zdate') {
      # If {data}{set} = 2, we want to preserve the defaults. Also, we've
      # already initialized.
      #
      # It is only set in the parse routines which means that this was
      # called via _parse_check.

      $self->_init()  if ($$self{'data'}{'set'} != 2);
      @def = @{ $$self{'data'}{'def'} };

   } elsif ($field eq 'date') {
      if ($$self{'data'}{'set'}  &&  ! $$self{'err'}) {
         $tz      = $$self{'data'}{'tz'};
      } else {
         ($tz)    = $dmb->_now('tz',1);
      }
      $self->_init();
      @def = @{ $$self{'data'}{'def'} };

   } else {
      return 1  if ($$self{'err'}  ||  ! $$self{'data'}{'set'});
      $date    = $$self{'data'}{'date'};
      $tz      = $$self{'data'}{'tz'};
      $isdst   = $$self{'data'}{'isdst'};
      @def = @{ $$self{'data'}{'def'} };
      $self->_init();
   }

   # Check the arguments

   my($err,$new_tz,$new_date,$new_time);

   given ($field) {

      when ('zone') {
         if ($#val == -1) {
            # zone
         } elsif ($#val == 0  &&  ($val[0] eq '0'  ||  $val[0] eq '1')) {
            # zone,ISDST
            $isdst = $val[0];
         } elsif ($#val == 0) {
            # zone,ZONE
            $new_tz = $val[0];
         } elsif ($#val == 1) {
            # zone,ZONE,ISDST
            ($new_tz,$isdst) = @val;
         } else {
            $err = 1;
         }
         ($tz) = $dmb->_now('tz',1)  if (! $new_tz);
      }

      when ('zdate') {
         if ($#val == 0) {
            # zdate,DATE
            $new_date = $val[0];
         } elsif ($#val == 1    &&  ($val[1] eq '0'  ||  $val[1] eq '1')) {
            # zdate,DATE,ISDST
            ($new_date,$isdst) = @val;
         } elsif ($#val == 1) {
            # zdate,ZONE,DATE
            ($new_tz,$new_date) = @val;
         } elsif ($#val == 2) {
            # zdate,ZONE,DATE,ISDST
            ($new_tz,$new_date,$isdst) = @val;
         } else {
            $err = 1;
         }
         for (my $i=0; $i<=5; $i++) {
            $def[$i] = 0  if ($def[$i]);
         }
         ($tz) = $dmb->_now('tz',1)  if (! $new_tz);
      }

      when ('date') {
         if ($#val == 0) {
            # date,DATE
            $new_date = $val[0];
         } elsif ($#val == 1) {
            # date,DATE,ISDST
            ($new_date,$isdst) = @val;
         } else {
            $err = 1;
         }
         for (my $i=0; $i<=5; $i++) {
            $def[$i] = 0  if ($def[$i]);
         }
      }

      when ('time') {
         if ($#val == 0) {
            # time,TIME
            $new_time = $val[0];
         } elsif ($#val == 1) {
            # time,TIME,ISDST
            ($new_time,$isdst) = @val;
         } else {
            $err = 1;
         }
         $def[3] = 0  if ($def[3]);
         $def[4] = 0  if ($def[4]);
         $def[5] = 0  if ($def[5]);
      }

      when (['y','m','d','h','mn','s']) {
         my %tmp = qw(y 0 m 1 w 2 d 3 h 4 mn 5 s 6);
         my $i   = $tmp{$field};
         my $val;
         if ($#val == 0) {
            $val = $val[0];
         } elsif ($#val == 1) {
            ($val,$isdst) = @val;
         } else {
            $err = 1;
         }

         $$date[$i] = $val;
         $def[$i]   = 0  if ($def[$i]);
      }

      default {
         $err = 2;
      }
   }

   if ($err) {
      if ($err == 1) {
         $$self{'err'} = '[set] Invalid arguments';
      } else {
         $$self{'err'} = '[set] Invalid field';
      }
      return 1;
   }

   # Handle the arguments

   if ($new_tz) {
      my $tmp = $dmt->_zone($new_tz);
      if ($tmp) {
         # A zone/alias
         $tz = $tmp;

      } else {
         # An offset
         my ($err,@args);
         push(@args,$date)  if ($date);
         push(@args,$new_tz);
         push(@args,($isdst ? 'dstonly' : 'stdonly'))  if (defined $isdst);
         $tz = $dmb->zone(@args);

         if (! $tz) {
            $$self{'err'} = "[set] Invalid timezone argument: $new_tz";
            return 1;
         }
      }
   }

   if ($new_date) {
      if ($dmb->check($new_date)) {
         $date = $new_date;
      } else {
         $$self{'err'} = '[set] Invalid date argument';
         return 1;
      }
   }

   if ($new_time) {
      if ($dmb->check_time($new_time)) {
         $$date[3] = $$new_time[0];
         $$date[4] = $$new_time[1];
         $$date[5] = $$new_time[2];
      } else {
         $$self{'err'}     = '[set] Invalid time argument';
         return 1;
      }
   }

   # Check the date/timezone combination

   my($abb,$off);
   if ($tz eq 'etc/gmt') {
      $abb                 = 'GMT';
      $off                 = [0,0,0];
      $isdst               = 0;
   } else {
      my $per              = $dmt->date_period($date,$tz,1,$isdst);
      if (! $per) {
         $$self{'err'} = '[set] Invalid date/timezone';
         return 1;
      }
      $isdst               = $$per[5];
      $abb                 = $$per[4];
      $off                 = $$per[3];
   }

   # Set the information

   $$self{'data'}{'set'}   = 1;
   $$self{'data'}{'date'}  = $date;
   $$self{'data'}{'tz'}    = $tz;
   $$self{'data'}{'isdst'} = $isdst;
   $$self{'data'}{'offset'}= $off;
   $$self{'data'}{'abb'}   = $abb;
   $$self{'data'}{'def'}   = [ @def ];

   return 0;
}

########################################################################
# NEXT/PREV METHODS

sub prev {
   my($self,@args) = @_;
   return 1  if ($$self{'err'}  ||  ! $$self{'data'}{'set'});
   my $date        = $$self{'data'}{'date'};

   $date           = $self->__next_prev($date,0,@args);

   return 1  if (! defined($date));
   $self->set('date',$date);
   return 0;
}

sub next {
   my($self,@args) = @_;
   return 1  if ($$self{'err'}  ||  ! $$self{'data'}{'set'});
   my $date        = $$self{'data'}{'date'};

   $date           = $self->__next_prev($date,1,@args);

   return 1  if (! defined($date));
   $self->set('date',$date);
   return 0;
}

sub __next_prev {
   my($self,$date,$next,$dow,$curr,$time) = @_;

   my ($caller,$sign,$prev);
   if ($next) {
      $caller = 'next';
      $sign   = 1;
      $prev   = 0;
   } else {
      $caller = 'prev';
      $sign   = -1;
      $prev   = 1;
   }

   my $dmb  = $$self{'objs'}{'base'};
   my $orig = [ @$date ];

   # Check the time (if any)

   if (defined($time)) {
      if ($dow) {
         # $time will refer to a full [H,MN,S]
         my($err,$h,$mn,$s) = $dmb->_normalize_hms('norm',@$time);
         if ($err) {
            $$self{'err'} = "[$caller] invalid time argument";
            return undef;
         }
         $time = [$h,$mn,$s];
      } else {
         # $time may have leading undefs
         my @tmp = @$time;
         if ($#tmp != 2) {
            $$self{'err'} = "[$caller] invalid time argument";
            return undef;
         }
         my($h,$mn,$s) = @$time;
         if (defined($h)) {
            $mn = 0  if (! defined($mn));
            $s  = 0  if (! defined($s));
         } elsif (defined($mn)) {
            $s  = 0  if (! defined($s));
         } else {
            $s  = 0  if (! defined($s));
         }
         $time = [$h,$mn,$s];
      }
   }

   # Find the next DoW

   if ($dow) {

      if (! $dmb->_is_int($dow,1,7)) {
         $$self{'err'} = "[$caller] Invalid DOW: $dow";
         return undef;
      }

      # Find the next/previous occurrence of DoW

      my $curr_dow = $dmb->day_of_week($date);
      my $adjust   = 0;

      if ($dow == $curr_dow) {
         $adjust = 1  if ($curr == 0);

      } else {
         my $num;
         if ($next) {
            # force $dow to be more than $curr_dow
            $dow += 7  if ($dow<$curr_dow);
            $num  = $dow - $curr_dow;
         } else {
            # force $dow to be less than $curr_dow
            $dow -= 7  if ($dow>$curr_dow);
            $num  = $curr_dow - $dow;
            $num *= -1;
         }

         # Add/subtract $num days
         $date = $dmb->calc_date_days($date,$num);
      }

      if (defined($time)) {
         my ($y,$m,$d,$h,$mn,$s) = @$date;
         ($h,$mn,$s)             = @$time;
         $date = [$y,$m,$d,$h,$mn,$s];
      }

      my $cmp = $dmb->cmp($orig,$date);
      $adjust = 1  if ($curr == 2  &&  $cmp != -1*$sign);

      if ($adjust) {
         # Add/subtract 1 week
         $date = $dmb->calc_date_days($date,$sign*7);
      }

      return $date;
   }

   # Find the next Time

   if (defined($time)) {

      my ($h,$mn,$s)    = @$time;
      my $orig          = [ @$date ];

      my $cmp;
      if (defined $h) {
         # Find next/prev HH:MN:SS

         @$date[3..5]   = @$time;
         $cmp           = $dmb->cmp($orig,$date);
         if ($cmp == -1) {
            if ($prev) {
               $date    = $dmb->calc_date_days($date,-1);
            }
         } elsif ($cmp == 1) {
            if ($next) {
               $date    = $dmb->calc_date_days($date,1);
            }
         } else {
            if (! $curr) {
               $date    = $dmb->calc_date_days($date,$sign);
            }
         }

      } elsif (defined $mn) {
         # Find next/prev MN:SS

         @$date[4..5]   = @$time[1..2];

         $cmp           = $dmb->cmp($orig,$date);
         if ($cmp == -1) {
            if ($prev) {
               $date    = $dmb->calc_date_time($date,[-1,0,0]);
            }
         } elsif ($cmp == 1) {
            if ($next) {
               $date    = $dmb->calc_date_time($date,[1,0,0]);
            }
         } else {
            if (! $curr) {
               $date    = $dmb->calc_date_time($date,[$sign,0,0]);
            }
         }

      } else {
         # Find next/prev SS

         $$date[5]      = $$time[2];

         $cmp           = $dmb->cmp($orig,$date);
         if ($cmp == -1) {
            if ($prev) {
               $date    = $dmb->calc_date_time($date,[0,-1,0]);
            }
         } elsif ($cmp == 1) {
            if ($next) {
               $date    = $dmb->calc_date_time($date,[0,1,0]);
            }
         } else {
            if (! $curr) {
               $date    = $dmb->calc_date_time($date,[0,$sign,0]);
            }
         }
      }

      return $date;
   }

   $$self{'err'} = "[$caller] Either DoW or time (or both) required";
   return undef;
}

########################################################################
# CALC METHOD

sub calc {
   my($self,$obj,@args) = @_;
   if ($$self{'err'}  ||  ! $$self{'data'}{'set'}) {
      $$self{'err'} = '[calc] First object invalid (date)';
      return undef;
   }

   if (ref($obj) eq 'Date::Manip::Date') {
      if ($$obj{'err'}  ||  ! $$obj{'data'}{'set'}) {
         $$self{'err'} = '[calc] Second object invalid (date)';
         return undef;
      }
      return $self->_calc_date_date($obj,@args);

   } elsif (ref($obj) eq 'Date::Manip::Delta') {
      if ($$obj{'err'}) {
         $$self{'err'} = '[calc] Second object invalid (delta)';
         return undef;
      }
      return $self->_calc_date_delta($obj,@args);

   } else {
      $$self{'err'} = '[calc] Second object must be a Date/Delta object';
      return undef;
   }
}

sub _calc_date_date {
   my($self,$date,@args) = @_;
   my $ret               = $self->new_delta();

   # Handle subtract/mode arguments

   my($subtract,$mode);

   if ($#args == -1) {
      ($subtract,$mode) = (0,'');
   } elsif ($#args == 0) {
      if ($args[0] eq '0'  ||  $args[0] eq '1') {
         ($subtract,$mode) = ($args[0],'');
      } else {
         ($subtract,$mode) = (0,$args[0]);
      }

   } elsif ($#args == 1) {
      ($subtract,$mode) = @args;
   } else {
      $$ret{'err'} = '[calc] Invalid arguments';
      return $ret;
   }
   $mode   = 'exact'  if (! $mode);

   if ($mode !~ /^(business|bapprox|approx|exact)$/i) {
      $$ret{'err'} = '[calc] Invalid mode argument';
      return $ret;
   }

   # if business mode
   #    dates must be in the same timezone
   #    use dates in that zone
   #
   # otherwise if both dates are in the same timezone  &&  approx mode
   #    use the dates in that zone
   #
   # otherwise
   #    convert to gmt
   #    use those dates

   my($date1,$date2);
   if ($mode eq 'business'  ||  $mode eq 'bapprox') {
      if ($$self{'data'}{'tz'} eq $$date{'data'}{'tz'}) {
         $date1 = [ $self->value() ];
         $date2 = [ $date->value() ];
      } else {
         $$ret{'err'} = '[calc] Dates must be in the same timezone for ' .
           'business mode calculations';
         return $ret;
      }

   } elsif ($mode eq 'approx'  &&
            $$self{'data'}{'tz'} eq $$date{'data'}{'tz'}) {
      $date1 = [ $self->value() ];
      $date2 = [ $date->value() ];

   } else {
      $date1 = [ $self->value('gmt') ];
      $date2 = [ $date->value('gmt') ];
   }

   # Do the calculation

   my(@delta);
   if ($subtract) {
      if ($mode eq 'business'  ||  $mode eq 'exact'  ||  $subtract == 2) {
         @delta = @{ $self->__calc_date_date($mode,$date2,$date1) };
      } else {
         @delta = @{ $self->__calc_date_date($mode,$date1,$date2) };
         @delta = map { -1*$_ } @delta;
      }
   } else {
      @delta = @{ $self->__calc_date_date($mode,$date1,$date2) };
   }

   # Set the signs and save the delta

   for (my $i=0; $i<7; $i++) {
      $delta[$i] = '+'.$delta[$i]  if ($delta[$i]>=0);
   }

   if ($mode eq 'business' || $mode eq 'bapprox') {
      $ret->set('business',\@delta);
   } else {
      $ret->set('delta',\@delta);
   }
   return $ret;
}

sub __calc_date_date {
   my($self,$mode,$date1,$date2) = @_;
   my $dmb                       = $$self{'objs'}{'base'};

   my($y1,$m1,$d1,$h1,$mn1,$s1) = @$date1;
   my($y2,$m2,$d2,$h2,$mn2,$s2) = @$date2;
   my @delta;

   if ($mode eq 'exact'  ||
       $mode eq 'approx') {

      # form the delta for hour/min/sec
      $delta[4] = $h2-$h1;
      $delta[5] = $mn2-$mn1;
      $delta[6] = $s2-$s1;

      # form the delta for yr/mon/wk/day

      if ($mode eq 'exact') {
         $delta[0] = 0;
         $delta[1] = 0;
         $delta[2] = 0;
         $delta[3] = $dmb->days_since_1BC($date2) -
           $dmb->days_since_1BC($date1);
      } else {
         # If $d1 is greater than the number of days allowed in the
         # month $y2/$m2, set it equal to the number of days. In other
         # words:
         #   Jan 31 2006 to Feb 28 2008 = 2 years 1 month
         #
         my $dim   = $dmb->days_in_month($y2,$m2);
         $d1       = $dim  if ($d1 > $dim);

         $delta[0] = $y2-$y1;
         $delta[1] = $m2-$m1;
         $delta[2] = 0;
         $delta[3] = $d2-$d1;
      }

   } else {
      # Business mode (business or bapprox)

      # do yr/mon/wk part

      if ($mode eq 'business') {
         $delta[0] = 0;
         $delta[1] = 0;
         $delta[2] = 0;

      } else {
         $delta[0] = $y2-$y1;
         $delta[1] = $m2-$m1;
         $delta[2] = 0;

         $y1       = $y2;
         $m1       = $m2;
         my $dim   = $dmb->days_in_month($y2,$m2);
         $d1       = $dim  if ($d1 > $dim);
      }

      # make sure both are work days

      ($y1,$m1,$d1,$h1,$mn1,$s1) =
        @{ $self->__nextprev_business_day(0,0,1,[$y1,$m1,$d1,$h1,$mn1,$s1]) };
      ($y2,$m2,$d2,$h2,$mn2,$s2) =
        @{ $self->__nextprev_business_day(0,0,1,[$y2,$m2,$d2,$h2,$mn2,$s2]) };

      # find out which direction we need to move $date1 to get to $date2

      my $dir = 0;
      if ($y1 < $y2) {
         $dir = 1;
      } elsif ($y1 > $y2) {
         $dir = -1;
      } elsif ($m1 < $m2) {
         $dir = 1;
      } elsif ($m1 > $m2) {
         $dir = -1;
      } elsif ($d1 < $d2) {
         $dir = 1;
      } elsif ($d1 > $d2) {
         $dir = -1;
      }

      # now do the day part (to get to the same day)

      $delta[3] = 0;
      while ($dir) {
         ($y1,$m1,$d1) = @{ $dmb->calc_date_days([$y1,$m1,$d1],$dir) };
         $delta[3] += $dir  if ($self->__is_business_day([$y1,$m1,$d1,0,0,0],0));
         $dir = 0  if ($y1 == $y2  &&  $m1 == $m2  &&  $d1 == $d2);
      }

      # both dates are now on a business day, and during business
      # hours, so do the hr/min/sec part trivially

      $delta[4] = $h2-$h1;
      $delta[5] = $mn2-$mn1;
      $delta[6] = $s2-$s1;
   }

   return [ @delta ];
}

sub _calc_date_delta {
   my($self,$delta,$subtract) = @_;

   # Get the date/delta fields

   $subtract        = 0  if (! $subtract);
   my @delta        = @{ $$delta{'data'}{'delta'} };
   my $business     = $$delta{'data'}{'business'};
   my $approx       = 0;
   my ($dy,$dm,$dw) = (@delta);
   $approx          = 1  if ($dy != 0  ||  $dm != 0  ||  ($business && $dw != 0));

   $subtract        = 1  if ($business  &&  $subtract == 2);
   my @date;
   if ($business  ||  $approx) {
      @date = $self->value();
   } else {
      @date = $self->value('gmt');
   }

   my $ret = $self->new_date();

   my $date2;
   if ($approx  &&  $subtract == 2) {
      $date2 = $self->__calc_date_delta_inverse([@date],[@delta]);
      if (! defined($date2)) {
         $$ret{'err'} = '[calc_date_delta] Impossible error (report this please)';
         return $ret;
      }

   } else {
      @delta = map { -1*$_ } @delta  if ($subtract);
      $date2 = $self->__calc_date_delta($business,[@date],[@delta]);
   }

   if ($business || $approx) {
      $ret->set('date',$date2);
   } else {
      $ret->set('zdate','gmt',$date2);
      my $zone = $$self{'data'}{'tz'};
      $ret->convert($zone);
   }
   return $ret;
}

# Do a date+delta calculation on raw data instead of objects
#
sub __calc_date_delta {
   my($self,$business,$date,$delta) = @_;

   my $dmb                          = $$self{'objs'}{'base'};
   my($y,$m,$d,$h,$mn,$s)           = @$date;
   my($dy,$dm,$dw,$dd,$dh,$dmn,$ds) = @$delta;

   #
   # Do the year/month/week part.
   #

   $y += $dy;
   $dmb->_mod_add(-12,$dm,\$m,\$y); # -12 means 1-12 instead of 0-11

   # If we are past the last day of a month, move the date back to
   # the last day of the month. i.e. Jan 31 + 1 month = Feb 28.

   my $dim = $dmb->days_in_month($y,$m);
   $d      = $dim  if ($d > $dim);

   # Do the week part

   if ($business) {
      # In business mode, add the number of weeks exactly ignoring any
      # timezone affects).
      ($y,$m,$d) = @{ $dmb->calc_date_days([$y,$m,$d],$dw*7) }  if ($dw);
   } else {
      $dd       += $dw*7;
   }

   #
   # In business mode, set the day to a work day at this point so the d/h/mn/s
   # stuff will work out
   #

   if ($business) {
      ($y,$m,$d,$h,$mn,$s) =
        @{ $self->__nextprev_business_day(0,0,1,[$y,$m,$d,$h,$mn,$s]) };
   }

   #
   # Do the seconds, minutes, and hours part
   #

   if ($business) {

      my ($hbeg,$mbeg,$sbeg) = @{ $$dmb{'data'}{'calc'}{'workdaybeg'} };
      my ($hend,$mend,$send) = @{ $$dmb{'data'}{'calc'}{'workdayend'} };
      my $bdlen = $$dmb{'data'}{'calc'}{'bdlength'};

      no integer;
      my $tmp;
      $ds += $dh*3600 + $dmn*60;
      $tmp = int($ds/$bdlen);
      $dd += $tmp;
      $ds -= $tmp*$bdlen;
      $dh  = int($ds/3600);
      $ds -= $dh*3600;
      $dmn = int($ds/60);
      $ds -= $dmn*60;
      use integer;

      # At this point, we're adding less than a day for the
      # hours/minutes/seconds part AND we know that the current
      # day is during business hours.
      #
      # We'll add them (without affecting days... we'll need to
      # test things by hand to make sure we should or shouldn't
      # do that.

      $dmb->_mod_add(60,$ds,\$s,\$mn);
      $dmb->_mod_add(60,$dmn,\$mn,\$h);
      $h += $dh;

      if ($h > $hend  ||
          ($h == $hend  &&  $mn > $mend)  ||
          ($h == $hend  &&  $mn == $mend  &&  $s > $send)  ||
          ($h == $hend  &&  $mn == $mend  &&  $s == $send)) {

         # We've gone past the end of the business day.

         my $t2 = $dmb->calc_time_time([$h,$mn,$s],[$hend,$mend,$send],1);
         $d++;
         ($h,$mn,$s) = @{ $dmb->calc_time_time([$hbeg,$mbeg,$sbeg],$t2) };

      } elsif ($h < $hbeg  ||
               ($h == $hbeg  &&  $mn < $mbeg)  ||
               ($h == $hbeg  &&  $mn == $mbeg  &&  $s < $sbeg)) {

         # We've gone back past the start of the business day.

         my $t2 = $dmb->calc_time_time([$hbeg,$mbeg,$sbeg],[$h,$mn,$s],1);
         $dd--;
         ($h,$mn,$s) = @{ $dmb->calc_time_time([$hend,$mend,$send],$t2,1) };
      }

   } else {
      $dmb->_mod_add(60,$ds,\$s,\$mn);
      $dmb->_mod_add(60,$dmn,\$mn,\$h);
      $dmb->_mod_add(24,$dh,\$h,\$d);
   }

   #
   # If we have just gone past the first/last day of the month, we
   # need to make up for this:
   #

   if ($d > $dim) {
      $dd += $d-$dim;
      $d   = $dim;
   } elsif ($d < 1) {
      $dd += $d-1;
      $d   = 1;
   }

   #
   # Now add the days part.
   #

   if ($business) {
      my $prev = 0;
      if ($dd < 1) {
         $prev = 1;
         $dd  *= -1;
      }

      ($y,$m,$d,$h,$mn,$s) =
        @{ $self->__nextprev_business_day($prev,$dd,0,[$y,$m,$d,$h,$mn,$s]) };

   } else {
      ($y,$m,$d) = @{ $dmb->calc_date_days([$y,$m,$d],$dd) };
   }

   return [$y,$m,$d,$h,$mn,$s];
}

# Calculates @date2 such that @date2 + @delta = @date .
#
sub __calc_date_delta_inverse {
   my($self,$date,$delta) = @_;
   my $dmb                = $$self{'objs'}{'base'};

   my @date     = @$date;
   my @delta    = @$delta;

   # @deltasub is an intermediate delta that can be added to @date to
   # hopefully get @date2. Add it to get a first guess for @date2.
   # Then, add the original delta back to get @altdate (which we want
   # to be identical to @date).

   my @deltasub = map { -1*$_ } @$delta;
   my @date2    = @{ $self->__calc_date_delta(0,[@date],[@deltasub]) };
   my @altdate  = @{ $self->__calc_date_delta(0,[@date2],[@delta]) };

   # The H/Mn/S part of @date and @date2 should be identical. The only
   # thing that may differ is the Y/M/D part.

   if ($date[3] != $altdate[3]  ||
       $date[4] != $altdate[4]  ||
       $date[5] != $altdate[5]) {
      return undef;
   }

   # If @altdate = @date, we're done.

   my $flag = $dmb->cmp(\@date,\@altdate);
   return [@date2]  if ($flag == 0);

   # Otherwise, we need to adjust @date2 forward or back 1 day at
   # a time until the resulting @date2 + @delta is equal to @date.
   #
   # If $flag < 0, it means that @date < @altdate and @date2 needs to
   # be earlier.
   #
   # If $flag > 0, it means that @altdate > @date, and @date2 needs to
   # be later.

   my $prev = ($flag < 0 ? 1 : 0);

   while (1) {
      @date2 = @{ $dmb->calc_date_days([@date2],$flag) };

      @altdate  = @{ $self->__calc_date_delta(0,[@date2],[@delta]) };
      my $f = $dmb->cmp(\@date,\@altdate);
      return [@date2]  if ($f == 0);

      # If we've overshot, it's an impossible error... otherwise, we'll
      # adjust another day.

      return undef  if ($f != $flag);
   }
}

########################################################################
# MISC METHODS

sub secs_since_1970_GMT {
   my($self,$secs) = @_;

   my $dmb         = $$self{'objs'}{'base'};
   my $dmt         = $$self{'objs'}{'tz'};

   if (defined $secs) {
      my $date     = $dmb->secs_since_1970($secs);
      my $err;
      ($err,$date) = $dmt->convert_from_gmt($date);
      return 1  if ($err);
      $self->set('date',$date);
      return 0;
   }

   my @date = $self->value('gmt');
   $secs    = $dmb->secs_since_1970(\@date);
   return $secs;
}

sub week_of_year {
   my($self,$first) = @_;
   if ($$self{'err'}  ||  ! $$self{'data'}{'set'}) {
      warn "WARNING: [week_of_year] Object must contain a valid date\n";
      return undef;
   }

   my $dmb      = $$self{'objs'}{'base'};
   my $date     = $$self{'data'}{'date'};
   my $y        = $$date[0];

   my($day,$dow,$doy,$f);
   $doy = $dmb->day_of_year($date);

   # The date in January which must belong to the first week, and
   # it's DayOfWeek.
   if ($dmb->_config('jan1week1')) {
      $day=1;
   } else {
      $day=4;
   }
   $dow = $dmb->day_of_week([$y,1,$day]);

   # The start DayOfWeek. If $first is passed in, use it. Otherwise,
   # use FirstDay.

   if (! $first) {
      $first = $dmb->_config('firstday');
   }

   # Find the pseudo-date of the first day of the first week (it may
   # be negative meaning it occurs last year).

   $first  -= 7  if ($first > $dow);
   $day    -= ($dow-$first);

   return 0  if ($day>$doy);    # Day is in last week of previous year
   return (($doy-$day)/7 + 1);
}

sub complete {
   my($self,$field) = @_;
   if ($$self{'err'}  ||  ! $$self{'data'}{'set'}) {
      warn "WARNING: [complete] Object must contain a valid date\n";
      return undef;
   }

   if (! $field) {
      return 1  if (! $$self{'data'}{'def'}[1]  &&
                    ! $$self{'data'}{'def'}[2]  &&
                    ! $$self{'data'}{'def'}[3]  &&
                    ! $$self{'data'}{'def'}[4]  &&
                    ! $$self{'data'}{'def'}[5]);
      return 0;
   }

   if ($field eq 'm') {
      return 1  if (! $$self{'data'}{'def'}[1]);
   }

   if ($field eq 'd') {
      return 1  if (! $$self{'data'}{'def'}[2]);
   }

   if ($field eq 'h') {
      return 1  if (! $$self{'data'}{'def'}[3]);
   }

   if ($field eq 'mn') {
      return 1  if (! $$self{'data'}{'def'}[4]);
   }

   if ($field eq 's') {
      return 1  if (! $$self{'data'}{'def'}[5]);
   }
   return 0;
}

sub convert {
   my($self,$zone) = @_;
   if ($$self{'err'}  ||  ! $$self{'data'}{'set'}) {
      warn "WARNING: [convert] Object must contain a valid date\n";
      return 1;
   }
   my $dmb         = $$self{'objs'}{'base'};
   my $dmt         = $$self{'objs'}{'tz'};

   my $zonename = $dmt->_zone($zone);

   if (! $zonename) {
      $$self{'err'} = "[convert] Unable to determine timezone: $zone";
      return 1;
   }

   my $date0       = $$self{'data'}{'date'};
   my $zone0       = $$self{'data'}{'tz'};
   my $isdst0      = $$self{'data'}{'isdst'};

   my($err,$date,$off,$isdst,$abb) = $dmt->convert($date0,$zone0,$zonename,$isdst0);

   if ($err) {
      $$self{'err'} = '[convert] Unable to convert date to new timezone';
      return 1;
   }

   $self->_init();
   $$self{'data'}{'date'}   = $date;
   $$self{'data'}{'tz'}     = $zonename;
   $$self{'data'}{'isdst'}  = $isdst;
   $$self{'data'}{'offset'} = $off;
   $$self{'data'}{'abb'}    = $abb;
   $$self{'data'}{'set'}    = 1;

   return 0;
}

########################################################################
# BUSINESS DAY METHODS

sub is_business_day {
   my($self,$checktime) = @_;
   if ($$self{'err'}  ||  ! $$self{'data'}{'set'}) {
      warn "WARNING: [is_business_day] Object must contain a valid date\n";
      return undef;
   }
   my $date             = $$self{'data'}{'date'};
   return $self->__is_business_day($date,$checktime);
}

sub __is_business_day {
   my($self,$date,$checktime,$noupdate) = @_;
   my($y,$m,$d,$h,$mn,$s) = @$date;

   my $dmb = $$self{'objs'}{'base'};

   # Return 0 if it's a weekend.

   my $dow = $dmb->day_of_week([$y,$m,$d]);
   return 0  if ($dow < $dmb->_config('workweekbeg')  ||
                 $dow > $dmb->_config('workweekend'));

   # Return 0 if it's not during work hours (and we're checking
   # for that).

   if ($checktime  &&
       ! $dmb->_config('workday24hr')) {
      my $t  = $dmb->join('hms',[$h,$mn,$s]);
      my $t0 = $dmb->join('hms',$$dmb{'data'}{'calc'}{'workdaybeg'});
      my $t1 = $dmb->join('hms',$$dmb{'data'}{'calc'}{'workdayend'});
      return 0  if ($t lt $t0  ||  $t gt $t1);
   }

   # Check for holidays

   $self->_holidays($y,2) unless ($noupdate);

   return 1  if (! exists $$dmb{'data'}{'holidays'}{'dates'});

   return 0  if (exists $$dmb{'data'}{'holidays'}{'dates'}{$y+0}  &&
                 exists $$dmb{'data'}{'holidays'}{'dates'}{$y+0}{$m+0}  &&
                 exists $$dmb{'data'}{'holidays'}{'dates'}{$y+0}{$m+0}{$d+0});

   return 1;
}

sub list_holidays {
   my($self,$y) = @_;
   my $dmb      = $$self{'objs'}{'base'};

   ($y) = $dmb->_now('y',1)  if (! $y);
   $self->_holidays($y,2);

   my @ret;
   my @m = sort { $a <=> $b } keys %{ $$dmb{'data'}{'holidays'}{'dates'}{$y+0} };
   foreach my $m (@m) {
      my @d = sort { $a <=> $b } keys %{ $$dmb{'data'}{'holidays'}{'dates'}{$y+0}{$m} };
      foreach my $d (@d) {
         my $hol = $self->new_date();
         $hol->set('date',[$y,$m,$d,0,0,0]);
         push(@ret,$hol);
      }
   }

   return @ret;
}

sub holiday {
   my($self) = @_;
   if ($$self{'err'}  ||  ! $$self{'data'}{'set'}) {
      warn "WARNING: [holiday] Object must contain a valid date\n";
      return undef;
   }
   my $dmb  = $$self{'objs'}{'base'};

   my($y,$m,$d) = @{ $$self{'data'}{'date'} };
   $self->_holidays($y,2);

   if (exists $$dmb{'data'}{'holidays'}{'dates'}{$y+0}  &&
       exists $$dmb{'data'}{'holidays'}{'dates'}{$y+0}{$m+0}  &&
       exists $$dmb{'data'}{'holidays'}{'dates'}{$y+0}{$m+0}{$d+0}) {
      my $tmp = $$dmb{'data'}{'holidays'}{'dates'}{$y+0}{$m+0}{$d+0};
      return ''  if (! $tmp);
      return $tmp;
   }
   return undef;
}

sub next_business_day {
   my($self,$off,$checktime) = @_;
   if ($$self{'err'}  ||  ! $$self{'data'}{'set'}) {
      warn "WARNING: [next_business_day] Object must contain a valid date\n";
      return undef;
   }
   my $date                  = $$self{'data'}{'date'};

   $date = $self->__nextprev_business_day(0,$off,$checktime,$date);
   $self->set('date',$date);
}

sub prev_business_day {
   my($self,$off,$checktime) = @_;
   if ($$self{'err'}  ||  ! $$self{'data'}{'set'}) {
      warn "WARNING: [prev_business_day] Object must contain a valid date\n";
      return undef;
   }
   my $date                  = $$self{'data'}{'date'};

   $date = $self->__nextprev_business_day(1,$off,$checktime,$date);
   $self->set('date',$date);
}

sub __nextprev_business_day {
   my($self,$prev,$off,$checktime,$date) = @_;
   my($y,$m,$d,$h,$mn,$s) = @$date;

   my $dmb  = $$self{'objs'}{'base'};

   # Get day 0

   while (! $self->__is_business_day([$y,$m,$d,$h,$mn,$s],$checktime)) {
      if ($checktime) {
         ($y,$m,$d,$h,$mn,$s) =
           @{ $self->__next_prev([$y,$m,$d,$h,$mn,$s],1,undef,0,
                                 $$dmb{'data'}{'calc'}{'workdaybeg'}) };
      } else {
         # Move forward 1 day
         ($y,$m,$d)             = @{ $dmb->calc_date_days([$y,$m,$d],1) };
      }
   }

   # Move $off days into the future/past

   while ($off > 0) {
      while (1) {
         if ($prev) {
            # Move backward 1 day
            ($y,$m,$d)             = @{ $dmb->calc_date_days([$y,$m,$d],-1) };
         } else {
            # Move forward 1 day
            ($y,$m,$d)             = @{ $dmb->calc_date_days([$y,$m,$d],1) };
         }
         last  if ($self->__is_business_day([$y,$m,$d,$h,$mn,$s]));
      }
      $off--;
   }

   return [$y,$m,$d,$h,$mn,$s];
}

sub nearest_business_day {
   my($self,$tomorrow) = @_;
   if ($$self{'err'}  ||  ! $$self{'data'}{'set'}) {
      warn "WARNING: [nearest_business_day] Object must contain a valid date\n";
      return undef;
   }

   my $date = $$self{'data'}{'date'};
   $date    = $self->__nearest_business_day($tomorrow,$date);

   # If @date is empty, the date is a business day and doesn't need
   # to be changed.

   return  if (! defined($date));

   $self->set('date',$date);
}

sub __nearest_business_day {
   my($self,$tomorrow,$date) = @_;

   # We're done if this is a business day
   return undef  if ($self->__is_business_day($date,0));

   my $dmb = $$self{'objs'}{'base'};

   $tomorrow = $dmb->_config('tomorrowfirst')  if (! defined $tomorrow);

   my($a1,$a2);
   if ($tomorrow) {
      ($a1,$a2) = (1,-1);
   } else {
      ($a1,$a2) = (-1,1);
   }

   my ($y,$m,$d,$h,$mn,$s) = @$date;
   my ($y1,$m1,$d1) = ($y,$m,$d);
   my ($y2,$m2,$d2) = ($y,$m,$d);

   while (1) {
      ($y1,$m1,$d1) = @{ $dmb->calc_date_days([$y1,$m1,$d1],$a1) };
      if ($self->__is_business_day([$y1,$m1,$d1,$h,$mn,$s],0)) {
         ($y,$m,$d) = ($y1,$m1,$d1);
         last;
      }
      ($y2,$m2,$d2) = @{ $dmb->calc_date_days([$y2,$m2,$d2],$a2) };
      if ($self->__is_business_day([$y2,$m2,$d2,$h,$mn,$s],0)) {
         ($y,$m,$d) = ($y2,$m2,$d2);
         last;
      }
   }

   return [$y,$m,$d,$h,$mn,$s];
}

# We need to create all the objects which will be used to determine holidays.
# By doing this once only, a lot of time is saved.
#
sub _holiday_objs {
   my($self) = @_;
   my $dmb   = $$self{'objs'}{'base'};

   # We need a new date object so that we can work with other forced dates,
   # but we don't want to create it over and over.
   my $date       = new Date::Manip::Date;
   $$dmb{'data'}{'holidays'}{'date'} = $date;

   # Go through all of the strings from the config file.
   #
   my (@str)      = @{ $$dmb{'data'}{'sections'}{'holidays'} };
   $$dmb{'data'}{'holidays'}{'hols'} = [];

   while (@str) {
      my($string) = shift(@str);
      my($name)   = shift(@str);

      # If $string is a parse_date string AND it contains a year, we'll
      # store the date as a holiday, but not store the holiday description
      # so it never needs to be re-parsed.

      $date->_init();
      my $err = $date->parse_date($string);
      if (! $err) {
         if ($$date{'data'}{'def'}[0] eq '') {
            push(@{ $$dmb{'data'}{'holidays'}{'hols'} },$string,$name);
         } else {
            my($y,$m,$d) = @{ $$date{'data'}{'date'} };
            $$dmb{'data'}{'holidays'}{'dates'}{$y+0}{$m+0}{$d+0} = $name;
         }

         next;
      }
      $date->err(1);

      # If $string is a recurrence, we'll create a Recur object (which we
      # only have to do once) and store it.

      my $recur = $date->new_recur();
      $err      = $recur->parse($string);
      if (! $err) {
         push(@{ $$dmb{'data'}{'holidays'}{'hols'} },$recur,$name);
         next;
      }

      warn "WARNING: invalid holiday description: $string\n";
   }
}

# Make sure that holidays are set for a given year.
#
sub _holidays {
   my($self,$year,$level) = @_;
   my $dmb                = $$self{'objs'}{'base'};
   $self->_holiday_objs($year)  if (! exists $$dmb{'data'}{'holidays'}{'date'});

   $$dmb{'data'}{'holidays'}{$year} = 0
     if (! exists $$dmb{'data'}{'holidays'}{$year});

   return  if ($$dmb{'data'}{'holidays'}{$year} >= $level);

   # Parse the year

   if ($$dmb{'data'}{'holidays'}{$year} == 0) {
      $$dmb{'data'}{'holidays'}{$year} = 1;
      $self->_holidays_year($year);

      return  if ($level == 1);
   }

   # Parse the years around it.

   $$dmb{'data'}{'holidays'}{$year} = 2;
   $self->_holidays($year-1,1);
   $self->_holidays($year+1,1);
}

sub _holidays_year {
   my($self,$y) = @_;
   my $dmb      = $$self{'objs'}{'base'};

   # Get the objects and set them to use the new year. Also, get the
   # range for recurrences.

   my @hol      = @{ $$dmb{'data'}{'holidays'}{'hols'} };
   my $date     = $$dmb{'data'}{'holidays'}{'date'};
   $date->config('forcedate',"${y}-01-01-00:00:00");

   my $beg      = $self->new_date();
   $beg->set('date',[$y-1,12,1,0,0,0]);
   my $end      = $self->new_date();
   $end->set('date',[$y+1,2,1,0,0,0]);

   # Get the date for each holiday.

   while (@hol) {

      my($obj)  = shift(@hol);
      my($name) = shift(@hol);

      if (ref($obj)) {
         # It's a recurrence

         my @d     = $obj->dates($beg,$end);

         foreach my $d (@d) {
            my($y,$m,$d) = @{ $$d{'data'}{'date'} };
            $$dmb{'data'}{'holidays'}{'dates'}{$y+0}{$m+0}{$d+0} = $name;
         }

      } else {
         $date->parse_date($obj);
         my($y,$m,$d) = @{ $$date{'data'}{'date'} };
         $$dmb{'data'}{'holidays'}{'dates'}{$y+0}{$m+0}{$d+0} = $name;
      }
   }
}

########################################################################
# PRINTF METHOD

sub printf {
   my($self,@in) = @_;
   if ($$self{'err'}  ||  ! $$self{'data'}{'set'}) {
      warn "WARNING: [printf] Object must contain a valid date\n";
      return undef;
   }

   my $dmb       = $$self{'objs'}{'base'};
   my $dmt       = $$self{'objs'}{'tz'};

   my($y,$m,$d,$h,$mn,$s) = @{ $$self{'data'}{'date'} };

   my(@out);
   foreach my $in (@in) {
      my $out       = '';
      while ($in) {
         last  if ($in eq '%');

         if ($in =~ s/^([^%]+)//) {
            $out .= $1;
            next;
         }

         $in =~ s/^%(.)//;
         my $f = $1;

         if (exists $$self{'data'}{'f'}{$f}) {
            $out .= $$self{'data'}{'f'}{$f};
            next;
         }

         my ($val,$pad,$len,$dow);
         given ($f) {

            when (['Y','m','d','H','M','S','I','j','G','W','L','U']) {
               $pad = '0';
               continue ;
            }
            when (['y','f','e','k','i']) {
               $pad = ' ';
               continue ;
            }

            when (['G','W']) {
               my($yy,$ww) = $dmb->_week_of_year(1,[$y,$m,$d]);
               if ($f eq 'G') {
                  $val = $yy;
                  $len = 4;
               } else {
                  $val = $ww;
                  $len = 2;
               } continue ;
            }

            when (['L','U']) {
               my($yy,$ww) = $dmb->_week_of_year(7,[$y,$m,$d]);
               if ($f eq 'L') {
                  $val = $yy;
                  $len = 4;
               } else {
                  $val = $ww;
                  $len = 2;
               } continue ;
            }

            when (['Y','y']) {
               $val = $y;
               $len = 4;
               continue ;
            }

            when (['m','f']) {
               $val = $m;
               $len = 2;
               continue ;
            }

            when (['d','e']) {
               $val = $d;
               $len = 2;
               continue ;
            }

            when ('j') {
               $val = $dmb->day_of_year([$y,$m,$d]);
               $len = 3;
               continue ;
            }

            when (['H','k','I','i']) {
               $val = $h;
               if ($f eq 'I'  ||  $f eq 'i') {
                  $val -= 12  if ($val > 12);
                  $val  = 12  if ($val == 0);
               }
               $len = 2;
               continue ;
            }

            when ('M') {
               $val = $mn;
               $len = 2;
               continue ;
            }

            when ('S') {
               $val = $s;
               $len = 2;
               continue ;
            }

            when (['Y','m','d','H','M','S','y','f','e','k','I','i','j','G','W','L','U']) {
               while (length($val) < $len) {
                  $val = "$pad$val";
               }

               $val = substr($val,2,2)  if ($f eq 'y');
            }

            when (['b','h']) {
               $val = $$dmb{'data'}{'wordlistL'}{'month_abb'}[$m-1];
            }

            when ('B') {
               $val = $$dmb{'data'}{'wordlistL'}{'month_name'}[$m-1];
            }

            when (['v','a','A','w']) {
               $dow = $dmb->day_of_week([$y,$m,$d]);
               continue ;
            }

            when ('v') {
               $val = $$dmb{'data'}{'wordlistL'}{'day_char'}[$dow-1];
            }

            when ('a') {
               $val = $$dmb{'data'}{'wordlistL'}{'day_abb'}[$dow-1];
            }

            when ('A') {
               $val = $$dmb{'data'}{'wordlistL'}{'day_name'}[$dow-1];
            }

            when ('w') {
               $val = $dow;
            }

            when ('p') {
               my $i = ($h >= 12 ? 1 : 0);
               $val  = $$dmb{'data'}{'wordlistL'}{'ampm'}[$i];
            }

            when ('Z') {
               $val  = $$self{'data'}{'abb'};
            }

            when ('N') {
               my $off = $$self{'data'}{'offset'};
               $val = $dmb->join('offset',$off);
            }

            when ('z') {
               my $off = $$self{'data'}{'offset'};
               $val = $dmb->join('offset',$off);
               $val =~ s/://g;
               $val =~ s/00$//;
            }

            when ('E') {
               $val = $$dmb{'data'}{'wordlistL'}{'nth_dom'}[$d-1];
            }

            when ('s') {
               $val = $self->secs_since_1970_GMT();
            }

            when ('o') {
               my $date2 = $self->new_date();
               $date2->parse('1970-01-01 00:00:00');
               my $delta = $date2->calc($self);
               $val = $delta->printf('%sys');
            }

            when ('l') {
               my $d0 = $self->new_date();
               my $d1 = $self->new_date();
               $d0->parse('-0:6:0:0:0:0:0'); # 6 months ago
               $d1->parse('+0:6:0:0:0:0:0'); # in 6 months
               $d0      = $d0->value();
               $d1      = $d1->value();
               my $date = $self->value();
               if ($date lt $d0  ||  $date ge $d1) {
                  $in  = '%b %e  %Y' . $in;
               } else {
                  $in  = '%b %e %H:%M' . $in;
               }
               $val = '';
            }

            when ('c') {
               $in  = '%a %b %e %H:%M:%S %Y' . $in;
               $val = '';
            }

            when (['C','u']) {
               $in  = '%a %b %e %H:%M:%S %Z %Y' . $in;
               $val = '';
            }

            when ('g') {
               $in  = '%a, %d %b %Y %H:%M:%S %Z' . $in;
               $val = '';
            }

            when ('D') {
               $in  = '%m/%d/%y' . $in;
               $val = '';
            }

            when ('r') {
               $in  = '%I:%M:%S %p' . $in;
               $val = '';
            }

            when ('R') {
               $in  = '%H:%M' . $in;
               $val = '';
            }

            when (['T','X']) {
               $in  = '%H:%M:%S' . $in;
               $val = '';
            }

            when ('V') {
               $in  = '%m%d%H%M%y' . $in;
               $val = '';
            }

            when ('Q') {
               $in  = '%Y%m%d' . $in;
               $val = '';
            }

            when ('q') {
               $in  = '%Y%m%d%H%M%S' . $in;
               $val = '';
            }

            when ('P') {
               $in  = '%Y%m%d%H:%M:%S' . $in;
               $val = '';
            }

            when ('O') {
               $in  = '%Y-%m-%dT%H:%M:%S' . $in;
               $val = '';
            }

            when ('F') {
               $in  = '%A, %B %e, %Y' . $in;
               $val = '';
            }

            when ('K') {
               $in  = '%Y-%j' . $in;
               $val = '';
            }

            when ('x') {
               if ($dmb->_config('dateformat') eq 'US') {
                  $in  = '%m/%d/%y' . $in;
               } else {
                  $in  = '%d/%m/%y' . $in;
               }
               $val = '';
            }

            when ('J') {
               $in  = '%G-W%W-%w' . $in;
               $val = '';
            }

            when ('n') {
               $val = "\n";
            }

            when ('t') {
               $val = "\t";
            }

            default {
               $val = $f;
            }
         }

         if ($val) {
            $$self{'data'}{'f'}{$f} = $val;
            $out .= $val;
         }
      }
      push(@out,$out);
   }

   if (wantarray) {
      return @out;
   } elsif (@out == 1) {
      return $out[0];
   }

   return ''
}

########################################################################
# EVENT METHODS

sub list_events {
   my($self,@args) = @_;
   if ($$self{'err'}  ||  ! $$self{'data'}{'set'}) {
      warn "WARNING: [list_events] Object must contain a valid date\n";
      return undef;
   }
   my $dmb         = $$self{'objs'}{'base'};

   # Arguments

   my($date,$day,$format);
   if (@args  &&  $args[$#args] eq 'dates') {
      pop(@args);
      $format = 'dates';
   } else {
      $format = 'std';
   }

   if (@args  &&  $#args==0  &&  ref($args[0]) eq 'Date::Manip::Date') {
      $date = $args[0];
   } elsif (@args  &&  $#args==0  &&  $args[0]==0) {
      $day  = 1;
   } elsif (@args) {
      warn "ERROR: [list_events] unknown argument list\n";
      return [];
   }

   # Get the beginning/end dates we're looking for events in

   my($beg,$end);
   if ($date) {
      $beg = $self;
      $end = $date;
   } elsif ($day) {
      $beg = $self->new_date();
      $end = $self->new_date();
      my($y,$m,$d) = $self->value();
      $beg->set('date',[$y,$m,$d,0,0,0]);
      $end->set('date',[$y,$m,$d,23,59,59]);
   } else {
      $beg = $self;
      $end = $self;
   }

   if ($beg->cmp($end) == 1) {
      my $tmp = $beg;
      $beg    = $end;
      $end    = $tmp;
   }

   # We need to get a list of all events which may apply.

   my($y0) = $beg->value();
   my($y1) = $end->value();
   foreach my $y ($y0..$y1) {
      $self->_events_year($y);
   }

   my @events = ();
   foreach my $i (keys %{ $$dmb{'data'}{'events'} }) {
      my $event = $$dmb{'data'}{'events'}{$i};
      my $type  = $$event{'type'};
      my $name  = $$event{'name'};

      given ($type) {

         when ('specified') {
            my $d0 = $$dmb{'data'}{'events'}{$i}{'beg'};
            my $d1 = $$dmb{'data'}{'events'}{$i}{'end'};
            push @events,[$d0,$d1,$name];
         }

         when (['ym','date']) {
            foreach my $y ($y0..$y1) {
               if (exists $$dmb{'data'}{'events'}{$i}{$y}) {
                  my($d0,$d1) = @{ $$dmb{'data'}{'events'}{$i}{$y} };
                  push @events,[$d0,$d1,$name];
               }
            }
         }

         when ('recur') {
            my $rec = $$dmb{'data'}{'events'}{$i}{'recur'};
            my $del = $$dmb{'data'}{'events'}{$i}{'delta'};
            my @d   = $rec->dates($beg,$end);
            foreach my $d0 (@d) {
               my $d1 = $d0->calc($del);
               push @events,[$d0,$d1,$name];
            }
         }
      }
   }

   # Next we need to see which ones apply.

   my @tmp;
   foreach my $e (@events) {
      my($d0,$d1,$name) = @$e;

      push(@tmp,$e)  if ($beg->cmp($d1) != 1  &&
                         $end->cmp($d0) != -1);
   }

   # Now format them...

   if ($format eq 'std') {
      @events = sort { $$a[0]->cmp($$b[0])  ||
                       $$a[1]->cmp($$b[1])  ||
                       $$a[2] cmp $$b[2] } @tmp;

   } elsif ($format eq 'dates') {
      my $p1s = $self->new_delta();
      $p1s->parse('+0:0:0:0:0:0:1');

      @events = ();
      my (@tmp2);
      foreach my $e (@tmp) {
         my $name = $$e[2];
         if ($$e[0]->cmp($beg) == -1) {
            # Event begins before the start
            push(@tmp2,[$beg,'+',$name]);
         } else {
            push(@tmp2,[$$e[0],'+',$name]);
         }

         my $d1 = $$e[1]->calc($p1s);

         if ($d1->cmp($end) == -1) {
            # Event ends before the end
            push(@tmp2,[$d1,'-',$name]);
         }
      }

      @tmp2 = sort { $$a[0]->cmp($$b[0])  ||
                     $$a[1] cmp $$b[1]    ||
                     $$a[2] cmp $$b[2] } @tmp2;

      # @tmp2 is now:
      #   ( [ DATE1, OP1, NAME1 ], [ DATE2, OP2, NAME2 ], ... )
      # which is sorted by date.

      my $d = $tmp2[0]->[0];

      if ($beg->cmp($d) != 0) {
         push(@events,[$beg]);
      }

      my %e;
      while (1) {

         # If the first element is the same date as we're
         # currently working with, just perform the operation
         # and remove it from the list. If the list is not empty,
         # we'll proceed to the next element.

         my $d0 = $tmp2[0]->[0];
         if ($d->cmp($d0) == 0) {
            my $e  = shift(@tmp2);
            my $op = $$e[1];
            my $n  = $$e[2];
            if ($op eq '+') {
               $e{$n} = 1;
            } else {
               delete $e{$n};
            }

            next  if (@tmp2);
         }

         # We need to store the existing %e.

         my @n = sort keys %e;
         push(@events,[$d,@n]);

         # If the list is empty, we're done. Otherwise, we need to
         # reset the date and continue.

         last  if (! @tmp2);
         $d = $tmp2[0]->[0];
      }
   }

   return @events;
}

# The events of type date and ym are determined on a year-by-year basis
#
sub _events_year {
   my($self,$y) = @_;
   my $dmb      = $$self{'objs'}{'base'};
   my ($tz)     = $dmb->_now('tz',1);
   return  if (exists $$dmb{'data'}{'eventyears'}{$y});
   $self->_event_objs()  if (! $$dmb{'data'}{'eventobjs'});

   my $d = $self->new_date();
   $d->config('forcedate',"${y}-01-01-00:00:00,$tz");

   my $hrM1  = $d->new_delta();
   $hrM1->set('delta',[0,0,0,0,0,59,59]);

   my $dayM1 = $d->new_delta();
   $dayM1->set('delta',[0,0,0,0,23,59,59]);

   foreach my $i (keys %{ $$dmb{'data'}{'events'} }) {
      my $event = $$dmb{'data'}{'events'}{$i};
      my $type  = $$event{'type'};

      if ($type eq 'ym') {
         my $beg = $$event{'beg'};
         my $end = $$event{'end'};
         my $d0  = $d->new_date();
         $d0->parse_date($beg);
         $d0->set('time',[0,0,0]);

         my $d1;
         if ($end) {
            $d1  = $d0->new_date();
            $d1->parse_date($end);
            $d1->set('time',[23,59,59]);
         } else {
            $d1  = $d0->calc($dayM1);
         }
         $$dmb{'data'}{'events'}{$i}{$y} = [ $d0,$d1 ];

      } elsif ($type eq 'date') {
         my $beg = $$event{'beg'};
         my $end = $$event{'end'};
         my $del = $$event{'delta'};
         my $d0  = $d->new_date();
         $d0->parse($beg);

         my $d1;
         if ($end) {
            $d1  = $d0->new_date();
            $d1->parse($end);
         } elsif ($del) {
            $d1 = $d0->calc($del);
         } else {
            $d1  = $d0->calc($hrM1);
         }
         $$dmb{'data'}{'events'}{$i}{$y} = [ $d0,$d1 ];
      }
   }
}

# This parses the raw event list.  It only has to be done once.
#
sub _event_objs {
   my($self) = @_;
   my $dmb   = $$self{'objs'}{'base'};
   # Only parse once.
   $$dmb{'data'}{'eventobjs'} = 1;

   my $hrM1  = $self->new_delta();
   $hrM1->set('delta',[0,0,0,0,0,59,59]);

   my $M1    = $self->new_delta();
   $M1->set('delta',[0,0,0,0,0,0,-1]);

   my @tmp   = @{ $$dmb{'data'}{'sections'}{'events'} };
   my $i     = 0;
   while (@tmp) {
      my $string = shift(@tmp);
      my $name   = shift(@tmp);
      my @event  = split(/\s*;\s*/,$string);

      if ($#event == 0) {

         # YMD/YM

         my $d1  = $self->new_date();
         my $err = $d1->parse_date($event[0]);
         if (! $err) {
            if ($$d1{'data'}{'def'}[0] eq '') {
               # YM
               $$dmb{'data'}{'events'}{$i++} = { 'type' => 'ym',
                                                 'name' => $name,
                                                 'beg'  => $event[0] };
            } else {
               # YMD
               my $d2         = $d1->new_date();
               my ($y,$m,$d)  = $d1->value();
               $d1->set('time',[0,0,0]);
               $d2->set('date',[$y,$m,$d,23,59,59]);
               $$dmb{'data'}{'events'}{$i++} = { 'type' => 'specified',
                                                 'name' => $name,
                                                 'beg'  => $d1,
                                                 'end'  => $d2 };
            }
            next;
         }

         # Date

         $err = $d1->parse($event[0]);
         if (! $err) {
            if ($$d1{'data'}{'def'}[0] eq '') {
               # Date (no year)
               $$dmb{'data'}{'events'}{$i++} = { 'type'  => 'date',
                                                 'name'  => $name,
                                                 'beg'   => $event[0],
                                                 'delta' => $hrM1
                                               };
            } else {
               # Date (year)
               my $d2 = $d1->calc($hrM1);
               $$dmb{'data'}{'events'}{$i++} = { 'type' => 'specified',
                                                 'name' => $name,
                                                 'beg'  => $d1,
                                                 'end'  => $d2
                                               };
            }
            next;
         }

         # Recur

         my $r = $self->new_recur();
         $err  = $r->parse($event[0]);
         if ($err) {
            warn "ERROR: invalid event definition (must be Date, YMD, YM, or Recur)\n"
               . "       $string\n";
            next;
         }

         my @d = $r->dates();
         if (@d) {
            foreach my $d (@d) {
               my $d2 = $d->calc($hrM1);
               $$dmb{'data'}{'events'}{$i++} = { 'type' => 'specified',
                                                 'name' => $name,
                                                 'beg'  => $d1,
                                                 'end'  => $d2
                                               };
            }
         } else {
            $$dmb{'data'}{'events'}{$i++} = { 'type'  => 'recur',
                                              'name'  => $name,
                                              'recur' => $r,
                                              'delta' => $hrM1
                                            };
         }

      } elsif ($#event == 1) {
         my($o1,$o2) = @event;

         # YMD;YMD
         # YM;YM

         my $d1   = $self->new_date();
         my $err = $d1->parse_date($o1);
         if (! $err) {
            my $d2 = $self->new_date();
            $err   = $d2->parse_date($o2);
            if ($err) {
               warn "ERROR: invalid event definition (must be YMD;YMD or YM;YM)\n"
                  . "       $string\n";
               next;
            } elsif ($$d1{'data'}{'def'}[0] ne $$d2{'data'}{'def'}[0]) {
               warn "ERROR: invalid event definition (YMD;YM or YM;YMD not allowed)\n"
                  . "       $string\n";
               next;
            }

            if ($$d1{'data'}{'def'}[0] eq '') {
               # YM;YM
               $$dmb{'data'}{'events'}{$i++} = { 'type' => 'ym',
                                                 'name' => $name,
                                                 'beg'  => $o1,
                                                 'end'  => $o2
                                               };
            } else {
               # YMD;YMD
               $d1->set('time',[0,0,0]);
               $d2->set('time',[23,59,59]);
               $$dmb{'data'}{'events'}{$i++} = { 'type' => 'specified',
                                                 'name' => $name,
                                                 'beg'  => $d1,
                                                 'end'  => $d2 };
            }
            next;
         }

         # Date;Date
         # Date;Delta

         $err = $d1->parse($o1);
         if (! $err) {

            my $d2 = $self->new_date();
            $err   = $d2->parse($o2,'nodelta');

            if (! $err) {
               # Date;Date
               if ($$d1{'data'}{'def'}[0] ne $$d2{'data'}{'def'}[0]) {
                  warn "ERROR: invalid event definition (year must be absent or\n"
                     . "       included in both dats in Date;Date)\n"
                     . "       $string\n";
                  next;
               }

               if ($$d1{'data'}{'def'}[0] eq '') {
                  # Date (no year)
                  $$dmb{'data'}{'events'}{$i++} = { 'type' => 'date',
                                                    'name' => $name,
                                                    'beg'  => $o1,
                                                    'end'  => $o2
                                                  };
               } else {
                  # Date (year)
                  $$dmb{'data'}{'events'}{$i++} = { 'type' => 'specified',
                                                    'name' => $name,
                                                    'beg'  => $d1,
                                                    'end'  => $d2
                                                  };
               }
               next;
            }

            # Date;Delta
            my $del = $self->new_delta();
            $err    = $del->parse($o2);

            if ($err) {
               warn "ERROR: invalid event definition (must be Date;Date or Date;Delta)\n"
                  . "       $string\n";
               next;
            }

            $del    = $del->calc($M1);
            if ($$d1{'data'}{'def'}[0] eq '') {
               # Date (no year)
               $$dmb{'data'}{'events'}{$i++} = { 'type'  => 'date',
                                                 'name'  => $name,
                                                 'beg'   => $o1,
                                                 'delta' => $del
                                               };
            } else {
               # Date (year)
               $d2 = $d1->calc($del);
               $$dmb{'data'}{'events'}{$i++} = { 'type' => 'specified',
                                                 'name' => $name,
                                                 'beg'  => $d1,
                                                 'end'  => $d2
                                               };
            }
            next;
         }

         # Recur;Delta

         my $r = $self->new_recur();
         $err  = $r->parse($o1);

         my $del = $self->new_delta();
         if (! $err) {
            $err    = $del->parse($o2);
         }

         if ($err) {
            warn "ERROR: invalid event definition (must be Date;Date, YMD;YMD, YM;YM,"
              .  "      Date;Delta, or Recur;Delta)\n"
              . "       $string\n";
            next;
         }

         $del  = $del->calc($M1);
         my @d = $r->dates();
         if (@d) {
            foreach my $d1 (@d) {
               my $d2 = $d1->calc($del);
               $$dmb{'data'}{'events'}{$i++} = { 'type' => 'specified',
                                                 'name' => $name,
                                                 'beg'  => $d1,
                                                 'end'  => $d2
                                               };
            }
         } else {
            $$dmb{'data'}{'events'}{$i++} = { 'type'  => 'recur',
                                              'name'  => $name,
                                              'recur' => $r,
                                              'delta' => $del
                                            };
         }

      } else {
         warn "ERROR: invalid event definition\n"
            . "       $string\n";
         next;
      }
   }
}

1;
# Local Variables:
# mode: cperl
# indent-tabs-mode: nil
# cperl-indent-level: 3
# cperl-continued-statement-offset: 2
# cperl-continued-brace-offset: 0
# cperl-brace-offset: 0
# cperl-brace-imaginary-offset: 0
# cperl-label-offset: -2
# End:
