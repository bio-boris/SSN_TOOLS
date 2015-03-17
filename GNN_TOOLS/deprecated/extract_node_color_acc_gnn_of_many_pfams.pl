#!/usr/bin/env perl
use strict;
use File::Path qw(make_path remove_tree);
#Extracts  Node ID, Color, and Accs, and prints
my $comment = "\n Extracts node id, color and accession for a given GNN \n
which contains many PFAMs \n
This script requires the GNN xgmml and outputs a directory with lists for each pfam.\n
This output directory is the same name as the input file, but with an _dir appended to it    \n";



my $usage = "\t\t $0 <input single_pfam_gnn_GNN.xgmml>  (prints a directory     with lists for each pfam) \n $comment";
die $usage unless scalar @ARGV > 0;
my $file = shift @ARGV;

open F, $file or die $!;

my $family;
my $color;
my $cluster;
my $in_node;
my @neighbor_accessions;
my @distances;
my $count = 0;


my $dir = "$file\_dir";
remove_tree($dir);
mkdir($dir);

while(my $line = <F>){
    if(!$in_node){
        if($line =~ /<node id="(.{6,9});[0-9]+" label=".+">/){
            $in_node = 1;
            $family=$1;
        }
    }
    else{
        if($line =~ / <att name="Cluster Number" type="integer" value="([0-9]+)" \/>/){
            $cluster = $1;
        }
        if($line =~ /<att name="node\.fillColor" type="string" value="(#.{6})" \/>/){
            $color = $1;
        }
        if($line =~ /<att type="string" name="Neighbor_Accessions" value="(.+)" \/>/){
            my $value = $1;
            push @neighbor_accessions, (split /:/, $value)[0];
        }
        if($line =~ /<att type="string" name="Distance" value="(.+)" \/>/){
            my $value = $1;
            push @distances, (split /:/, $value)[2];
        }
        if($line =~/<\/node>/){
            $in_node = 0;
            my $family_file = "$dir/$family.tab";

            open O, ">>$family_file" or die $!;
            for(my $i =0 ; $i < scalar @neighbor_accessions; $i++){
                print O join "\t", $neighbor_accessions[$i],$cluster,$color,$distances[$i],"\n";
            }
            print "Printed family $family to $family_file ($count)\n";
            close O;
            $family = $color = $cluster = @neighbor_accessions = @distances = ();
            $count++;
            if($count ==1){
            }
        }
    }


}


