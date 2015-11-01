#!/usr/bin/perl -w
#
# find the product of all integers except at the index

use strict;
use Data::Dumper;
$Data::Dumper::Sortkeys = 1;

&get_products_of_all_ints_except_at_index_best;
#&get_products_of_all_ints_except_at_index;
#&get_products_of_all_ints_except_at_index_brute;

# only need one array to store the final product
# O(n) for time and O(n) for space
sub get_products_of_all_ints_except_at_index_best {
    my @integers = (1, 2, 3, 4, 5);

    my %final_product = ();
    my $product = 1;
    my $i = 0;
    while ( $i <= $#integers ) {
        $final_product{$i} = $product; 
        $product *= $integers[$i];
        $i++;
    }

    $product = 1;
    $i = $#integers;
    while ( $i >= 0 ) {
        $final_product{$i} = $final_product{$i} * $product; 
        $product *= $integers[$i];
        $i--;
    }

    print "product_of_ints_except_at_index=".  Dumper(\%final_product);
}

# greedy approach just O(n) for time
# but too many arrays - three O(n) memory cost. 1 array for product before index, 1 array for product after index, 1 for finall product
sub get_products_of_all_ints_except_at_index {
    my @integers = (1, 2, 3, 4, 5);
    #            0   1   2   3   4        0        1        2        3        4
    # result = [120, 60, 40, 30, 24] : [2*3*4*5, 1*3*4*5, 1*2*4*5, 1*2*3*5, 1*2*3*4]
    #my @integers = (1, 2, 0, 4, 5);
    #[0, 0, 40, 0, 0]

    print "integers= @integers\n";

    my $prod = 1;
    # get the product of all integers before each index
    #            0  1   2    3        4
    # before = [ 1, 1, 1*2, 1*2*3, 1*2*3*4]
    my %before = ();
    for my $i ( 0 .. $#integers ) {
        $before{$i} = $prod;
        $prod *= $integers[$i];
    }
    print "product_of_ints_before=" . Dumper(\%before);

    # get the product of all integers after each index
    #             0       1     2   3  4
    # after = [2*3*4*5, 3*4*5, 4*5, 5, 1]
    $prod = 1;
    my %after = ();
    for my $i ( reverse(0 .. $#integers) ) {
        $after{$i} = $prod;
        $prod *= $integers[$i];
    }
    print "product_of_ints_after=" . Dumper(\%after);

    my %product = ();
    for my $i ( 0 .. $#integers ) {
        $product{$i} = $before{$i} * $after{$i};
    }
    print "product_of_ints_except_at_index=".  Dumper(\%product);

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
