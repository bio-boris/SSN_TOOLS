#~~extract_node_color_acc_from_gnn.pl~~
* ~~This was the first attempt at extracting from a GNN, we decided not to use this and extract entire lists instead~~
* ~~deprecated~~
* created this file using PF04055.xgmml

#extract_node_color_acc_gnn_of_many_pfams.pl
* Description: Extracts lists of uniprot
* INPUT: [inputFileName] [a colored GNN network ]
* OUTPUT: [a directory called inputFileName followed by _MSA]
* created this script using 2056_gnn.xgmml 

#filter_full_xgmml.pl
* Description: Extracts Node ID, Color, and Accessions, and prints to STDOUT
* INPUT: [inputFileName] [ a colored FULL Network xgmml]
* OUTPUT: STDOUT
* created this script using PF05544.repnode-1.00.1978_color.xgmml


#filter_xgmml_repnode.pl
* Description: Extracts Node ID, Color, and Accessions, and prints to STDOUT
* INPUT: [inputFileName] [ a colored REPNODE Network xgmml]
* OUTPUT: STDOUT
* created this script using PF05544.full-1.00.1978_color.xgmml
