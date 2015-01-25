#!/usr/bin/perl -w

use strict;
use Data::Dumper;
$Data::Dumper::Sortkeys = 1;

&get_products_of_all_ints_except_at_index;
#&get_products_of_all_ints_except_at_index_brute;

# greedy approach 3*O(n) or just O(n)
sub get_products_of_all_ints_except_at_index {
    my @integers = (1, 2, 3, 4, 5);
    #            0   1   2   3   4        0        1        2        3        4
    # result = [120, 60, 40, 30, 24] : [2*3*4*5, 1*3*4*5, 1*2*4*5, 1*2*3*5, 1*2*3*4]
    #my @integers = (1, 2, 0, 4, 5);
    #[0, 0, 40, 0, 0]

    my $prod = 1;
    # get the product of all integers before each index
    #            0  1   2    3        4
    # before = [ 1, 1, 1*2, 1*2*3, 1*2*3*4]
    my %before = ();
    for my $i ( 0 .. $#integers ) {
        $before{$i} = $prod;
        $prod *= $integers[$i];
    }
    print Dumper(\%before);

    # get the product of all integers after each index
    #             0       1     2   3  4
    # after = [2*3*4*5, 3*4*5, 4*5, 5, 1]
    $prod = 1;
    my %after = ();
    for my $i ( reverse(0 .. $#integers) ) {
        $after{$i} = $prod;
        $prod *= $integers[$i];
    }
    print Dumper(\%after);

    my %product = ();
    for my $i ( 0 .. $#integers ) {
        $product{$i} = $before{$i} * $after{$i};
    }
    print Dumper(\%product);

    return;
}

# brute force O(n^2)
# array of the products of all integers except the integer at each index
sub get_products_of_all_ints_except_at_index_brute {
    my @integers = ( 1, 7, 3, 4 );

    my %product = ();
    for my $i ( 0 .. $#integers ) {
        $product{$i} = 1;
        for my $j ( 0 .. $#integers ) {
            next if ( $i == $j ); 
            print "i=$i, j=$j\n";
            $product{$i} = $product{$i} * $integers[$j];
        }
    }

    print Dumper(\%product);

    return;
}

1;
