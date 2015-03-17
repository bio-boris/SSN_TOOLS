# SSN Tools

A collection of scripts to extract lists from existing XGMML Files.

* To see how a script is used, run it without any inputs.

* Otherwise, assuming that the scripts are extracted into your home directory, the standard usage is

`module load perl; perl ~/SSN_TOOLS/script_name.pl <input_xgmml_full_or_rep> <OUTPUT> `

* OUTPUT may be to STDOUT or to a directory containing a list of files.
You do not need to be in the same directory as the script or the input file or the output file.

* See INSTALL file for how to download the scripts.

## To create a directory for multiple sequence alignments based on a GNN:

`module load perl;`
`perl ~/EFI_TOOLS/GNN_TOOLS/gnn_filter.pl -gnn<gnn file> -dir<output_dir> <input gnn network>`

## To extract node id, color and accessions and print to STDOUT for colored SSNs

#####FULL NETWORKS
`module load perl;`
`perl ~/EFI_TOOLS/GNN_TOOLS/gfilter_full_xgmml.pl <input colored ssn full network>`

#####REP NODE NETWORKS
`module load perl;`
`perl ~/EFI_TOOLS/GNN_TOOLS/filter_xgmml_repnode.pl <input colored ssn network repnode>`

##To extract uniprot sequence ids into a directory

####FULL NETWORKS
`module load perl;`
`perl ~/EFI_TOOLS/SSN_TOOLS/parse_full_ssn.pl <input colored  network>`

####REP NODE NETWORKS
`module load perl;`
`perl ~/EFI_TOOLS/SSN_TOOLS/parse_repnode_ssn.pl <input colored network repnode>`


