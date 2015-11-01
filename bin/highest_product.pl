#!/usr/bin/perl -w
#
# find the highest product of three integers

use strict;
use Data::Dumper;
$Data::Dumper::Sortkeys = 1;

my $highest = get_highest_product_of_three([ 1, 10, -5, 1, -100 ]);
#my $highest = &get_highest_product_of_three_sorting;
print "$highest\n";

# we need:
# highest product of 3 ints
# highest product of 2
# lowest product of 2
# highest int
# lowest
# O(n) time, O(1) space
sub get_highest_product_of_three {
    my $val = shift;
    my @integers = @$val;
    
    my $highest_product_of_two = $integers[0] * $integers[1];
    my $lowest_product_of_two = $integers[0] * $integers[1];
    my $highest_product_of_three = $integers[0] * $integers[1] * $integers[2];
    my $highest = max($integers[0], $integers[1]);
    my $lowest  = min($integers[0], $integers[1]);
    foreach my $i ( 2 .. $#integers ) {
        my $current_val = $integers[$i];
        $highest_product_of_three = max( $highest_product_of_three, $highest_product_of_two*$current_val, $lowest_product_of_two*$current_val );
        $highest_product_of_two = max( $highest_product_of_two, $highest*$current_val, $lowest*$current_val );
        $lowest_product_of_two = min( $lowest_product_of_two, $highest*$current_val, $lowest*$current_val );
        $highest = max($current_val, $highest);
        $lowest = min($current_val, $lowest);
    }
    return $highest_product_of_three;
}

sub max {
    my ($first, $second, $third) = @_;    
    my $highest = $first > $second ? $first : $second;
    $highest = $third > $highest ? $third : $highest if ( $third );
    return $highest;
}

sub min {
    my ($first, $second, $third) = @_;
    my $lowest = $first < $second ? $first : $second;
    $lowest = $third < $lowest ? $third : $lowest if ( $third );
    return $lowest;
}

# sorting O(nlogn)
sub get_highest_product_of_three_sorting {
    my @integers = (2, 5, 4, 3, 6);
    # highest = 5*4*6 = 120 = product of three biggest integers
   
    # sort them from highest to lowest? and then multiply the 3 biggest ints?
    my @sorted = sort{ $b <=> $a } @integers;
    my $highest_product = $sorted[0] * $sorted[1] * $sorted[2];

    return $highest;

}

# brute force - 3 nested loops = O(n^3)

1;
