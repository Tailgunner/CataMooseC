@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
"%~dp0perl.exe" -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
"%~dp0perl.exe" -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!/usr/bin/perl -w
#line 15

use strict;
use Getopt::Long;
use POE::Test::Loops;

my ($dir_base, $flag_help, @loop_modules, $flag_verbose);
my $result = GetOptions(
  'dirbase=s' => \$dir_base,
  'loop=s' => \@loop_modules,
  'verbose' => \$flag_verbose,
  'help' => \$flag_help,
);

if (
  !$result or !$dir_base or $flag_help or !@loop_modules
) {
  die(
    "$0 usage:\n",
    "  --dirbase DIR   (required) base directory for tests\n",
    "  --loop MODULE   (required) loop modules to test\n",
    "  --verbose   show some extra output\n",
    "  --help   you're reading it\n",
  );
}

POE::Test::Loops::generate($dir_base, \@loop_modules, $flag_verbose);
exit 0;

__END__

=head1 NAME

poe-gen-tests - generate standard POE tests for third-party modules

=head1 SYNOPSIS

  poe-gen-tests --dirbase t/loops \
    --loop Glib \
    --loop Kqueue \
    --loop Event::Lib \
    --loop POE::XS::Loop::Poll

=head1 DESCRIPTION

This program and the accompanying POE::Test::Loop::* modules make up
POE's tests for POE::Loop subclasses.  These tests are designed to run
identically regardless of the current event loop.  POE uses them to
test the event loops it bundles:

  POE::Loop::Gtk
  POE::Loop::IO_Poll (--loop IO::Poll)
  POE::Loop::Tk
  POE::Loop::Event
  POE::Loop::Select

Developers of other POE::Loop modules are encouraged use this package
to generate over 420 comprehensive tests for their own work.

=head1 USAGE

poe-gen-tests creates test files for one or more event loops beneath
the directory specified in --dirbase.  For example,

  poe-gen-tests --dirbase t/loops --loop Select

generates the following test files:

  t/loops/select/all_errors.t
  t/loops/select/comp_tcp.t
  t/loops/select/comp_tcp_concurrent.t
  t/loops/select/connect_errors.t
  t/loops/select/k_alarms.t
  t/loops/select/k_aliases.t
  t/loops/select/k_detach.t
  t/loops/select/k_selects.t
  t/loops/select/k_sig_child.t
  t/loops/select/k_signals.t
  t/loops/select/k_signals_rerun.t
  t/loops/select/sbk_signal_init.t
  t/loops/select/ses_nfa.t
  t/loops/select/ses_session.t
  t/loops/select/wheel_accept.t
  t/loops/select/wheel_curses.t
  t/loops/select/wheel_readline.t
  t/loops/select/wheel_readwrite.t
  t/loops/select/wheel_run.t
  t/loops/select/wheel_sf_ipv6.t
  t/loops/select/wheel_sf_tcp.t
  t/loops/select/wheel_sf_udp.t
  t/loops/select/wheel_sf_unix.t
  t/loops/select/wheel_tail.t

The --loop parameter is either a POE::Loop::... class name or the
event loop class that will complete the POE::Loop::... package name.

  poe-gen-tests --dirbase t/loops --loop Event::Lib
  poe-gen-tests --dirbase t/loops --loop POE::Loop::Event_Lib

poe-gen-tests looks for a "=for poe_tests" or "=begin poe_tests"
section within the POE::Loop class being tested.  If defined, this
section should include a single function, skip_tests(), that
determines whether any given test should be skipped.

Please see L<perlpod> for syntax for "=for" and "=begin".  Also see
L<PODDITIES> for notable differences between POE::Test::Loop's POD
support and the standard.

skip_tests() is called with one parameter, the base name of the test
about to be executed.  It returns false if the test should run, or a
message that will be displayed to the user explaining why the test
will be skipped.  This message is passed directly to Test::More's
plan() along with "skip_all".  The logic is essentially:

  if (my $why = skip_tests("k_signals_rerun")) {
    plan skip_all => $why;
  }

skip_tests() should load any modules required by the event loop.  See
most of the examples below.

=head2 Example poe_tests Directives

POE::Loop::Event checks whether the Event module exists and can be
loaded, then whether specific tests can run under specific operating
systems.

  =for poe_tests
  sub skip_tests {
    return "Event tests require the Event module" if (
      do { eval "use Event"; $@ }
    );
    my $test_name = shift;
    if ($test_name eq "k_signals_rerun" and $^O eq "MSWin32") {
      return "This test crashes Perl when run with Tk on $^O";
    }
    if ($test_name eq "wheel_readline" and $^O eq "darwin") {
      return "Event skips two of its own tests for the same reason";
    }
  }

POE::Loop::Gtk checks whether DISPLAY is set, which implies that X is
running.  It then checks whether Gtk is available, loadable, and
safely initializable before skipping specific tests.

  =for poe_tests
  sub skip_tests {
    my $test_name = shift;
    return "Gtk needs a DISPLAY (set one today, okay?)" unless (
      defined $ENV{DISPLAY} and length $ENV{DISPLAY}
    );
    return "Gtk tests require the Gtk module" if do { eval "use Gtk"; $@ };
    return "Gtk init failed.  Is DISPLAY valid?" unless defined Gtk->init_check;
    if ($test_name eq "z_rt39872_sigchld_stop") {
      return "Gdk crashes";
    }
    return;
  }

POE::Loop::IO_Poll checks for system compatibility before verifying
that IO::Poll is available and loadable.

  =for poe_tests
  sub skip_tests {
    return "IO::Poll is not 100% compatible with $^O" if $^O eq "MSWin32";
    return "IO::Poll tests require the IO::Poll module" if (
      do { eval "use IO::Poll"; $@ }
    );
  }

POE::Loop::Select has no specific requirements.

  =for poe_tests
  sub skip_tests { return }

POE::Loop::Tk needs an X display (except on Windows).  Tk is not safe
for fork(), so skip tests that require forking.  And finally, check
whether the Tk module is available, loadable, and runnable.

  =for poe_tests
  sub skip_tests {
    return "Tk needs a DISPLAY (set one today, okay?)" unless (
      (defined $ENV{DISPLAY} and length $ENV{DISPLAY}) or $^O eq "MSWin32"
    );
    my $test_name = shift;
    if ($test_name eq "k_signals_rerun" and $^O eq "MSWin32") {
      return "This test crashes Perl when run with Tk on $^O";
    }
    return "Tk tests require the Tk module" if do { eval "use Tk"; $@ };
    my $m = eval { Tk::MainWindow->new() };
    if ($@) {
      my $why = $@;
      $why =~ s/ at .*//;
      return "Tk couldn't be initialized: $why";
    }
    return;
  }

=head1 INSTALL SCRIPT INTEGRATION

The POE::Loop tests started out as part of the POE distribution.  All
the recommendations and examples that follow are written and tested
against ExtUtils::MakeMaker because that's what POE uses.  Please
adjust these recipes according to your taste and preference.

=head2 Calling the Test Generator

Tests need to be generated prior to the user or CPAN shell running
"make test".  A tidy way to do this might be to create a new Makefile
target and include that as a dependency for "make test".  POE takes a
simpler approach, calling the script from its Makefile.PL:

  system(
    $^X, "poe-gen-tests", "--dirbase", "t/30_loops",
    "--loop", "Event", "--loop", "Gtk", "--loop", "IO::Poll",
    "--loop", "Select", "--loop", "Tk",
  ) and die $!;

The previous approach generates tests at install time, so it's not
necessary to include the generated files in the MANIFEST.  Test
directories should also be excluded from the MANIFEST.  poe-gen-tests
will create the necessary paths.

It's also possible to generate the tests prior to "make dist".  The
distribution's MANIFEST must include the generated files in this case.

Most people will not need to add the generated tests to their
repositories.

=head1 Running the Tests

By default, ExtUtils::MakeMaker generates Makefiles that only run
tests matching t/*.t.  However authors are allowed to specify other
test locations.  Add the following parameter to WriteMakefile() so
that the tests generated above will be executed:

  tests => {
    TESTS => "t/*.t t/30_loops/*/*.t",
  }

=head1 CLEANING UP

Makefiles will not clean up files that aren't present in the MANIFEST.
This includes tests generated at install time.  If this bothers you,
you'll need to add directives to include the generated tests in the
"clean" and "distclean" targets.

  clean => {
    FILES => "t/30_loops/*/* t/30_loops/*",
  }

This assumes the "t/30_loops" directory contains only generated tests.
It's recommended that generated and hand-coded tests not coexist in
the same directory.

It seems like a good idea to delete the deeper directories and files
before their parents.

=head1 Skipping Network Tests

Some generated tests require a network to be present and accessible.
Those tests will be skipped unless the file "run_network_tests" is
present in the main distribution directory.  You can include that file
in your distribution's tarball, but it's better create it at install
time after asking the user.  Here's how POE does it.  Naturally you're
free to do it some other way.

  # Switch to default behavior if STDIN isn't a tty.

  unless (-t STDIN) {
    warn(
      "\n",
      "=============================================\n\n",
      "STDIN is not a terminal.  Assuming --default.\n\n",
      "=============================================\n\n",
    );
    push @ARGV, "--default";
  }

  # Remind the user she can use --default.

  unless (grep /^--default$/, @ARGV) {
    warn(
      "\n",
      "================================================\n\n",
      "Prompts may be bypassed with the --default flag.\n\n",
      "================================================\n\n",
    );
  }

  # Should we run the network tests?

  my $prompt = (
    "Some of POE's tests require a functional network.\n" .
    "You can skip these tests if you'd like.\n\n" .
    "Would you like to skip the network tests?"
  );

  my $ret = "n";
  if (grep /^--default$/, @ARGV) {
    print $prompt, " [$ret] $ret\n\n";
  }
  else {
    $ret = prompt($prompt, "n");
  }

  my $marker = 'run_network_tests';
  unlink $marker;
  unless ($ret =~ /^Y$/i) {
    open(TOUCH,"+>$marker") and close TOUCH;
  }

  print "\n";

=head1 Skipping Other Tests

POE's loop tests will enable or disable tests based on the event
loop's capabilities.  Distributions and event loops may set these
variables to signal which tests are okay to run.

=head2 POE_LOOP_USES_POLL

Some platforms do not support poll() on certain kinds of filehandles.
Event loops that use poll() should set this environment variable to a
true value.  It will cause the tests to skip this troublesome
combination.

=head2 PODDITIES

Previous versions of POE::Test::Loops documented "=for poe_tests"
sections terminated by =cut and containing blank lines.  This is
incorrect POD syntax, and it's the reason the skip_tests() functions
showed up in perldoc and on search.cpan.org.  The following syntax is
wrong and should not have been used.  I'm so sorry.

  =for poe_tests

  sub skip_tests { ... }

  =cut

The proper syntax is to terminate "=for poe_tests" with a blank line:

  =for poe_tests
  sub skip_tests {
    ...
  }

Multi-line tests containing blank lines can be specified using POD's
"=begin poe_tests" terminated by "=end poe_tests".

  =begin poe_tests

  sub skip_tests {
    ...
  }

  =end poe_tests

All three syntaxes above are supported as of POE::Test::Loops version
1.034.  The incorrect =for syntax is deprecated and will be removed in
some future release.

=head1 SEE ALSO

L<POE::Test::Loops>, L<POE::Loop>, L<perlpod>.

=head2 BUG TRACKER

https://rt.cpan.org/Dist/Display.html?Status=Active&Queue=POE-Test-Loops

=head2 REPOSITORY

https://poe.svn.sourceforge.net/svnroot/poe/trunk/poe-test-loops

=head2 OTHER RESOURCES

http://search.cpan.org/dist/POE-Test-Loops/

=head1 AUTHOR & COPYRIGHT

Rocco Caputo <rcaputo@cpan.org>.
Benjamin Smith <bsmith@cpan.org>.
Countless other people.

These tests are Copyright 1998-2009 by Rocco Caputo, Benjamin Smith,
and countless contributors.  All rights are reserved.  These tests are
free software; you may redistribute them and/or modify them under the
same terms as Perl itself.

Thanks to Martijn van Beers for beta testing and suggestions.

=cut

__END__
:endofperl
