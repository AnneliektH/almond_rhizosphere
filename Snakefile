# main snakefile:
include: "vibrant.snakefile"    
include: "checkv.snakefile"
    

# List with only main headers
experiments = ['BU_H2_ESCV','BU_H3_MAV']
#input is dus actually the final output
rule all:
    input:
        expand("outputs/vibrant_final/out/{sample}_vibrant_done.txt", sample=experiments)
               


