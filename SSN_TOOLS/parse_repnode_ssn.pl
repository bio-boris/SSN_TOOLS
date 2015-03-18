#!/usr/bin/env perl
#use List::MoreUtils qw(uniq);
#Script to extract sequence ids for multiple sequence alignment from full SSNS that have been colored

use strict;
my @files = @ARGV;
my $usage = "\t--$0 <SSN_1.xgmml> <SSN_2.xgmml> ... <SSN_N.xgmml>";
die $usage unless defined @ARGV;


foreach my $file(@files){
    open F, $file or die $!;
    my %hash;
    my $id;
    my $cluster;
    my %hash;
    my $in_list = 0;
    my @list_ids = ();
    while(my $line = <F>){
        chomp $line;
        if(! $in_list){
            if($line =~/<att name="Supercluster" type="string" value="([0-9]*)" /){
                $cluster = $1;
                if(length $cluster ==0){
                    print "Found no cluster for $id $list_ids[0]\n";
                    $cluster = "undefined";
                }
                else{
                    print "Found cluster $cluster\n";
                }
            }
            if($line =~ /<att type="list" name="ACC">/){
                $in_list = 1;
            }
        }
        if($in_list){
            if($line =~ /<\/att>/){
                push @{$hash{$cluster}}, @list_ids;
                $cluster = $in_list = 0;
                @list_ids = (); 
            }
            else{
                $line =~ / <att type="string" name="ACC" value="(.+)" /;
                push @list_ids, $1;
            }
        }
    }
    mkdir("$file-msa");
    close F;

    foreach my $cluster(keys %hash){
        my $output = "$file-msa/$cluster";
        print "About to print to $output\n";
        open O, ">$output" or die $!;
        print "opened filehandle >$output\n";
        my @cluster_members = @{$hash{$cluster}};
        foreach my $cluster_member(@cluster_members){
            if (length($cluster_member) > 0){
                print O "$cluster_member\n";
            }
        }
        close O;
    }
}
