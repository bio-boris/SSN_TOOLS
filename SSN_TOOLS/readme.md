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
