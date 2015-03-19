#GNN

## Convert Stats Tab File 

These scripts transform the outputs from the GNT tool (Colored Sequence Similarity Network (SSN))
Specifically, it works with the Stats File, which is
Tabular output of (1) Cluster Number, (2) Neighbor Pfam ID, (3) Neighbor Pfam Name, (4) Cluster Fraction, and (5) Average Gene Distance


`module load perl; perl ~/EFI_TOOLS/GNN/convert_stats_tab.pl -i <input stats.tab from GNT> -o <output> `

## To create a directory for for a GNN that contains a tab file for each PFAM.
Example Usage:

`~/EFI_TOOLS/GNN_TOOLS/gnn_filter.pl -gnn ~/PF05544.SSN-GNN.full/full.2148_gnn.xgmml`

`~/EFI_TOOLS/GNN_TOOLS/gnn_filter.pl -gnn ~/PF05544.SSN-GNN.repnode/repnode.2149_gnn.xgmml`

* Script name: **gnn_filter.pl**
* Usage: `-gnn<gnn file> -dir<optional> `
* Output: A directory,   which by default is called 'ssn_filename-mapping'. with tab files titled by PFAM.
* Fields: Query, Neighbor, Distance, Cluster# , Color

