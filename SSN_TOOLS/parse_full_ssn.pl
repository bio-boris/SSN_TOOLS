#!/usr/bin/env perl
#Script to extract sequence ids for multiple sequence alignment from full SSNS that have been colored
use strict;
my $usage = "\t--$0 <SSN_1.xgmml> <SSN_2.xgmml> ... <SSN_N.xgmml>";
die $usage unless defined @ARGV;


my @files = @ARGV;


foreach my $file(@files){
    open F, $file or die $!;
    my %hash;
    my $id;
    my $cluster;
    while(my $line = <F>){
        if($line =~ /<node id="(.+)" /){
            $id = $1;
        }
        elsif($line =~/<att name="Supercluster" type="string" value="([0-9]*)" /){
            $cluster = $1;
            if(length $cluster ==0){
                #print "Found no cluster for $id\n";
                $cluster = "undefined";
            }
            else{
                #       print "Found cluster $cluster\n";
            }
            push @{$hash{$cluster}}, $id;
            $id = $cluster = ();
        }
    }
    close F;
    mkdir("$file-msa");
    foreach my $cluster(keys %hash){
        my $output = "$file-msa/$cluster";
#        print "About to print to $output\n";
        open O, ">$output" or die $!;

        #       print "opened filehandle >$output\n";
        my @accessions = @{$hash{$cluster}};
        foreach my $acc(@accessions){
            if(length $acc > 0){
                print O "$acc\n";
            }
        }
        #print O join "\n", @{$hash{$cluster}}; 
        close O;
    }
}
foreach my $file(@files){
    print "Printed to $file-msa\n";
}
