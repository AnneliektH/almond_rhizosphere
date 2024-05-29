# rename contigs and  split off contigs >10kb
rule rename_contigs:
    input:
        contigs = "assemblies/megahit_final/{sample}.contigs.fa",
        check = "assemblies/out/{sample}_assem_done.txt"
    output:
        contigs_renamed = "outputs/megahit_final/{sample}.contigs_renamed.fa",
        assembly_stats = "outputs/megahit_final/stats_assembly/{sample}.megahit.stats.txt",
        contigs_10kb = "outputs/megahit_final/{sample}.contigs_10kb.fa",
        check = "assemblies/out/{sample}_reformat_done.txt"
    # print a message on what its doing
    message: "renaming contigs of sample {input.contigs}"
    shell:'''
    module load bbmap
    rename.sh in={input.contigs} out={output.contigs_renamed} prefix={wildcards.sample}_as_redo && \
    reformat.sh in={output.contigs_renamed} out={output.contigs_10kb} minlength=10000 &&
    stats.sh in={output.contigs_renamed} gc={output.assembly_stats} gcformat=3 && touch {output.check}
    '''
