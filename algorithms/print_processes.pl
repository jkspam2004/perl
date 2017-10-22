#!/usr/bin/perl -w
use strict;
use Data::Dumper;

sub get_data {
    my $ps_hash = {};
    open(PS, "ps -e l |") or die "cannot open: $!\n";

    my $first = <PS>; # remove header line
    while (<PS>) {
        chomp($_);

        my @items = split(/\s+/, $_, 13);
        my ($pid, $ppid, $cmd) = ($items[2], $items[3], $items[12]);

        # store the command and initialize children for current pid
        $ps_hash->{$pid}->{children} = [] if (!exists($ps_hash->{$pid}));
        $ps_hash->{$pid}->{parent_id} = $ppid;
        $ps_hash->{$pid}->{cmd} = $cmd;

        # add current pid as a child to the parent's process
        $ps_hash->{$ppid}->{children} = [] if (!exists($ps_hash->{$ppid}));
        push(@{$ps_hash->{$ppid}->{children}}, $pid);

    }
    return $ps_hash;
}

sub print_processes {
    my $ps_hash = get_data();
    #print Dumper($ps_hash);

    printf "%5s%s%s\n", "PID", "  ", "COMMAND";

    my $walk_tree;
    $walk_tree = sub {
        my $pid = shift;
        my $indent = shift;
        my $level = shift;

        # make some adjustment to spacing depending on pid/ppid
        if ($pid > 0) {
            my $space = $ps_hash->{$pid}->{parent_id} =~ /^[01]$/ ? "  " : $indent . " \\_ ";
            printf "%5d%s%-.100s\n", $pid, $space, $ps_hash->{$pid}->{cmd};
            $indent .= "  " if ($pid > 1);
            $indent .= "  " if ($level >= 2);
        }

        # depth first, recurse through children's children
        foreach my $child (sort {$a <=> $b} @{$ps_hash->{$pid}->{children}}) {
            $level++;
            $walk_tree->($child, $indent, $level);
            $level = 0;
        }
    };
    $walk_tree->(0, "", 0);

    return;
}

print_processes();

1;

=head1 NAME

    main::print_processes

=head1 SYNOPSIS

    print_processes();

=head1 DESCRIPTION

This module displays a hierarchy of processes on a Linux computer 
similar to ps -axf

=head2 Methods

=over 12

=item C<get_data>

Returns a hash ref to ps output.

=item C<print_processes>

Walks through ps output and displays hierachy of processes.

=back
