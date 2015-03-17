#!/usr/bin/env perl
use strict;
#Extracts  Node ID, Color, and Accs, and prints
my $comment = "\n Extracts node id, color and accession for a given GNN \n
which contains 1 PFAM that was extracted form a GNN of many pfams in CYTOSCAPE \n
and the IDs have been changed by cytoscape \n
This script requires the file and the exact name of the PFAM \n";
my $usage = "\t--$0 <single_pfam_gnn> <exact name_of_pfam> \n $comment";

die $usage unless scalar @ARGV > 2;


my $file = shift @ARGV;
my $name = shift @ARGV;;
my $name = "Radical_SAM";

my $in_node = 0;
my $in_acc = 0;
my $supernode;
my $color;
my $cluster;

my %cluster_colors;
my %cluster_members;;

open F, $file or die $!;


my $in_cluster=0;
while (my $line =<F>){

    #Not yet in cluster
    if(! $in_cluster){
        next until($line  =~ /<node id="[0-9]+" label="([0-9]+)">/);
        $cluster = $1;
        $in_cluster = 1;
        next;
    }
    #In Cluster!
    if($line =~ /<att name="node\.fillColor" value="#([A-Z0-9]{6})" type="string"/){
        $color = $1;
    }
    if($line =~/<att name="Distance" type="list">/){
        getDistance();
        $in_cluster = 0;
    }

}


sub getDistance{ 

    while(my $line=<F>){
        if($line =~/<\/att>/){
            return;
        }
        else{
            my @line = split /"/, $line;
            my @acc_acc_dist = split /:/, $line[3]; 
            print join "\t", ($acc_acc_dist[1],$cluster,$color,$acc_acc_dist[2],"\n");
        }

    }
}



