package Date::Manip::Obj;
# Copyright (c) 2008-2010 Sullivan Beck. All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

########################################################################
########################################################################

require 5.010000;
use warnings;
use strict;
use IO::File;
use Storable qw(dclone);

use Date::Manip::Base;
use Date::Manip::TZ;

use vars qw($VERSION);
$VERSION='6.11';

########################################################################
# METHODS
########################################################################

my $dmo_rx = qr/^Date::Manip::(Base|TZ|Date|Delta|Recur)$/;
my $dmh_rx = qr/^Date::Manip::(Date|Delta|Recur)$/;

sub new {
   my(@args)    = @_;
   my(@allargs) = @args;

   # Get the object or class.

   my($self,$class);

   if      (ref($args[0]) =~ $dmo_rx) {
      $self  = shift(@args);
      $class = ref($args[0]);

   } elsif ($args[0] =~ $dmo_rx) {
      $class = shift(@args);

   } else {
      warn "ERROR: [new] first argument must be a Date::Manip class/object\n";
      return undef;
   }

   # Get an existing Date::Manip::* object, if any

   my $obj;
   if ($self) {
      $obj = $self;
   } elsif (ref($args[0]) =~ $dmo_rx) {
      $obj = shift(@args);
   }

   # Find out if there are any config options (which will be the
   # final argument).

   my @config;
   if (@args  &&  ref($args[$#args]) eq 'ARRAY') {
      @config = @{ pop(@args) };
   }

   # Any other arguments at this point are passed to _init.

   # Get Base/TZ objects from an existing object

   my($dmt,$dmb);

   if ($obj) {
      $dmb = $$obj{'objs'}{'base'}  if (exists $$obj{'objs'}{'base'});
      $dmt = $$obj{'objs'}{'tz'}    if (exists $$obj{'objs'}{'tz'});
   }

   # Create a new empty object.

   my $new = {
              'objs' => {},
              'data' => {},
              'args' => [ @args ],
              'err'  => '',
             };

   # Create new Base/TZ objects if necessary

   my $init = 1;
   if (! $dmb) {

      # We're creating first-time instances:
      #    $dmb = new Date::Manip::Base [,\@config];
      #    $dmt = new Date::Manip::TZ [,\@config];
      #    $obj = new Date::Manip::* [,\@config];

      if      ($class eq 'Date::Manip::Base') {
         $dmb = $new;

      } elsif ($class eq 'Date::Manip::TZ') {
         $dmb = new Date::Manip::Base;
         $dmt = $new;

      } else {
         $dmb = new Date::Manip::Base;
         $dmt = new Date::Manip::TZ $dmb;
      }

   } elsif ($class eq 'Date::Manip::Base') {

      # $dmb = new Date::Manip::Base $obj [,\@config];
      #    This should create a new instance of a Base object
      #    with the same configuration.

      $new           = dclone($dmb);
      $$new{'cache'} = $$dmb{'cache'};
      $dmb           = $new;
      $init          = 0;

   } elsif (@config  &&  $class eq 'Date::Manip::TZ') {

      # $dmt = new Date::Manip::TZ $obj,\@config;

      $dmb           = new Date::Manip::Base $obj,[@config];
      $dmt           = $new;

   } elsif (@config) {

      # $obj2 = new Date::Manip::* $obj1,\@config;

      $dmb = new Date::Manip::Base $obj,\@config;
      $dmt = new Date::Manip::TZ $dmb;

   } elsif ($class eq 'Date::Manip::TZ') {

      # $dmt = new Date::Manip::TZ $obj;
      #    Reuse $dmb object

      $dmt = $new;

   } else {

      # $obj2 = new Date::Manip::* $boj1;
      #    Use existing $dmb/$dmt

   }

   bless $new,$class;

   $$new{'objs'}{'base'} = $dmb;
   $$new{'objs'}{'tz'}   = $dmt  if ($dmt);
   $$dmb{'objs'}{'tz'}   = $dmt  if ($dmt);

   $new->_init()  unless (! $init);

   # Apply configuration options and parse the string.

   if (@config) {
      $dmb->config(@config);
   }

   $new->_init_args()  if (@args);
   $new->_init_final();

   return $new;
}

sub _init_args {
   my($self) = @_;

   my @args = @{ $$self{'args'} };
   if (@args) {
      warn "WARNING: [new] invalid arguments: @args\n";
   }
}

sub _init_final {
   my($self) = @_;
   return;
}

sub new_config {
   my(@args) = @_;

   # Make sure that @opts is passed in as the final argument.

   if (! @args  ||
       ! (ref($args[$#args]) eq 'ARRAY')) {
      push(@args,['ignore','ignore']);
   }

   return new(@args);
}

sub base {
   my($self) = @_;
   return $$self{'objs'}{'base'};
}

sub tz {
   my($self) = @_;
   return $$self{'objs'}{'tz'}  if (exists $$self{'objs'}{'tz'});
   return undef;
}

sub config {
   my($self,@config) = @_;
   my $dmb = $$self{'objs'}{'base'};

   while (@config) {
      my $var = shift(@config);
      my $val = shift(@config);
      $dmb->_config_var($var,$val);
   }
}

sub err {
   my($self,$arg) = @_;
   if ($arg) {
      $$self{'err'} = '';
      return;
   } else {
      return $$self{'err'};
   }
}

sub new_date {
   my(@args) = @_;
   require Date::Manip::Date;
   return new Date::Manip::Date @args;
}
sub new_delta {
   my(@args) = @_;
   require Date::Manip::Delta;
   return new Date::Manip::Delta @args;
}
sub new_recur {
   my(@args) = @_;
   require Date::Manip::Recur;
   return new Date::Manip::Recur @args;
}

sub is_date {
   return 0;
}
sub is_delta {
   return 0;
}
sub is_recur {
   return 0;
}

sub version {
   my($self,$flag) = @_;
   if ($flag  &&  ref($self) ne "Date::Manip::Base") {
      my $dmb  = $$self{'objs'}{'base'};
      my ($tz) = $dmb->_now("systz");
      return "$VERSION [$tz]";
   } else {
      return $VERSION;
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
