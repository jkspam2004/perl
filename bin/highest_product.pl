#!/usr/bin/perl -w

use strict;
use Data::Dumper;
$Data::Dumper::Sortkeys = 1;

&highest_product_with_three_ints;
#&highest_product_with_three_ints_sorting;


sub highest_product_with_three_ints {
    my @integers = (-10, -10, 1, 3, 2);
    #highest = -10 * -10 * 3 = 300

    my $highest = 1;
    foreach my $i ( 0 .. $#integers ) {
        my $product = $integers[$i-1] * $integers[$i] * $integers[$i+1];
        if ( $product >= $highest ) {
            $highest = $product;
        }
        
    }

    print "$highest\n";

}

# sorting O(nlogn)
sub highest_product_with_three_ints_sorting {
    my @integers = (2, 5, 4, 3, 6);
    # highest = 5*4*6 = 120 = product of three biggest integers
   
    # sort them from highest to lowest? and then multiply the 3 biggest ints?
    my @sorted = sort{ $b <=> $a } @integers;
    my $highest_product = $sorted[0] * $sorted[1] * $sorted[2];
    print "highest product=$highest_product\n";



}

# brute force - 3 nested loops = O(n^3)

1;
