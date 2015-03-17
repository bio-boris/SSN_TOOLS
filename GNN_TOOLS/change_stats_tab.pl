#!/usr/bin/env perl
#Script to sort tab output from GNT tool for import into CYTOSCAPE
use strict;
use Getopt::Long;
my $usage = "\t--usage -i<input_stats_file from GNT Website> -o <outputfile>";

my $in;
my $out;

GetOptions (
    "in=s" =>\$in,
    "out=s" => \$out,
)
    or die("Error in command line arguments\n");
die $usage unless (defined $in && defined $out);

my %hash;
open F, $in or die $!;
while(my $line =<F>){
    chomp $line;
    my @line = split /\t/, $line;
    push @{$hash{$line[0]}}, (join ":", @line[1,2,3,4]);
}
close F;

open O, ">$out" or die $!;
foreach my $key (sort keys %hash){
    print O "$key\t" , (join ",", @{$hash{$key}}) , "\n";
}
close O;

print "\nPrinted to $out\n";
