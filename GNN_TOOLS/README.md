## Get lists of accessions for Multiple Sequence Alignments


## Convert Stats Tab File 

These scripts transform the outputs from the GNT tool (Colored Sequence Similarity Network (SSN))
Specifically, it works with the Stats File, which is
Tabular output of (1) Cluster Number, (2) Neighbor Pfam ID, (3) Neighbor Pfam Name, (4) Cluster Fraction, and (5) Average Gene Distance


` ~/EFI_TOOLS/GNN/convert_stats_tab.pl -i <input stats.tab from GNT> -o <output> `


**To create a directory for multiple sequence alignments based on a GNN:

`module load perl;`

`perl ~/EFI_TOOLS/GNN_TOOLS/gnn_filter.pl -gnn<gnn file> -dir<output_dir>`

`tested with 2056_gnn.xgmml and briefly with repnode.2149_gnn.xgmml`

Deprecated:

` awk ' { print $1 "\t" $2 ":" $3 ":" $4 ":" $5  } ' <GNT_STATS.TAB> `
