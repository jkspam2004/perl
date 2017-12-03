#!/usr/bin/perl -w

use strict;

my $pid = $$;
print "pid: ". $pid . "\n";
 
my $cpid = fork(); # both parent and child execute line after the fork
print "\tchild: " . $cpid . "\n";

if ($cpid == 0) { 
    print "we're the child $$, cpid: $cpid\n";
} elsif (!defined($cpid)) {
    print "couldn't fork child $$, cpid: $cpid\n";
} else { # cpid is non-zero
    print "we are the parent $$, cpid: $cpid\n";
}

__END__
fork() returns a zero to the newly created child process.
fork() returns a positive value, the process ID of the child process, to the parent.
