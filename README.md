# SSN Tools

A collection of scripts to extract lists from existing XGMML Files.

* To see how a script is used, run it without any inputs. It will display what the script requires.

* You do not need to be in the same directory as the script or the input file or the output file.

* See install file for instructions on how to install the scripts.

## To create a directory for multiple sequence alignments based on a GNN:

`module load perl;`

`perl ~/EFI_TOOLS/GNN_TOOLS/gnn_filter.pl -gnn<gnn file> -dir<output_dir> `

## To extract [accession id] and [color] for colored SSNs for a full network:

`module load perl;`

`perl ~/EFI_TOOLS/SSN_TOOLS/filter_colored_ssn.pl -full_network <colored ssn> -output<output_file> `


## To extract [accession id], [color] and [supernode] for colored SSNs for a full network:

`module load perl;`

`perl ~/EFI_TOOLS/SSN_TOOLS/filter_colored_ssn.pl -repnode_network <colored ssn> -output<output_file> `

##To extract uniprot sequence ids into a directory

####FULL NETWORKS
`module load perl;`
`perl ~/EFI_TOOLS/SSN_TOOLS/parse_full_ssn.pl <input colored  network>`

####REP NODE NETWORKS
`module load perl;`
`perl ~/EFI_TOOLS/SSN_TOOLS/parse_repnode_ssn.pl <input colored network repnode>`


