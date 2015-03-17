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
