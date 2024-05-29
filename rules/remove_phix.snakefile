# remove phiX spike from trimmed reads that are paired and unpaired
rule remove_phix:
    input: 
        check = "reads/trimmomatic/out/{sample}_trim_done.txt",
        forward_trim = "reads/trimmomatic/{sample}_R1_paired.fq.gz",
        reverse_trim = "reads/trimmomatic/{sample}_R2_paired.fq.gz", 
        unpaired_1 = "reads/trimmomatic/unpaired/{sample}_R1_unpaired.fq.gz",
        unpaired_2 = "reads/trimmomatic/unpaired/{sample}_R2_unpaired.fq.gz",
        reference = "/home/amhorst/programs/bbduk/phix174_ill.ref.fa"
    output:
        forward_rm = "reads/rmphix/{sample}_R1_rmphix.fq.gz", 
        reverse_rm = "reads/rmphix/{sample}_R2_rmphix.fq.gz",
        unpaired_1 = "reads/rmphix/unpaired/{sample}_R1_unpaired.fq.gz", 
        unpaired_2 = "reads/rmphix/unpaired/{sample}_R2_unpaired.fq.gz",
        out_stats_un_1 = "reads/rmphix/unpaired/stats/{sample}_R1_stats.txt",
        out_stats_un_2 = "reads/rmphix/unpaired/stats/{sample}_R2_stats.txt",
        out_stats = "reads/rmphix/stats/{sample}_stats.txt", 
        check = "reads/rmphix/out/{sample}_rmphix_done.txt"
        
    # print a message on what its doing
    message: "removing PhiX spike and host reads from {input.forward_trim} and {input.reverse_trim}"
    shell:'''
    module load java
    module load bbmap
    
    bbduk.sh in1={input.forward_trim} in2={input.reverse_trim} threads=8 \
    out1={output.forward_rm} out2={output.reverse_rm} stats={output.out_stats} \
    ref={input.reference} k=31 \
    hdist=1 && bbduk.sh in={input.unpaired_1} out={output.unpaired_1} threads=8 \
    stats={output.out_stats_un_1} ref={input.reference} k=31 \
    hdist=1 && bbduk.sh in={input.unpaired_2} out={output.unpaired_2} threads=8 \
    stats={output.out_stats_un_2} ref={input.reference} k=31 \
    hdist=1 && touch {output.check}
    '''
