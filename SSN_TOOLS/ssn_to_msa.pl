#!/usr/bin/env perl
use strict;
use Getopt::Long;
use File::Path qw(make_path remove_tree);
my $usage = "\tUsage: -full_network<colored ssn> or -repnode_network<colored ssn> -dir<optional> \n\n outputs a list of uniprot ids for MSA ";
die $usage unless defined @ARGV;

my $file   ;
my $repnode_file;
my $full_file;
my $dir ;
my $f;
GetOptions (
    "repnode_network=s" =>\$repnode_file,
    "full_network=s" => \$full_file,    
    "dir:s"   => \$dir,
    "f" => \$f)       
    or die("Error in command line arguments\n");

main();

sub main{
    if(defined $repnode_file){
        $file = $repnode_file;
        $dir = length $dir > 0 ? $dir : "$file-msa";
        check_dir();    
        repnode_accessions();    
    }
    elsif(defined $full_file){
        $file = $full_file;
        $dir = length $dir > 0 ? $dir : "$file-msa";
        check_dir();    
        full_network_accessions();    
    }
    else{
        die $usage . " Please enter a full or repnode SSN\n";
    }
    print "Printed to $dir";
}

sub check_dir{
    if(-s $dir && not defined $f){
        die "$dir already exists. Specify -f switch to force overwrite";
    } 
    else{
        remove_tree($dir);
        mkdir($dir);
    }
}

sub full_network_accessions{
    print STDERR "About to extract accessions to $dir for 'FULL' network \n";
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
                $cluster = "undefined";
            }
            push @{$hash{$cluster}}, $id;
            $id = $cluster = ();
        }
    }
    close F;
    foreach my $cluster(keys %hash){
        open O, ">$dir/$cluster" or die $!;
        my @accessions = @{$hash{$cluster}};
        foreach my $acc(@accessions){
            if(length $acc > 0){
                print O "$acc\n";
            }
        }
        close O;
    }
}

sub repnode_accessions{
    print STDERR "About to extract accessions to $dir for 'REPNODE' network \n";
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
                    $cluster = "undefined";
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
    close F;

    foreach my $cluster(keys %hash){
        my $output = "$dir/$cluster";
        open O, ">$output" or die $!;
        my @cluster_members = @{$hash{$cluster}};
        foreach my $cluster_member(@cluster_members){
            if (length($cluster_member) > 0){
                print O "$cluster_member\n";
            }
        }
        close O;
    }


}

