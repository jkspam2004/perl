#!/usr/bin/perl -w
#
# find the max profit from stock sale. buy before sell
#

use strict;
use Data::Dumper;
$Data::Dumper::Sortkeys = 1;

#&get_stock_price;
&get_stock_price_brute;

# greedy approach O(n)
# get max profit of stock prices. buy must be before a sell
sub get_stock_price {
    my @price =  qw( 400 500 300 200 800 100 700 300 );

    my $min_price = $price[0];
    my $max_profit = 0;
    for my $time ( 0 .. $#price ) {
        my $current_price = $price[$time];
        my $gain = $current_price - $min_price;
   
        #$min_price = $current_price < $min_price ? $current_price : $min_price; 
        #$max_profit = $gain > $max_profit ? $gain : $max_profit;
        if ( $current_price < $min_price ) {
            $min_price = $current_price;
        }
        if ( $gain >= $max_profit ) {
            $max_profit = $gain;
            print "got max at $time of $max_profit\n";
        } 


        print "at $time current=$current_price, min_price=$min_price, gain=$gain, max_profit=$max_profit\n";
    }

    print "max_profit=$max_profit\n";
    return;

}

# brute force O(n^2)
# Note: sorting and searching algorithms where we're recursively cutting the set in half is O(nlg(n)) - 
# not the solution for this problem
sub get_stock_price_brute {
    #                      0   1   2   3   4   5   6   7   8   9   10
    my @stock_price = qw( 500 410 834 200 350 450 500 225 342 624 555  );

    my %profit = ();
    for my $i ( 0 .. $#stock_price ) {
        for my $j ( $i+1 .. $#stock_price ) {
            $profit{$i.'_'.$j} = $stock_price[$j] - $stock_price[$i];
        }
    }

    my $index = 0;
    foreach my $price ( @stock_price ) {
        print "$index => $price\n";
        $index++;
    }

    print Dumper(\%profit);

=pod
    my $most = 0;
    my %keep = ();
    foreach my $time ( keys %profit ) {
        if ( $profit{$time} >= $most ) {
            $most = $profit{$time};
            #%keep = ();
            $keep{$time} = $most;
        }
    }
=cut

    my %new = ();
    foreach my $key ( keys %profit ) {
        push(@{$new{$profit{$key}}}, $key);
    }

    #print Dumper(\%new);
    my @sorted = sort{ $b <=> $a } keys %new;
    print "most profit is $sorted[0] at buy_sell times: @{$new{$sorted[0]}}\n";

=pod
    my @new = values %profit;
    my @sorted = sort{ $b <=> $a } @new;
    print "most profit is $sorted[0]\n";
=cut

    return;
}

1;
