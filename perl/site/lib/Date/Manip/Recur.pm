package Date::Manip::Recur;
# Copyright (c) 1998-2010 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.

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
use IO::File;
use feature 'switch';
use integer;
#use re 'debug';

use vars qw($VERSION);
$VERSION='6.11';

########################################################################
# BASE METHODS
########################################################################

sub is_recur {
   return 1;
}

# Call this every time a new recur is put in to make sure everything is
# correctly initialized.
#
sub _init {
   my($self) = @_;
   my $dmb   = $$self{'objs'}{'base'};

   $$self{'err'}              = '';
   $$self{'data'}{'interval'} = [];    # (Y, M, ...)
   $$self{'data'}{'rtime'}    = [];    # ( [ VAL_OR_RANGE, VAL_OR_RANGE, ... ],
                                       #   [ VAL_OR_RANGE, VAL_OR_RANGE, ... ],
                                       #   ... )
   $$self{'data'}{'base'}     = undef;

   # Get the default start/end dates

   given ($dmb->_config('recurrange')) {

      when ('none') {
         $$self{'data'}{'start'}    = undef;
         $$self{'data'}{'end'}      = undef;
      }

      when ('year') {
         my ($y)    = $dmb->_now('y',1);
         my $start  = $self->new_date();
         my $end    = $self->new_date();
         $start->set('date',[$y, 1, 1,00,00,00]);
         $end->set  ('date',[$y,12,31,23,59,59]);
      }

      when ('month') {
         my ($y,$m) = $dmb->_now('now',1);
         my $dim    = $dmb->days_in_month($y,$m);
         my $start  = $self->new_date();
         my $end    = $self->new_date();
         $start->set('date',[$y,$m,   1,00,00,00]);
         $end->set  ('date',[$y,$m,$dim,23,59,59]);
      }

      when ('week') {
         my($y,$m,$d) = $dmb->_now('now',1);
         my $w;
         ($y,$w)    = $dmb->week_of_year([$y,$m,$d]);
         ($y,$m,$d) = @{ $dmb->week_of_year($y,$w) };
         my($yy,$mm,$dd)
                    = @{ $dmb->_calc_date_ymwd([$y,$m,$d], [0,0,0,6], 0) };

         my $start  = $self->new_date();
         my $end    = $self->new_date();
         $start->set('date',[$y, $m, $d, 00,00,00]);
         $end->set  ('date',[$yy,$mm,$dd,23,59,59]);
      }

      when ('day') {
         my($y,$m,$d) = $dmb->_now('now',1);
         my $start  = $self->new_date();
         my $end    = $self->new_date();
         $start->set('date',[$y,$m,$d,00,00,00]);
         $end->set  ('date',[$y,$m,$d,23,59,59]);
      }

      when ('all') {
         my $start  = $self->new_date();
         my $end    = $self->new_date();
         $start->set('date',[0001,02,01,00,00,00]);
         $end->set  ('date',[9999,11,30,23,59,59]);
      }
   }

   # Based on the modifiers, this is what we have to add to the
   # start/end time in order to get a range which will produce
   # modified dates guaranteed to fall within the start/end date
   # range.
   #
   # The rtime values can automatically change things by up to one
   # day.

   $$self{'data'}{'flags'}    = [];
   $$self{'data'}{'startm'}   = [0,0,0,-1,0,0,0];
   $$self{'data'}{'endm'}     = [0,0,0, 1,0,0,0];
}

sub _init_args {
   my($self) = @_;

   my @args = @{ $$self{'args'} };
   if (@args) {
      $self->parse(@args);
   }
}

########################################################################
# METHODS
########################################################################

sub parse {
   my($self,$string,@args) = @_;

   # Test if $string = FREQ

   my $err = $self->frequency($string);
   if (! $err) {
      $string = '';
   }

   # Test if $string = "FREQ*..." and FREQ contains an '*'.

   if ($err) {
      $self->err(1);

      $string  =~ s/\s*\*\s*/\*/g;

      if ($string =~ /^([^*]*\*[^*]*)\*/) {
         my $freq = $1;
         $err     = $self->frequency($freq);
         if (! $err) {
            $string =~ s/^\Q$freq\E\*//;
         }
      } else {
         $err = 1;
      }
   }

   # Test if $string = "FREQ*..." and FREQ does NOT contains an '*'.

   if ($err) {
      $self->err(1);

      if ($string =~ s/^([^*]*)\*//) {
         my $freq = $1;
         $err     = $self->frequency($freq);
         if (! $err) {
            $string =~ s/^\Q$freq\E\*//;
         }
      } else {
         $err     = 1;
      }
   }

   if ($err) {
      $$self{'err'} = "[frequency] Invalid frequency string";
      return 1;
   }

   # Handle MODIFIERS from string and arguments

   my @tmp = split(/\*/,$string);

   if (@tmp) {
      my $tmp = shift(@tmp);
      $err = $self->modifiers($tmp)  if ($tmp);
      return 1  if ($err);
   }
   if (@args) {
      my $tmp = $args[0];
      if ($tmp  &&  ! ref($tmp)) {
         $err = $self->modifiers($tmp);
         if ($err) {
            $self->err(1);
            $err = 0;
         } else {
            shift(@args);
         }
      }
   }

   # Handle BASE

   if (@tmp) {
      my $tmp = shift(@tmp);
      if (defined($tmp)  &&  $tmp) {
         my $base = $self->new_date();
         $err     = $base->parse($tmp);
         return 1  if ($err);
         $err     = $self->base($tmp);
         return 1  if ($err);
      }
   }
   if (@args) {
      my $tmp = shift(@args);
      $err = $self->base($tmp)  if (defined($tmp)  &&  $tmp);
      return 1  if ($err);
   }

   # Handle START

   if (@tmp) {
      my $tmp = shift(@tmp);
      if (defined($tmp)  &&  $tmp) {
         my $start = $self->new_date();
         $err      = $start->parse($tmp);
         return 1  if ($err);
         $err      = $self->start($tmp);
         return 1  if ($err);
      }
   }
   if (@args) {
      my $tmp = shift(@args);
      $err = $self->start($tmp)  if (defined($tmp)  &&  $tmp);
      return 1  if ($err);
   }

   # END

   if (@tmp) {
      my $tmp = shift(@tmp);
      if (defined($tmp)  &&  $tmp) {
         my $end = $self->new_date();
         $err    = $end->parse($tmp);
         return 1  if ($err);
         $err    = $self->end($tmp);
         return 1  if ($err);
      }
   }
   if (@args) {
      my $tmp = shift(@args);
      $err = $self->end($tmp)  if (defined($tmp)  &&  $tmp);
      return 1  if ($err);
   }

   if (@tmp) {
      $$self{'err'} = "[frequency] String contains invalid elements";
      return 1;
   }
   if (@args) {
      $$self{'err'} = "[frequency] Unknown arguments";
      return 1;
   }

   return 0;
}

sub frequency {
   my($self,$string) = @_;
   $self->_init();

   my (@int,@rtime);

 PARSE: {

      # Standard frequency notation

      my $stdrx = $self->_rx('std');
      if ($string =~ $stdrx) {
         my($l,$r) = @+{qw(l r)};

         if (defined($l)) {
            $l =~ s/^\s*:/0:/;
            $l =~ s/:\s*$/:0/;
            $l =~ s/::/:0:/g;

            @int = split(/:/,$l);
         }

         if (defined($r)) {
            $r =~ s/^\s*:/0:/;
            $r =~ s/:\s*$/:0/;
            $r =~ s/::/:0:/g;

            @rtime = split(/:/,$r);
         }

         last PARSE;
      }

      # Other frequency strings

      # Strip out some words to ignore

      my $ignrx = $self->_rx('ignore');
      $string =~ s/$ignrx/ /g;

      my $eachrx = $self->_rx('each');
      my $each   = 0;
      if ($string =~ s/$eachrx/ /g) {
         $each = 1;
      }

      $string =~ s/\s*$//;

      if (! $string) {
         $$self{'err'} = "[frequency] Invalid frequency string";
         return 1;
      }

      my($l,$r);
      my $err = $self->_parse_lang($string);
      if ($err) {
         $$self{'err'} = "[frequency] Invalid frequency string";
         return 1;
      }
      return 0;
   }

   # If the interval consists only of zeros, the last entry is changed
   # to 1.

   if (@int) {
    TEST_INT: {
         for my $i (@int) {
            last TEST_INT if ($i);
         }
         $int[$#int] = 1;
      }
   }

   # If @int contains 2 or 3 elements, move a trailing 0 to the start
   # of @rtime.

   while (@int  &&
          ($#int == 1 || $#int == 2)  &&
          ($int[$#int] == 0)) {
      pop(@int);
      unshift(@rtime,0);
   }

   # Test the format of @rtime.
   #
   # Turn it to:
   #   @rtime = ( NUM|RANGE, NUM|RANGE, ...)
   # where
   #   NUM is an integer
   #   RANGE is [NUM1,NUM2]

   my $rfieldrx = $self->_rx('rfield');
   my $rrangerx = $self->_rx('rrange');
   my @type     = qw(y m w d h mn s);
   while ($#type > $#rtime) {
      shift(@type);
   }

   foreach my $rfield (@rtime) {
      my $type = shift(@type);

      if ($rfield !~ $rfieldrx) {
         $$self{'err'} = "[parse] Invalid rtime string";
         return 1;
      }

      my @rfield = split(/,/,$rfield);
      my @val;

      foreach my $vals (@rfield) {
         if ($vals =~ $rrangerx) {
            my ($num1,$num2) = ($1,$2);

            if ( ($num1 < 0  ||  $num2 < 0)  &&
                 ($type ne 'w'  &&  $type ne 'd') ) {
               $$self{'err'} = "[parse] Negative values allowed for day/week";
               return 1;
            }

            if ( ($num1 > 0  &&  $num2 > 0)  ||
                 ($num1 < 0  &&  $num2 < 0) ) {
               if ($num1 > $num2) {
                  $$self{'err'} = "[parse] Invalid rtime range string";
                  return 1;
               }
               push(@val,$num1..$num2);
            } else {
               push(@val,[$num1,$num2]);
            }

         } else {
            if ($vals < 0  &&
                 ($type ne 'w'  &&  $type ne 'd') ) {
               $$self{'err'} = "[parse] Negative values allowed for day/week";
               return 1;
            }
            push(@val,$vals);
         }
      }

      $rfield = [ @val ];
   }

   # Store it (also, get the default range modifiers).

   $$self{'data'}{'interval'} = [ @int ];
   $$self{'data'}{'rtime'}    = [ @rtime ];
   $self->modifiers();

   return 0;
}

sub _parse_lang {
   my($self,$string) = @_;
   my $dmb           = $$self{'objs'}{'base'};

   # Test the regular expression

   my $rx = $self->_rx('every');

   return 1  if ($string !~ $rx);
   my($month,$week,$day,$last,$nth,$day_name,$day_abb,$mon_name,$mon_abb,$n,$y) =
     @+{qw(month week day last nth day_name day_abb mon_name mon_abb n y)};

   # Convert wordlist values to calendar values

   my $dow;
   if (defined($day_name) || defined($day_abb)) {
      if (defined($day_name)) {
         $dow = $$dmb{'data'}{'wordmatch'}{'day_name'}{lc($day_name)};
      } else {
         $dow = $$dmb{'data'}{'wordmatch'}{'day_abb'}{lc($day_abb)};
      }
   }

   my $mmm;
   if (defined($mon_name) || defined($mon_abb)) {
      if (defined($mon_name)) {
         $mmm = $$dmb{'data'}{'wordmatch'}{'month_name'}{lc($mon_name)};
      } else {
         $mmm = $$dmb{'data'}{'wordmatch'}{'month_abb'}{lc($mon_abb)};
      }
   }

   if (defined($nth)) {
      $nth = $$dmb{'data'}{'wordmatch'}{'nth'}{lc($nth)};
   }

   # Get the frequencies

   my($freq);
   if (defined($dow)) {
      if (defined($mmm)) {
         if (defined($last)) {
            # last DoW in MMM [YY]
            $freq = "1*$mmm:-1:$dow:0:0:0";

         } elsif (defined($nth)) {
            # Nth DoW in MMM [YY]
            $freq = "1*$mmm:$nth:$dow:0:0:0";

         } else {
            # every DoW in MMM [YY]
            $freq = "1*$mmm:1-5:$dow:0:0:0";
         }

      } else {
         if (defined($last)) {
            # last DoW in every month [in YY]
            $freq = "0:1*-1:$dow:0:0:0";

         } elsif (defined($nth)) {
            # Nth DoW in every month [in YY]
            $freq = "0:1*$nth:$dow:0:0:0";

         } else {
            # every DoW in every month [in YY]
            $freq = "0:1*1-5:$dow:0:0:0";
         }
      }

   } elsif (defined($day)) {
      if (defined($month)) {
         if (defined($nth)) {
            # Nth day of every month [YY]
            $freq = "0:1*0:$nth:0:0:0";

         } elsif (defined($last)) {
            # last day of every month [YY]
            $freq = "0:1*0:-1:0:0:0";

         } else {
            # every day of every month [YY]
            $freq = "0:0:0:1*0:0:0";
         }

      } else {
         if (defined($nth)) {
            # every Nth day [YY]
            $freq = "0:0:0:$nth*0:0:0";

         } elsif (defined($n)) {
            # every N days [YY]
            $freq = "0:0:0:$n*0:0:0";

         } else {
            # every day [YY]
            $freq = "0:0:0:1*0:0:0";
         }
      }
   }

   # Get the range (if YY is included)

   if (defined($y)) {
      $y = $dmb->_fix_year($y);
      my $start = "${y}010100:00:00";
      my $end   = "${y}123123:59:59";

      return $self->parse($freq,undef,$start,$end);
   }

   return $self->frequency($freq)
}

sub _date {
   my($self,$op,$date_or_string) = @_;

   # Make sure the argument is a date

   if (ref($date_or_string) eq 'Date::Manip::Date') {
      $$self{'data'}{$op} = $date_or_string;

   } elsif (ref($date_or_string)) {
      $$self{'err'} = "Invalid $op date object";
      return 1;

   } else {
      my $date = $self->new_date();
      my $err  = $date->parse($date_or_string);
      if ($err) {
         $$self{'err'} = "Invalid $op date string";
         return 1;
      }
      $$self{'data'}{$op} = $date;
   }

   return 0;
}

sub start {
   my($self,$start) = @_;
   $self->_date('start',$start);
}

sub end {
   my($self,$end) = @_;
   $self->_date('end',$end);
}

sub base {
   my($self,$base) = @_;
   $self->_date('base',$base);
}

sub modifiers {
   my($self,@flags) = @_;
   my $dmb          = $$self{'objs'}{'base'};
   if ($#flags == 0) {
      @flags        = split(/,/,lc($flags[0]));
   }

   # Add these flags to the list

   if (@flags  &&  $flags[0] eq "+") {
      shift(@flags);
      my @tmp = @{ $$self{'data'}{'flags'} };
      @flags  = (@tmp,@flags)  if (@tmp);
   }

   # Set up a base modifier:
   #   @int = ()          : +/- 1 year
   #   @int = (y)         : +/- 1 year
   #   @int = (y,m)       : +/- 1 month
   #   @int = (y,m,w)     : +/- 1 month
   #   @int = (y,m,w,d)   : +/- 1 week
   #   @int = (y...h)     : +/- 1 day
   #   @int = (y...mn)    : +/- 1 hour
   #   @int = (y...s)     : +/- 1 minute

   my @int = @{ $$self{'data'}{'interval'} };
   my(@startm,@endm);
   my $n = $#int + 1;

   given($n) {

      when ([0,1]) {
         @endm = (1,0,0,0,0,0,0);
      }

      when ([2,3]) {
         @endm = (0,1,0,0,0,0,0);
      }

      when (4) {
         @endm = (0,0,0,7,0,0,0);
      }

      when (5) {
         @endm = (0,0,0,1,0,0,0);
      }

      when (6) {
         @endm = (0,0,0,0,1,0,0);
      }

      when (7) {
         @endm = (0,0,0,0,0,1,0);
      }
   }
   @startm = map { -1*$_ } @endm;

   # Examine each modifier to see how it impacts the range

   foreach my $flag (@flags) {

      given($flag) {

         when (/^pd([1-7])$/) {
            $startm[3] -= 7;
            $endm[3]   -= 1;
         }

         when (/^pt([1-7])$/) {
            $startm[3] -= 6;
            $endm[3]   -= 0;
         }

         when (/^nd([1-7])$/) {
            $startm[3] += 1;
            $endm[3]   += 7;
         }

         when (/^nt([1-7])$/) {
            $startm[3] += 0;
            $endm[3]   += 6;
         }

         when (/^fd(\d+)$/) {
            my $n = $1;
            $startm[3] += $n;
            $endm[3]   += $n;
         }

         when (/^bd(\d+)$/) {
            my $n = $1;
            $startm[3] -= $n;
            $endm[3]   -= $n;
         }

         #
         # The business day flags are imperfectly handled... it's quite possible to
         # make so many holidays that moving forward 1 working day could correspond
         # to moving forward many days.
         #

         when (/^(fw|bw)(\d+)$/) {
            my ($t,$n)  = ($1,$2);

            my $wwbeg   = $dmb->_config('workweekbeg');
            my $wwend   = $dmb->_config('workweekend');
            my $wwlen   = $wwend - $wwbeg + 1;
            my $wkend   = 7 - $wwlen;
            my $fudge   = $dmb->_config('recurnumfudgedays');
            # How many weekends likely in the interval?  Take best guess for maximum
            # number of weeks and add 1 for a fudge factor.
            my $num     = int($n/$wwlen) + 2;

            if ($t eq 'fw') {
               $startm[3] += $n;
               $endm[3]   += $n + $num*$wkend + $fudge;
            } else {
               $startm[3] -= $n + $num*$wkend + $fudge;
               $endm[3]   -= $n;
            }
         }

         when ([qw( cwd cwn cwp nwd pwd dwd )]) {
            # For closest work day, we'll move backwards/forwards 1
            # weekend (+ 1 day) plus the fudge factor.
            my $wwbeg   = $dmb->_config('workweekbeg');
            my $wwend   = $dmb->_config('workweekend');
            my $wwlen   = $wwend - $wwbeg + 1;
            my $wkend   = 7 - $wwlen;
            my $fudge   = $dmb->_config('recurnumfudgedays');

            if ($flag eq 'pwd') {
               $startm[3] -= $wkend+1 + $fudge;
               $endm[3]   -= 1;

            } elsif ($flag eq 'nwd') {
               $startm[3] += 1;
               $endm[3]   += $wkend+1 + $fudge;

            } else {
               $startm[3] -= $wkend+1 + $fudge;
               $endm[3]   += $wkend+1 + $fudge;
            }
         }

         when ('easter') {
            $startm[0]--;
            $endm[0]++;
         }

         default {
            $$self{'err'} = "[modifiers]: invalid modifier: $flag";
            return 1;
         }
      }
   }

   $$self{'data'}{'startm'} = [ @startm ];
   $$self{'data'}{'endm'}   = [ @endm ];
   $$self{'data'}{'flags'}  = [ @flags ];
   return 0;
}

sub dates {
   my($self,$start2,$end2) = @_;
   $self->err(1);

   my $dmb   = $$self{'objs'}{'base'};
   $dmb->_update_now();   # Update NOW
   my @int   = @{ $$self{'data'}{'interval'} };
   my @rtime = @{ $$self{'data'}{'rtime'} };
   my ($yf,$mf,$wf,$df,$hf,$mnf,$sf) = (@int,@rtime);

   #
   # Get the start and end dates based on the dates store in the
   # recurrence and the dates passed in as arguments.
   #

   if (defined($start2)  &&
       (! ref($start2)  ||  ref($start2) ne 'Date::Manip::Date'  ||
        $start2->err())) {
      $$self{'err'} = 'Start argument must be a date object.';
      return ();
   }
   if (defined($end2)  &&
       (! ref($end2)  ||  ref($end2) ne 'Date::Manip::Date'  ||
        $end2->err())) {
      $$self{'err'} = 'End argument must be a date object.';
      return ();
   }

   my $start = $$self{'data'}{'start'};
   my $end   = $$self{'data'}{'end'};

   if (defined($start)  &&  defined($start2)) {
      # Choose the later of the two
      if ($start->cmp($start2) == -1) {
         $start = $start2;
      }
   } elsif (defined($start2)) {
      $start = $start2;
   }

   if (defined($end)  &&  defined($end2)) {
      # Choose the earlier of the two
      if ($end->cmp($end2) == 1) {
         $end = $end2;
      }
   } elsif (defined($end2)) {
      $end = $end2;
   }

   #
   # Make sure that basedate, start, and end are set as needed
   #
   # Start/end are required unless *Y:M:W:D:H:MN:S
   # Basedate required unless *Y:M:W:D:H:MN:S  or  @int = (0*,1)
   #


   if ($#int != -1) {
      if (! defined $start) {
         $$self{'err'} = 'Start date required';
         return ();
      }
      if ($$start{'err'}) {
         $$self{'err'} = 'Start date invalid';
         return ();
      }

      if (! defined $end) {
         $$self{'err'} = 'End date required';
         return ();
      }
      if ($$end{'err'}) {
         $$self{'err'} = 'End date invalid';
         return ();
      }

      if ($start->cmp($end) == 1) {
         return ();
      }
   }

   my $every = 0;
   my $tmp   = join('',@int);

   if ($tmp eq ''  ||  $tmp =~ /^0*1$/) {
      $$self{'data'}{'base'} = $start;
      $every = 1  if ($tmp ne '');

   } else {
      if (! defined $$self{'data'}{'base'}) {
         $$self{'err'} = 'Base date required';
         return ();
      }
      my $date = $$self{'data'}{'base'};
      if ($$date{'err'}) {
         $$self{'err'} = 'Base date invalid';
         return ();
      }
   }

   #
   # Handle the Y/M/W/D portion.
   #

   my (@date,@tmp);
   my ($err,@y,@m,@w,@d,@h,@mn,@s,@doy,@woy,@dow,@n);
   my $n = $#int + 1;

   my $m_empty   = $self->_field_empty($mf);
   my $w_empty   = $self->_field_empty($wf);
   my $d_empty   = $self->_field_empty($df);

   given($n) {

      when ([0,1]) {
         #
         # *Y:M:W:D:H:MN:S
         #  Y*M:W:D:H:MN:S
         #

         if ($#int == -1) {
            ($err,@y)  = $self->_rtime_values('y',$yf);
            return ()     if ($err);
         } else {
            my @tmp    = $self->_int_values($every,$yf,$start,$end);
            @y         = map { $$_[0] } @tmp;
         }

         if ( ($m_empty  &&  $w_empty  &&  $d_empty) ||
              (! $m_empty  &&  $w_empty) ) {

            #  *0:0:0:0       Jan 1 of the current year
            #  *1:0:0:0       Jan 1, 0001
            #  *0:2:0:0       Feb 1 of the current year
            #  *1:2:0:0       Feb 1, 0001
            #  *0:2:0:4       Feb 4th of the current year
            #  *1:2:0:4       Feb 4th, 0001
            #   1*0:0:0       every year on Jan 1
            #   1*2:0:0       every year on Feb 1
            #   1*2:0:4       every year on Feb 4th

            $mf = [1]  if ($m_empty);
            $df = [1]  if ($d_empty);

            ($err,@m)  = $self->_rtime_values('m',$mf);
            return ()  if ($err);

            foreach my $y (@y) {
               foreach my $m (@m) {
                  ($err,@d)  = $self->_rtime_values('day_of_month',$df,$y,$m);
                  return ()  if ($err);
                  foreach my $d (@d) {
                     push(@date,[$y,$m,$d,0,0,0]);
                  }
               }
            }

         } elsif ($m_empty) {

            if ($w_empty) {

               #  *0:0:0:4       the 4th day of the current year
               #  *1:0:0:4       the 4th day of 0001
               #   1*0:0:4       every year on the 4th day of the year

               foreach my $y (@y) {
                  ($err,@doy)  = $self->_rtime_values('day_of_year',$df,$y);
                  return ()  if ($err);
                  foreach my $doy (@doy) {
                     my($yy,$mm,$dd) = @{ $dmb->day_of_year($y,$doy) };
                     push(@date,[$yy,$mm,$dd,0,0,0]);
                  }
               }

            } elsif ($d_empty) {

               #  *0:0:3:0       the first day of the 3rd week of the curr year
               #  *1:0:3:0       the first day of the 3rd week of 0001
               #   1*0:3:0       every year on the first day of 3rd week of year

               foreach my $y (@y) {
                  ($err,@woy)  = $self->_rtime_values('week_of_year',$wf,$y);
                  return ()  if ($err);
                  foreach my $woy (@woy) {
                     my ($yy,$mm,$dd) = @{ $dmb->week_of_year($y,$woy) };
                     push(@date,[$yy,$mm,$dd,0,0,0]);
                  }
               }

            } else {

               #  *1:0:3:4       in 0001 on the 3rd Thur of the year
               #  *0:0:3:4       on the 3rd Thur of the current year
               #   1*0:3:4       every year on the 3rd Thur of the year

               ($err,@dow)  = $self->_rtime_values('day_of_week',$df);
               return ()  if ($err);
               foreach my $y (@y) {
                  foreach my $dow (@dow) {
                     ($err,@n) = $self->_rtime_values('dow_of_year',$wf,$y,$dow);
                     return ()  if ($err);
                     foreach my $n (@n) {
                        my $ymd =  $dmb->nth_day_of_week($y,$n,$dow);
                        my($yy,$mm,$dd) = @$ymd;
                        push(@date,[$yy,$mm,$dd,0,0,0]);
                     }
                  }
               }
            }

         } else {

            #  *1:2:3:4       in Feb 0001 on the 3rd Thur of the month
            #  *0:2:3:4       on the 3rd Thur of Feb in the curr year
            #  *1:2:3:0       the 3rd occurence of FirstDay in Feb 0001
            #  *0:2:3:0       the 3rd occurence of FirstDay in Feb of curr year
            #   1*2:3:4       every year in Feb on the 3rd Thur
            #   1*2:3:0       every year on the 3rd occurence of FirstDay in Feb

            ($err,@m)  = $self->_rtime_values('m',$mf);
            return ()  if ($err);
            if ($d_empty) {
               @dow = ($dmb->_config('firstday'));
            } else {
               ($err,@dow) = $self->_rtime_values('day_of_week',$df);
               return ()  if ($err);
            }

            foreach my $y (@y) {
               foreach my $m (@m) {
                  foreach my $dow (@dow) {
                     ($err,@n)  = $self->_rtime_values('dow_of_month',
                                                       $wf,$y,$m,$dow);
                     return ()  if ($err);
                     foreach my $n (@n) {
                        my $ymd =  $dmb->nth_day_of_week($y,$n,$dow,$m);
                        my($yy,$mm,$dd) = @$ymd;
                        push(@date,[$yy,$mm,$dd,0,0,0]);
                     }
                  }
               }
            }
         }
      }

      when (2) {
         #
         #  Y:M*W:D:H:MN:S
         #

         my @tmp = $self->_int_values($every,$yf,$mf,$start,$end);

         if ($w_empty) {

            #   0:2*0:0       every 2 months on the first day of the month
            #   0:2*0:4       every 2 months on the 4th day of the month
            #   1:2*0:0       every 1 year, 2 months on the first day of the month
            #   1:2*0:4       every 1 year, 2 months on the 4th day of the month

            $df  = [1]  if ($d_empty);

            foreach my $date (@tmp) {
               my($y,$m) = @$date;
               ($err,@d)  = $self->_rtime_values('day_of_month',$df,$y,$m);
               return ()  if ($err);
               foreach my $d (@d) {
                  push(@date,[$y,$m,$d,0,0,0]);
               }
            }

         } else {

            #   0:2*3:0       every 2 months on the 3rd occurence of FirstDay
            #   0:2*3:4       every 2 months on the 3rd Thur of the month
            #   1:2*3:0       every 1 year, 2 months on 3rd occurence of FirstDay
            #   1:2*3:4       every 1 year, 2 months on the 3rd Thur of the month

            if ($d_empty) {
               @dow = ($dmb->_config('firstday'));
            } else {
               ($err,@dow)  = $self->_rtime_values('day_of_week',$df);
               return ()  if ($err);
            }

            foreach my $date (@tmp) {
               my($y,$m) = @$date;
               foreach my $dow (@dow) {
                  ($err,@n)  = $self->_rtime_values('dow_of_month',
                                                    $wf,$y,$m,$dow);
                  return ()  if ($err);
                  foreach my $n (@n) {
                     my $ymd =  $dmb->nth_day_of_week($y,$n,$dow,$m);
                     my($yy,$mm,$dd) = @$ymd;
                     push(@date,[$yy,$mm,$dd,0,0,0]);
                  }
               }
            }
         }
      }

      when (3) {
         #
         #  Y:M:W*D:H:MN:S
         #

         #   0:0:3*0       every 3 weeks on FirstDay
         #   0:0:3*4       every 3 weeks on Thur
         #   0:2:3*0       every 2 months, 3 weeks on FirstDay
         #   0:2:3*4       every 2 months, 3 weeks on Thur
         #   1:0:3*0       every 1 year, 3 weeks on FirstDay
         #   1:0:3*4       every 1 year, 3 weeks on Thur
         #   1:2:3*0       every 1 year, 2 months, 3 weeks on FirstDay
         #   1:2:3*4       every 1 year, 2 months, 3 weeks on Thur

         my @tmp = $self->_int_values($every,$yf,$mf,$wf,$start,$end);

         my $fdow = $dmb->_config('firstday');
         if ($d_empty) {
            @dow = ($fdow);
         } else {
            ($err,@dow)  = $self->_rtime_values('day_of_week',$df);
            return ()  if ($err);
         }

         foreach my $date (@tmp) {
            my($y,$m,$d) = @$date;
            my ($mm,$dd);
            my($yy,$ww)     = $dmb->week_of_year([$y,$m,$d]);
            ($yy,$mm,$dd)   = @{ $dmb->week_of_year($yy,$ww) };

            foreach my $dow (@dow) {
               $dow += 7  if ($dow < $fdow);
               my($yyy,$mmm,$ddd) = @{ $dmb->calc_date_days([$yy,$mm,$dd],$dow-$fdow) };
               push(@date,[$yyy,$mmm,$ddd]);
            }
         }
      }

      when (4) {
         #
         # Y:M:W:D*H:MN:S
         #

         @date = $self->_int_values($every,$yf,$mf,$wf,$df,$start,$end);
      }

      when (5) {
         #
         # Y:M:W:D:H*MN:S
         #

         @date = $self->_int_values($every,$yf,$mf,$wf,$df,$hf,$start,$end);
      }

      when (6) {
         #
         # Y:M:W:D:H:MN*S
         #

         @date = $self->_int_values($every,$yf,$mf,$wf,$df,$hf,$mnf,$start,$end);
      }

      when (7) {
         #
         # Y:M:W:D:H:MN:S
         #

         @date = $self->_int_values($every,$yf,$mf,$wf,$df,$hf,$mnf,$sf,$start,$end);
      }
   }

   #
   # Handle the H/MN/S portion.
   #

   # Do seconds
   if (@rtime) {
      pop(@rtime);

      ($err,@s) = $self->_rtime_values('s',$sf);
      return ()  if ($err);
      $self->_field_add_values(\@date,5,@s);
   }

   # Do minutes
   if (@rtime) {
      pop(@rtime);

      ($err,@mn) = $self->_rtime_values('mn',$mnf);
      return ()  if ($err);
      $self->_field_add_values(\@date,4,@mn);
   }

   # Do hours
   if (@rtime) {
      pop(@rtime);

      ($err,@h) = $self->_rtime_values('h',$hf);
      return ()  if ($err);
      $self->_field_add_values(\@date,3,@h);
   }

   #
   # Apply modifiers
   #

   my @flags = @{ $$self{'data'}{'flags'} };
   if (@flags) {
      my $obj = $self->new_date();

      foreach my $date (@date) {
         my ($y,$m,$d,$h,$mn,$s) = @$date;

         foreach my $flag (@flags) {

            my(@wd,$today);
            given($flag) {

               when ('easter') {
                     ($m,$d) = $self->_easter($y);
               }

               when (/^([pn])([dt])([1-7])$/) {
                  my($forw,$today,$dow) = ($1,$2,$3);
                  $forw  = ($forw  eq 'p' ? 0 : 1);
                  $today = ($today eq 'd' ? 0 : 1);
                  ($y,$m,$d,$h,$mn,$s) =
                    @{ $obj->__next_prev([$y,$m,$d,$h,$mn,$s],$forw,$dow,$today) };
               }

               when (/^([fb])([dw])(\d+)$/) {
                  my($prev,$business,$n) = ($1,$2,$3);
                  $prev     = ($prev     eq 'b' ? 1 : 0);
                  $business = ($business eq 'w' ? 1 : 0);

                  if ($business) {
                     ($y,$m,$d,$h,$mn,$s) =
                       @{ $obj->__nextprev_business_day($prev,$n,0,[$y,$m,$d,$h,$mn,$s]) };
                  } else {
                     ($y,$m,$d) = @{ $dmb->calc_date_days([$y,$m,$d],$n,$prev) };
                  }
               }

               when ('nwd') {
                  if (! $obj->__is_business_day([$y,$m,$d,$h,$mn,$s],0)) {
                     ($y,$m,$d,$h,$mn,$s) =
                       @{ $obj->__nextprev_business_day(0,0,0,[$y,$m,$d,$h,$mn,$s]) };
                  }
               }

               when ('pwd') {
                  if (! $obj->__is_business_day([$y,$m,$d,$h,$mn,$s],0)) {
                     ($y,$m,$d,$h,$mn,$s) =
                       @{ $obj->__nextprev_business_day(1,1,0,[$y,$m,$d,$h,$mn,$s]) };
                  }
               }

               when ('dwd') {
                  if (! $obj->__is_business_day([$y,$m,$d,$h,$mn,$s],0)) {
                     continue;
                  }
               }

               when (['cwd','dwd']) {
                  if ($dmb->_config('tomorrowfirst')) {
                     @wd = ([$y,$m,$d,$h,$mn,$s],+1,  [$y,$m,$d,$h,$mn,$s],-1);
                  } else {
                     @wd = ([$y,$m,$d,$h,$mn,$s],-1,  [$y,$m,$d,$h,$mn,$s],+1);
                  }
                  continue;
               }

               when ('cwn') {
                  @wd = ([$y,$m,$d,$h,$mn,$s],+1,  [$y,$m,$d,$h,$mn,$s],-1);
                  $today = 0;
                  continue;
               }

               when ('cwp') {
                  @wd = ([$y,$m,$d,$h,$mn,$s],-1,  [$y,$m,$d,$h,$mn,$s],+1);
                  $today = 0;
                  continue;
               }

               default {
                  while (1) {
                     my(@d,$off);

                     # Test in the first direction

                     @d   = @{ $wd[0] };
                     $off = $wd[1];
                     @d   = @{ $dmb->calc_date_days(\@d,$off) };

                     if ($obj->__is_business_day(\@d,0)) {
                        ($y,$m,$d,$h,$mn,$s) = @d;
                        last;
                     }

                     $wd[0] = [@d];

                     # Test in the other direction

                     @d   = @{ $wd[2] };
                     $off = $wd[3];
                     @d   = @{ $dmb->calc_date_days(\@d,$off) };

                     if ($obj->__is_business_day(\@d,0)) {
                        ($y,$m,$d,$h,$mn,$s) = @d;
                        last;
                     }

                     $wd[2] = [@d];
                  }
               }

            }
         }

         @$date = ($y,$m,$d,$h,$mn,$s);
      }
   }

   #
   # Convert the dates (which fall into the valid range) to objects.
   #

   my(@ret,@start,@end);
   if (defined $start) {
      @start = @{ $$start{'data'}{'date'} };
   }
   if (defined $end) {
      @end   = @{ $$end{'data'}{'date'} };
   }

   foreach my $date (@date) {
      my @d = @$date;
      if (@start) {
         next  if ($dmb->cmp(\@start,\@d) > 0);
      }
      if (@end) {
         next  if ($dmb->cmp(\@d,\@end) > 0);
      }

      my $obj = $self->new_date();
      $obj->set('date',\@d);
      push(@ret,$obj);
   }

   #
   # Sort the dates
   #

   @ret = sort { $a->cmp($b) } @ret;
   return @ret;
}

########################################################################
# MISC
########################################################################

sub _rx {
   my($self,$rx) = @_;
   my $dmb       = $$self{'objs'}{'base'};

   return $$dmb{'data'}{'rx'}{'recur'}{$rx}
     if (exists $$dmb{'data'}{'rx'}{'recur'}{$rx});

   if ($rx eq 'std') {

      my $l      = '[0-9]*';
      my $r      = '[-,0-9]*';
      my $stdrx  = "(?<l>$l:$l:$l:$l:$l:$l:$l)(?<r>)|" .
                   "(?<l>$l:$l:$l:$l:$l:$l)\\*(?<r>$r)|" .
                   "(?<l>$l:$l:$l:$l:$l)\\*(?<r>$r:$r)|" .
                   "(?<l>$l:$l:$l:$l)\\*(?<r>$r:$r:$r)|" .
                   "(?<l>$l:$l:$l)\\*(?<r>$r:$r:$r:$r)|" .
                   "(?<l>$l:$l)\\*(?<r>$r:$r:$r:$r:$r)|" .
                   "(?<l>$l)\\*(?<r>$r:$r:$r:$r:$r:$r)|" .
                   "(?<l>)\\*(?<r>$r:$r:$r:$r:$r:$r:$r)";
      $$dmb{'data'}{'rx'}{'recur'}{$rx} = qr/^\s*(?:$stdrx)\s*$/;

   } elsif ($rx eq 'rfield' ||
            $rx eq 'rnum'   ||
            $rx eq 'rrange') {

      my $num    = '\-?\d+';
      my $range  = "$num\-$num";
      my $val    = "(?:$range|$num)";
      my $vals   = "$val(?:,$val)*";

      $$dmb{'data'}{'rx'}{'recur'}{'rfield'} = qr/^($vals)$/;
      $$dmb{'data'}{'rx'}{'recur'}{'rnum'}   = qr/^($num)$/;
      $$dmb{'data'}{'rx'}{'recur'}{'rrange'} = qr/^($num)\-($num)$/;

   } elsif ($rx eq 'each') {

      my $each  = $$dmb{'data'}{'rx'}{'each'};

      my $eachrx = qr/(?:^|\s+)(?:$each)(\s+|$)/i;
      $$dmb{'data'}{'rx'}{'recur'}{$rx} = $eachrx;

   } elsif ($rx eq 'ignore') {

      my $of    = $$dmb{'data'}{'rx'}{'of'};
      my $on    = $$dmb{'data'}{'rx'}{'on'};

      my $ignrx = qr/(?:^|\s+)(?:$on|$of)(\s+|$)/i;
      $$dmb{'data'}{'rx'}{'recur'}{$rx} = $ignrx;

   } elsif ($rx eq 'every') {

      my $month    = $$dmb{'data'}{'rx'}{'fields'}[2];
      my $week     = $$dmb{'data'}{'rx'}{'fields'}[3];
      my $day      = $$dmb{'data'}{'rx'}{'fields'}[4];

      my $last     = $$dmb{'data'}{'rx'}{'last'};
      my $nth      = $$dmb{'data'}{'rx'}{'nth'}[0];
      my $nth_wom  = $$dmb{'data'}{'rx'}{'nth_wom'}[0];
      my $nth_dom  = $$dmb{'data'}{'rx'}{'nth_dom'}[0];

      my $day_abb  = $$dmb{'data'}{'rx'}{'day_abb'}[0];
      my $day_name = $$dmb{'data'}{'rx'}{'day_name'}[0];
      my $mon_abb  = $$dmb{'data'}{'rx'}{'month_abb'}[0];
      my $mon_name = $$dmb{'data'}{'rx'}{'month_name'}[0];

      my $beg      = '(?:^|\s+)';
      my $end      = '(?:\s*$)';

      $month       = "$beg(?<month>$month)";         # months
      $week        = "$beg(?<week>$week)";           # weeks
      $day         = "$beg(?<day>$day)";             # days

      $last        = "$beg(?<last>$last)";           # last
      $nth         = "$beg(?<nth>$nth)";             # 1st,2nd,...
      $nth_wom     = "$beg(?<nth>$nth_wom)";         # 1st - 5th
      $nth_dom     = "$beg(?<nth>$nth_dom)";         # 1st - 31st
      my $n        = "$beg(?<n>\\d+)";               # 1,2,...

      my $dow      = "$beg(?:(?<day_name>$day_name)|(?<day_abb>$day_abb))";  # Sun|Sunday
      my $mmm      = "$beg(?:(?<mon_name>$mon_name)|(?<mon_abb>$mon_abb))";  # Jan|January

      my $y        = "(?:$beg(?:(?<y>\\d\\d\\d\\d)|(?<y>\\d\\d)))?";

      my $freqrx   =
        "$nth_wom?$dow$mmm$y|" .   # every DoW in MMM [YY]
        "$last$dow$mmm$y|" .       # Nth DoW in MMM [YY]
                                   # last DoW in MMM [YY]
                                   #    day_name|day_abb
                                   #    mon_name|mon_abb
                                   #    last*|nth*
                                   #    y*
        "$nth_wom?$dow$month$y|" . # every DoW of every month [YY]
        "$last$dow$month$y|" .     # Nth DoW of every month [YY]
                                   # last DoW of every month [YY]
                                   #    day_name|day_abb
                                   #    last*|nth*
                                   #    y*
        "$nth_dom?$day$month$y|" . # every day of every month [YY]
        "$last$day$month$y|" .     # Nth day of every month [YY]
                                   # last day of every month [YY]
                                   #    day
                                   #    month
                                   #    nth*|last*
                                   #    y*
        "$nth*$day$y|" .           # every day [YY]
        "$n$day$y";                # every Nth day [YY]
                                   # every N days [YY]
                                   #    day
                                   #    nth*|n*
                                   #    y*

      $freqrx = qr/^(?:$freqrx)\s*$/i;
      $$dmb{'data'}{'rx'}{'recur'}{$rx} = $freqrx;
   }

   return $$dmb{'data'}{'rx'}{'recur'}{$rx};
}

########################################################################
# MISC
########################################################################

# This returns the date easter occurs on for a given year as ($month,$day).
# This is from the Calendar FAQ.
#
sub _easter {
  my($self,$y) = @_;

  my($c) = $y/100;
  my($g) = $y % 19;
  my($k) = ($c-17)/25;
  my($i) = ($c - $c/4 - ($c-$k)/3 + 19*$g + 15) % 30;
  $i     = $i - ($i/28)*(1 - ($i/28)*(29/($i+1))*((21-$g)/11));
  my($j) = ($y + $y/4 + $i + 2 - $c + $c/4) % 7;
  my($l) = $i-$j;
  my($m) = 3 + ($l+40)/44;
  my($d) = $l + 28 - 31*($m/4);
  return ($m,$d);
}

# This returns 1 if a field is empty.
#
sub _field_empty {
   my($self,$val) = @_;

   if (ref($val)) {
      my @tmp = @$val;
      return 1  if ($#tmp == -1  ||
                    ($#tmp == 0  &&  ! ref($tmp[0])  &&  ! $tmp[0]));
      return 0;

   } else {
      return $val;
   }
}

# This returns a list of values as determined by the interval value,
# the base date, and the range.
#
# Usage:
#   _int_values($every,$y,$m,$w,$d,$h,$mn,$s,$start,$end);
#
# Every argument is optional (except $every and $y), so the following
# are valid:
#   _int_values($every,$y,$m,$start,$end);
#   _int_values($every,$y,$m,$w,$d,$start,$end);
#
sub _int_values {
   my($self,$every,@args) = @_;
   my $end                = pop(@args);
   my $start              = pop(@args);
   my $dmb                = $$self{'objs'}{'base'};
   my @vals;

   # Get the start, end, and base dates.
   #
   # Also, get the range of dates to search (which is the start and end
   # dates adjusted due to various modifiers.

   my $base   = $$self{'data'}{'base'};
   my @base   = @{ $$base{'data'}{'date'} };

   my @start  = @{ $$start{'data'}{'date'} };
   my @startm = @{ $$self{'data'}{'startm'} };

   my @end    = @{ $$end{'data'}{'date'} };
   my @endm   = @{ $$self{'data'}{'endm'} };

   my @date0  = @{ $dmb->calc_date_delta(\@start,\@startm) };
   my @date1  = @{ $dmb->calc_date_delta(\@end,\@endm) };

   # Get the delta which will be used to adjust the base date
   # from one recurrence to the next.

   my @delta = @args;
   while ($#delta < 6) {
      push(@delta,0);
   }

   # The base date will be used as the date for one recurrence.
   #
   # To begin with, move it so that it is before date0 (we have to
   # use the $subtract=2 form so we make sure that each step backward
   # results in a date which can step forward to the base date.

   while ($dmb->cmp(\@base,\@date0) > -1) {
      @base = @{ $start->__calc_date_delta_inverse([@base],[@delta]) };
   }

   # Now, move the base date to be on or after date0

   while ($dmb->cmp(\@base,\@date0) == -1) {
      @base = @{ $dmb->calc_date_delta(\@base,\@delta) };
   }

   # While the base date is on or before date1, add it to the
   # list and move forward.

   while ($dmb->cmp(\@base,\@date1) < 1) {
      push(@vals,[@base]);
      @base = @{ $dmb->calc_date_delta(\@base,\@delta) };
   }

   return @vals;
}

# This returns a list of values that appear in a field in the rtime.
#
# $val is a listref, with each element being a value or a range.
#
# Usage:
#   _rtime_values('y'            ,$y);
#   _rtime_values('m'            ,$m);
#   _rtime_values('week_of_year' ,$w    ,$y);
#   _rtime_values('dow_of_year'  ,$w    ,$y,$dow);
#   _rtime_values('dow_of_month' ,$w    ,$y,$m,$dow);
#   _rtime_values('day_of_year'  ,$d    ,$y);
#   _rtime_values('day_of_month' ,$d    ,$y,$m);
#   _rtime_values('day_of_week'  ,$d);
#   _rtime_values('h'            ,$h);
#   _rtime_values('mn'           ,$mn);
#   _rtime_values('s'            ,$s);
#
# Returns ($err,@vals)
#
sub _rtime_values {
   my($self,$type,$val,@args) = @_;
   my $dmb                    = $$self{'objs'}{'base'};

   given($type) {

      when ('h') {
         @args = (0,0,23,23);
      }

      when ('mn') {
         @args = (0,0,59,59);
      }

      when ('s') {
         @args = (0,0,59,59);
      }

      when ('y') {
         my ($curry) = $dmb->_now('y',1);
         foreach my $y (@$val) {
            $y = $curry  if (! ref($y)  &&  $y==0);
         }

         @args = (0,1,9999,9999);
      }

      when ('m') {
         @args = (0,1,12,12);
      }

      when ('week_of_year') {
         my($y)  = @args;
         my $wiy = $dmb->weeks_in_year($y);
         @args = (1,1,$wiy,53);
      }

      when ('dow_of_year') {
         my($y,$dow) = @args;

         # Get the 1st occurence of $dow
         my $d0   = 1;
         my $dow0 = $dmb->day_of_week([$y,1,$d0]);
         if ($dow > $dow0) {
            $d0  += ($dow-$dow0);
         } elsif ($dow < $dow0) {
            $d0  += 7-($dow0-$dow);
         }

         # Get the last occurrence of $dow
         my $d1   = 31;
         my $dow1 = $dmb->day_of_week([$y,12,$d1]);
         if ($dow1 > $dow) {
            $d1  -= ($dow1-$dow);
         } elsif ($dow1 < $dow) {
            $d1  -= 7-($dow-$dow1);
         }

         # Find out the number of occurrenced of $dow
         my $doy1 = $dmb->day_of_year([$y,12,$d1]);
         my $n    = ($doy1 - $d0)/7 + 1;

         # Get the list of @w
         @args = (1,1,$n,53);
      }

      when ('dow_of_month') {
         my($y,$m,$dow) = @args;

         # Get the 1st occurence of $dow in the month
         my $d0   = 1;
         my $dow0 = $dmb->day_of_week([$y,$m,$d0]);
         if ($dow > $dow0) {
            $d0  += ($dow-$dow0);
         } elsif ($dow < $dow0) {
            $d0  += 7-($dow0-$dow);
         }

         # Get the last occurrence of $dow
         my $d1   = $dmb->days_in_month($y,$m);
         my $dow1 = $dmb->day_of_week([$y,$m,$d1]);
         if ($dow1 > $dow) {
            $d1  -= ($dow1-$dow);
         } elsif ($dow1 < $dow) {
            $d1  -= 7-($dow-$dow1);
         }

         # Find out the number of occurrenced of $dow
         my $n    = ($d1 - $d0)/7 + 1;

         # Get the list of @w
         @args = (1,1,$n,5);
      }

      when ('day_of_year') {
         my($y)  = @args;
         my $diy = $dmb->days_in_year($y);
         @args = (1,1,$diy,366);
      }

      when ('day_of_month') {
         my($y,$m) = @args;
         my $dim = $dmb->days_in_month($y,$m);
         @args = (1,1,$dim,31);
      }

      when ('day_of_week') {
         @args = (0,1,7,7);
      }
   }

   my($err,@vals) = $self->__rtime_values($val,@args);
   if ($err) {
      $$self{'err'} = "[dates] $err [$type]";
      return (1);
   }
   return(0,@vals);
}

# This returns the raw values for a list.
#
# If $allowneg is 0, only positive numbers are allowed, and they must be
# in the range [$min,$absmax]. If $allowneg is 1, positive numbers in the
# range [$min,$absmax] and negative numbers in the range [-$absmax,-$min]
# are allowed. An error occurs if a value falls outside the range.
#
# Only values in the range of [$min,$max] are actually kept. This allows
# a recurrence for day_of_month to be 1-31 and not fail for a month that
# has fewer than 31 days. Any value outside the [$min,$max] are silently
# discarded.
#
# Returns:
#   ($err,@vals)
#
sub __rtime_values {
   my($self,$vals,$allowneg,$min,$max,$absmax) = @_;
   my(@ret);

   foreach my $val (@$vals) {

      if (ref($val)) {
         my($val1,$val2) = @$val;

         if ($allowneg) {
            return ('Value outside range')
              if ( ($val1 >= 0  &&  ($val1 < $min  ||  $val1 > $absmax) ) ||
                   ($val2 >= 0  &&  ($val2 < $min  ||  $val2 > $absmax) ) );
            return ('Negative value outside range')
              if ( ($val1 <= 0  &&  ($val1 < -$absmax  ||  $val1 > -$min) ) ||
                   ($val2 <= 0  &&  ($val2 < -$absmax  ||  $val2 > -$min) ) );

         } else {
            return ('Value outside range')
              if ( ($val1 < $min  ||  $val1 > $absmax) ||
                   ($val2 < $min  ||  $val2 > $absmax) );

         }

         return ('Range values reversed')
           if ( ($val1 <= 0  &&  $val2 <= 0  &&  $val1 > $val2)  ||
                ($val1 >= 0  &&  $val2 >= 0  &&  $val1 > $val2) );

         # Use $max instead of $absmax when converting negative numbers to
         # positive ones.

         $val1 = $max + $val1 + 1  if ($val1 < 0);    # day -10
         $val2 = $max + $val2 + 1  if ($val2 < 0);

         $val1 = $min              if ($val1 < $min); # day -31 in a 30 day month
         $val2 = $max              if ($val2 > $max);

         next  if ($val1 > $val2);

         push(@ret,$val1..$val2);

      } else {

         if ($allowneg) {
            return ('Value outside range')
              if ($val >= 0  &&  ($val < $min  ||  $val > $absmax));
            return ('Negative value outside range')
              if ($val <= 0  &&  ($val < -$absmax  ||  $val > -$min));
         } else {
            return ('Value outside range')
              if ($val < $min  ||  $val > $absmax);
         }

         # Use $max instead of $absmax when converting negative numbers to
         # positive ones.

         my $ret;
         if ($val < 0 ) {
            $ret    = $max + $val + 1;
         } else {
            $ret    = $val;
         }

         next  if ($ret > $max || $ret < $min);
         push(@ret,$ret);
      }
   }

   return ('',@ret);
}

# This takes a list of dates (each a listref of [y,m,d,h,mn,s]) and replaces
# the Nth field with all of the possible values passed in, creating a new
# list with all the dates.
#
sub _field_add_values {
   my($self,$datesref,$n,@val) = @_;

   my @dates = @$datesref;
   my @tmp;

   foreach my $date (@dates) {
      my @d = @$date;
      foreach my $val (@val) {
         $d[$n] = $val;
         push(@tmp,[@d]);
      }
   }

   @$datesref = @tmp;
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
