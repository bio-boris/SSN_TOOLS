#!/usr/bin/env perl
use strict;
use Getopt::Long;
my $usage = "\tUsage: -full_network<colored xgmml> or -repnode_network<colored xgmml> -output<Default STDOUT> ";
die $usage unless defined @ARGV;

my $file   ;
my $repnode_file;
my $full_file;
my $output ;
GetOptions (
    "repnode_network=s" =>\$repnode_file,
    "full_network=s" => \$full_file,    
    "output=s"   => \$output)       
    or die("Error in command line arguments\n");

main();

sub main{
    print "main";

    if(!defined $output){
        die "Need an output file\n";
    }
    if(defined $repnode_file){
        $file = $repnode_file;
        print STDERR "About to extract node id , color and supernode for repnode $file to $output\n";
        extract_repnode_acc_color_supernode();
    }
    elsif(defined $full_file){
        $file = $full_file;
        print  STDERR "About to extract node id and color for full gnn $file to $output\n";
        extract_full_accession_color();
    }
    else{
        die $usage . " Please enter a full or repnode GNN\n";
    }


}

sub extract_repnode_acc_color_supernode{
    my $in_node = 0;
    my $in_acc = 0;
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
            my $len = length "  </node>";
            if(substr($line,0,$len) eq '  </node>'){
                $in_node = 0;
                $in_acc =0;
                $supernode = undef;
                $color = undef;
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
            my $len = length('    <att name="node.fillColor"');
            if(substr($line,0,$len) eq '    <att name="node.fillColor"'){
                $color = (split /"/, $line)[5];
                next;
            }
            my $len = length('    <att type="list" name="ACC">');
            if(substr($line,0,$len) eq '    <att type="list" name="ACC">'){
                $in_acc = 1;
                next;
            }

        }
        if($in_acc){
            my $id = (split /"/, $line)[5];
            if( length $id ==0){
                next;
            }
            print O join "\t", "$id","$color","$supernode","\n";
            # print O join "\t", "id=$id","color=$color","super=$supernode","\n";
        }
    }
    close F;
    close O;
}



sub extract_full_accession_color{
    my $in_node = 0;
    my $in_acc = 0;
    my $supernode;
    my $color;
    open F, $file or die $!;
    open O, ">$output" or die $!;
    while(my $line =<F>){
        if($line =~  '<node id='){
            $supernode= (split /"/, $line)[1];
        }
        if($line =~ '<att name="node.fillColor"'){
            $color = (split /"/, $line)[5];
            print O "$supernode\t$color\n";
            next;
        }
    }
    close F;
}


