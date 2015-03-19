# SSN Tools

A collection of scripts to extract lists from existing XGMML Files.

* To see how a script is used, run it without any inputs. It will display what the script requires.

* You do not need to be in the same directory as the script or the input file or the output file.

* See install file for instructions on how to install the scripts.

# GNN

## To create a directory for for a GNN that contains a tab file for each PFAM.
* Each tab file is titled PF#####.tab. 
* The contents of each tab file is Accession, SuperClusterID, Color, Distance

`module load perl;`

`perl ~/EFI_TOOLS/GNN_TOOLS/gnn_filter.pl -gnn<gnn file> -dir<output_dir> `

*tested with 2056_gnn.xgmml and briefly with repnode.2149_gnn.xgmml*

# SNN

## Create a list of uniprot accession ids for MSA , by cluster for a given colored SSN
Example Usage:  

`~/EFI_TOOLS/SSN_TOOLS/ssn_to_msa.pl -repnode_network ~/PF05544.SSN-GNN.repnode/repnode.2149_color.xgmml`
`~/EFI_TOOLS/SSN_TOOLS/ssn_to_msa.pl -full_network ~/PF05544.SSN-GNN.full/full.2148_color.xgmml`

*  Script Name: **ssn_to_msa.pl**
*  Usage: `-full_network<colored ssn> or -repnode_network<colored ssn> -dir<optional>`
*  Output: A directory , which by default is called 'ssn_filename-msa'.
*  Creates a file for each cluster, each containing a list of uniprot accession ids.
  
## Create a list of ids, colors and cluster#s for MSA, for a given colored SSN
Example Usage:

`~/EFI_TOOLS/SSN_TOOLS/filter_colored_ssn.pl -repnode_network ~/PF05544.SSN-GNN.repnode/repnode.2149_color.xgmml `

`~/EFI_TOOLS/SSN_TOOLS/filter_colored_ssn.pl -full_network ~/PF05544.SSN-GNN.full/full.2148_color.xgmml `

* Script Name: **filter_colored_ssn.pl**
* Usage: `-full_network<colored xgmml> or -repnode_network<colored xgmml> -output<optional>`
* Output: A file, which by default is called 'ssn_filename-filtered' which contains the following fields
 *  Repnode Network Fields: ID, Color, Cluster#, Seed Sequence
 *  Full Network Fields: ID, Color, Cluster#

## GNN

Example Usage:

`~/EFI_TOOLS/GNN_TOOLS/gnn_filter.pl -gnn ~/PF05544.SSN-GNN.full/full.2148_gnn.xgmml`

`~/EFI_TOOLS/GNN_TOOLS/gnn_filter.pl -gnn ~/PF05544.SSN-GNN.repnode/repnode.2149_gnn.xgmml`

* Script name: **gnn_filter.pl**
* Usage: `-gnn<gnn file> -dir<optional> `
* Output: A directory,   which by default is called 'ssn_filename-mapping'. with tab files titled by PFAM.
* Fields: Query, Neighbor, Distance, Cluster# , Color




