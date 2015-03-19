## Convert Stats Tab File 

These scripts transform the outputs from the GNT tool (Colored Sequence Similarity Network (SSN))
Specifically, it works with the Stats File, which is
Tabular output of (1) Cluster Number, (2) Neighbor Pfam ID, (3) Neighbor Pfam Name, (4) Cluster Fraction, and (5) Average Gene Distance


`module load perl; perl ~/EFI_TOOLS/GNN/convert_stats_tab.pl -i <input stats.tab from GNT> -o <output> `



## To create a directory for for a GNN that contains a tab file for each PFAM.
* Each tab file is titled PF#####.tab. 
* The contents of each tab file is Accession, SuperClusterID, Color, Distance

`module load perl;`

`perl ~/EFI_TOOLS/GNN_TOOLS/gnn_filter.pl -gnn<gnn file> -dir<output_dir> `

*tested with 2056_gnn.xgmml and briefly with repnode.2149_gnn.xgmml*
