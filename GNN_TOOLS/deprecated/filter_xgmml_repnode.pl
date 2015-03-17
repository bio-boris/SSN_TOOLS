#!/usr/bin/env perl
use strict;

#Extracts  Node ID, Color, and Supernode, and prints
my $usage = "\t -- $0 < repnode network> <output to STDOUT>";
die $usage unless defined @ARGV;

my $in_node = 0;
my $in_acc = 0;
my $supernode;
my $color;
while(my $line =<>){
    if(!$in_node){
        if ($line =~  '<node id='){
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
        if($line =~/<\/att>/){
            $in_node =0;
            $color = undef;
            $supernode = undef;
            $in_acc = 0;
            next;
        }
             # print "in node $supernode\n";
        if($line=~ '<att name="node.fillColor"'){
                $color = (split /"/, $line)[5];
                next;
        }
        if($line =~ '<att type="list" name="ACC">'){
            $in_acc = 1;
            next;
        }
        if($in_acc){
            my $id = (split /"/, $line)[5];
            if( length $id ==0){
                next;
            }
            print join "\t", $id,$color,$supernode,"\n";
        }

    }


}

