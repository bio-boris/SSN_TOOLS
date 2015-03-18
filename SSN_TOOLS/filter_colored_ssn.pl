#!/usr/bin/env perl
use strict;
use Getopt::Long;
my $usage = "\tUsage: -full_network<colored xgmml> or -repnode_network<colored xgmml> -output<optional> \n\n outputs a list ";
die $usage unless defined @ARGV;

my $file   ;
my $repnode_file;
my $full_file;
my $output ;
my $f;
GetOptions (
    "repnode_network=s" =>\$repnode_file,
    "full_network=s" => \$full_file,    
    "output:s"   => \$output,
    "f" => \$f)       

    or die("Error in command line arguments\n");

main();

sub main{
    print "main";

    if(defined $repnode_file){
        $file = $repnode_file;
        $output = length($output) > 0 ? $output : "$file-filtered";
        checkOutput($output);

        print STDERR "About to extract node id , color , cluster and seed for repnode $file to $output\n";
        extract_repnode_acc_color_supernode();
        sortOutput($output);
    }
    elsif(defined $full_file){
        $file = $full_file;
        $output = length($output) > 0 ? $output : "$file-filtered";
        checkOutput($output);
        print  STDERR "About to extract node id, color,  for full gnn $file to $output\n";
        extract_full_accession_color_supercluster();
        sortOutput($output);
    }
    else{
        die $usage . " Please enter a full or repnode GNN\n";
    }
}

sub checkOutput{
    my $file = shift;
    if(-s $file && length $file > 0 && not defined $f){
        die "$file already exists. Specify -f option if you would like to overwrite this file\n";
    }
}
sub sortOutput{
    my $file = shift;
    my $col = 3;
    my $sort= "sort -t\$'\t' -n -k $col,$col $file > $file.sorted"; 
    print "\nSee a sorted copy at $file.sorted\n";
    system($sort);
}


sub extract_repnode_acc_color_supernode{
    my $in_node = 0;
    my $in_acc = 0;
    my $supercluster;
    my $supernode;
    my $color;

    open F, "$repnode_file" or die $!;
    open O, ">$output" or die $!;
    while(my $line =<F>){
        if(!$in_node){
            if (substr($line,2,9) eq  '<node id='){
                $in_node = 1;
                $supernode= (split /"/, $line)[1];
            }
            next;
        }
        else{
            if($line =~ /<\/node>/){
                $in_node = 0;
                $in_acc =0;
                $supernode = undef;
                $color = undef;
                next;
            }
            if($line =~ /<att name="node\.fillColor"/){
                $color = (split /"/, $line)[5];
                next;
            }
            if($line =~ /<att name="Supercluster" /){
                $supercluster = (split /"/, $line)[5];
                next;
            }

            my $len ='    </att>';
            if($line =~/<\/att>/){
                $in_node =0;
                $color = undef;
                $supernode = undef;
                $in_acc = 0;
                next;
            }
            if($line =~/<att type="list" name="ACC">/){
                $in_acc = 1;
                next;
            }

        }
        if($in_acc){
            my $id = (split /"/, $line)[5];
            if( length $id ==0){
                next;
            }
            print O join "\t", "$id","$color",$supercluster,"$supernode","\n";
            # print O join "\t", "id=$id","color=$color","super=$supernode","\n";
        }
    }
    close F;
    close O;
}



sub extract_full_accession_color_supercluster{
    my $in_node = 0;
    my $in_acc = 0;
    my $acc;
    my $color;
    my $supercluster;
    open F, $file or die $!;
    open O, ">$output" or die $!;
    while(my $line =<F>){
        chomp $line;
        if($line =~  /node id=".+" label="(.+)">/){
            $acc= $1;
        }
        if($line =~ /<att name="node\.fillColor" type="string" value="(#[A-Z0-9]{6})" /){
            $color = $1;
        }
        if($line =~ /<att name="Supercluster" type="string" value="(.*)" \/>/){
            $supercluster = $1;
            print O "$acc\t$color\t$supercluster\n";
            $acc = $color = $supercluster = ();
            next;
        }
    }
    close F;
}


