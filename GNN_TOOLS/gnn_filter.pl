#!/usr/bin/env perl
use strict;
use Getopt::Long;
use File::Path qw(make_path remove_tree);
#Extracts  Node ID, Color, and Accs, and prints
#  print $query,$neighbor,$distance,$cluster,$color,"\n";
my $comment = "Extracts query, neigbor, distance, cluster and color for a given GNN. Creates lists titled by pfam\n";

my $usage = "\t\t $0 -gnn<gnn file> -dir<output_dir>  \n $comment";
my $file;
my $dir;
my $f;

GetOptions (
    "gnn=s" =>\$file,
    "dir:s" => \$dir,
    "f" => \$f
)    
    or die("Error in command line arguments\n");

die $usage  unless (defined $file || defined $dir);
if(! defined $file){
    die "Input a -gnn\n";
}
elsif (!defined $dir){
    $dir = "$file-mapping ";
}


open F, $file or die $!;

my $family;
my $color;
my $cluster;
my $in_node;

my %query_neighbor_distance;
my @neighbor_accessions;
my @distances;
my @query_accessions;
my $count = 0;

if(defined $f){
    remove_tree($dir);
}
elsif(-s $dir){
    die "Cannot run script, $dir already exists. add a ' -f ' to the command to force overwrite";
}
mkdir($dir);

while(my $line = <F>){
    chomp $line;
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
        # if($line =~ /<att type="string" name="Neighbor_Accessions" value="(.+)" \/>/){
        #    my $value = $1;
        #    push @neighbor_accessions, (split /:/, $value)[0];
        #}
        if($line =~ /<att type="string" name="Distance" value="(.+)" \/>/){
            my $value = $1;
            my ($query,$neighbor,$distance) = split /:/, $value;
            $query_neighbor_distance{$query}{'neighbor'} = $neighbor;
            $query_neighbor_distance{$query}{'distance'} = abs($distance);
            #print "Found distance $line\n";
            #print "$family,$color,$cluster,$query,$neighbor,$distance \n";
        }
        if($line =~/<\/node>/){
            $in_node = 0;
            my $family_file = "$dir/$family.tab";

            open O, ">>$family_file" or die $!;
            #for(my $i =0 ; $i < scalar @neighbor_accessions; $i++){
            foreach my $query(sort keys %query_neighbor_distance){
                my $neighbor = $query_neighbor_distance{$query}{'neighbor'};
                my $distance = $query_neighbor_distance{$query}{'distance'};
                print O join "\t", $query,$neighbor,$distance,$cluster,$color,"\n";
                #print $query,$neighbor,$distance,$cluster,$color,"\n";        
            }
            #    print O join "\t", $neighbor_accessions[$i],$cluster,$color,$distances[$i],"\n";
            #}
            print "Printed family $family to $family_file ($count)\n";
            close O;
            $family = $color = $cluster = @neighbor_accessions = @distances = ();
            %query_neighbor_distance = ();
            $count++;
            if($count ==1){
            }
        }
    }


}


