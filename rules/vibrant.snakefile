# run vibrant
rule vibrant:
    input:
        contigs = "outputs/megahit_final/{sample}.contigs_10kb.fa",
    output:
        vibrant_contig = "outputs/vibrant_final/{sample}.contigs_10kb.phages_combined.fna",
        check = "outputs/vibrant_final/out/{sample}_vibrant_done.txt"
    params:
        output_folder = "outputs/vibrant_final",
        output_temp = "outputs/vibrant_temp"
    # print a message on what its doing
    message: "running vibrant on {input.contigs}"
    shell:'''
    mkdir -p  outputs/vibrant_temp/
    
    set +u
    source ~/.bashrc
    conda activate vibrant
    set -u
    
    VIBRANT_run.py -i {input.contigs} -folder {params.output_temp}/{wildcards.sample} \
    -t 8 -l 10000 -o 4 -virome && \
    mv {params.output_temp}/{wildcards.sample}/VIBRANT_{wildcards.sample}.contigs_10kb/VIBRANT_phages_{wildcards.sample}.contigs_10kb/{wildcards.sample}.contigs_10kb.phages_combined.fna \
    {params.output_folder} && touch {output.check} 
    '''
