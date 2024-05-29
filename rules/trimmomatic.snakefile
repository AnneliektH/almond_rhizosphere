# trimmomatic snakefile
# run trimmomatic on raw reads
rule trimmomatic:
    input:
        forward_raw = "reads/raw/{sample}_R1_001.fastq.gz",
        reverse_raw = "reads/raw/{sample}_R2_001.fastq.gz"
    output:
        forward_paired = "reads/trimmomatic/{sample}_R1_paired.fq.gz",
        forward_unpaired = "reads/trimmomatic/unpaired/{sample}_R1_unpaired.fq.gz",
        reverse_paired = "reads/trimmomatic/{sample}_R2_paired.fq.gz",
        reverse_unpaired = "reads/trimmomatic/unpaired/{sample}_R2_unpaired.fq.gz",
        check = "reads/trimmomatic/out/{sample}_trim_done.txt"
        
    message: "Trimming Illumina adapters from {input.forward_raw} and {input.reverse_raw}"
    shell:'''
        module load java
        java -jar /home/amhorst/programs/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 8 -phred33 {input.forward_raw} {input.reverse_raw} \
        {output.forward_paired} {output.forward_unpaired} \
        {output.reverse_paired} {output.reverse_unpaired} \
        ILLUMINACLIP:/home/amhorst/programs/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
        SLIDINGWINDOW:4:30 MINLEN:50 && touch {output.check}
        '''
        
