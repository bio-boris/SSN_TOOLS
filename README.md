# SSN Tools

A collection of scripts to extract lists from existing XGMML Files.

* To see how a script is used, run it without any inputs. It will display what the script requires.

* You do not need to be in the same directory as the script or the input file or the output file.

* See install file for instructions on how to install the scripts.

# GNN

## To create a directory for multiple sequence alignments based on a GNN:

`module load perl;`

`perl ~/EFI_TOOLS/GNN_TOOLS/gnn_filter.pl -gnn<gnn file> -dir<output_dir> `

*tested with 2056_gnn.xgmml and briefly with repnode.2149_gnn.xgmml*

# SNN

## To extract [accession id] and [color] for colored SSNs for a full network:

`module load perl;`

`perl ~/EFI_TOOLS/SSN_TOOLS/filter_colored_ssn.pl -full_network <colored ssn> -output<output_file> `

*tested with 1970_color.xgmml and PF05544.repnode-1.00.1978_color.xgmml*

## To extract [accession id], [color] and [supernode] for colored SSNs for a full network:

`module load perl;`

`perl ~/EFI_TOOLS/SSN_TOOLS/filter_colored_ssn.pl -repnode_network <colored ssn> -output<output_file> `

*tested with 1975_color.xgmml and PF05544.full.1975_color.xgmml*

##To extract uniprot sequence ids into a directory

####FULL NETWORKS
`module load perl;`
`perl ~/EFI_TOOLS/SSN_TOOLS/parse_full_ssn.pl <input colored  network>`

####REP NODE NETWORKS
`module load perl;`
`perl ~/EFI_TOOLS/SSN_TOOLS/parse_repnode_ssn.pl <input colored network repnode>`


