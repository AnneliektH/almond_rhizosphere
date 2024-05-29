# Run bowtie
rule bowtie:
    input:
        index = 'outputs/drep/drep.contigs.fa',
        fw_read_1 = "reads/rmhost/{sample}_L002_R1_rmhost.fq.gz", 
        rv_read_1 = "reads/rmhost/{sample}_L002_R2_rmhost.fq.gz",
        fw_read_2 = "reads/rmhost/{sample}_L003_R1_rmhost.fq.gz",
        rv_read_2 = "reads/rmhost/{sample}_L003_R2_rmhost.fq.gz",
        fw_read_3 = "reads/rmhost/{sample}_L004_R1_rmhost.fq.gz",
        rv_read_3 = "reads/rmhost/{sample}_L004_R2_rmhost.fq.gz",
        check = "outputs/drep/{sample}_done.txt"
    output:
        samfile = "outputs/mapping/{sample}.sam",
        bamfile = "outputs/mapping/{sample}.bam",
        check = "outputs/mapping/out/{sample}_done.txt"

        
    # print a message on what its doing
    message: "running bowtie on {input.fw_read_1}"
    shell:'''
    module load bowtie2
    module load samtools
    
    bowtie2 --threads 12 -x {input.index} \
    -1 {input.fw_read_1},{input.fw_read_2},{input.fw_read_3} \
    -2 {input.rv_read_1},{input.rv_read_2},{input.rv_read_3} \
    -S {output.samfile} --no-unal --sensitive && \
    samtools view -@ 12 -F 4 -bS {output.samfile} | samtools sort > {output.bamfile} && \
    samtools index {output.bamfile} && touch {output.check}
    '''

