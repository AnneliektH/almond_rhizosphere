# megahit doesnt want to create the temp folder
# this version is currently working
# megahit 
rule PE_assembly:
    input: 
        forward_read = "reads/rmhost/{sample}_L002_R1_rmhost.fq.gz", 
        reverse_read = "reads/rmhost/{sample}_L002_R2_rmhost.fq.gz",
        unpaired_1 = "reads/rmhost/{sample}_L003_R1_rmhost.fq.gz",
        unpaired_2 = "reads/rmhost/{sample}_L003_R2_rmhost.fq.gz",
        unpaired_3 = "reads/rmhost/{sample}_L004_R1_rmhost.fq.gz",
        unpaired_4 = "reads/rmhost/{sample}_L004_R2_rmhost.fq.gz",
        unpaired_5 = "reads/rmhost/unpaired/{sample}_L002_unpaired.fq.gz",
        unpaired_6 = "reads/rmhost/unpaired/{sample}_L003_unpaired.fq.gz",
        unpaired_7 = "reads/rmhost/unpaired/{sample}_L004_unpaired.fq.gz", 
        unpaired_8 = "reads/rmhost/{sample}_L005_R1_rmhost.fq.gz",
        unpaired_9 = "reads/rmhost/{sample}_L005_R2_rmhost.fq.gz",
        unpaired_10 = "reads/rmhost/unpaired/{sample}_L005_unpaired.fq.gz"
    output:
        check = "assemblies/out/{sample}_assem_done.txt",
        out_contig = "assemblies/megahit_final/{sample}.contigs.fa" 
    params:
        output_folder = "assemblies/megahit_final",
        output_temp = "assemblies/megahit_temp"
    message: "paired end assembly on {input.forward_read}"
    shell:'''
    mkdir -p  assemblies/megahit_temp/
    module load megahit
    
    # megahit does not allow force overwrite, so each assembly needs to take place in it's own directory. 
    megahit -1 {input.forward_read} -2 {input.reverse_read} \
    -r {input.unpaired_1},{input.unpaired_2},{input.unpaired_3},{input.unpaired_4},{input.unpaired_5},{input.unpaired_6},{input.unpaired_7},{input.unpaired_8},{input.unpaired_9},{input.unpaired_10} \
    -t 16 --continue --k-min 27 --min-contig-len 1000 --presets meta-large -m 0.095 \
    --out-dir {params.output_temp}/{wildcards.sample} \
    --out-prefix {wildcards.sample} && \
    mv {params.output_temp}/{wildcards.sample}/{wildcards.sample}.contigs.fa \
    {params.output_folder} && touch {output.check}
    '''
