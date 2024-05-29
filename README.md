# almond_rhizosphere
Repository for code used in "Almond rhizosphere viral, prokaryotic, and fungal communities differed significantly among four California orchards and in comparison to bulk soil communities"


https://www.biorxiv.org/content/10.1101/2023.06.03.543555v1.full

Most of the read processing was done using snakemake. 
1. Read processing using Trimmomatic: http://www.usadellab.org/cms/?page=trimmomatic
2. Removing the PhiX spike in using bbmap (this is not needed if your sequencing center does this for you!!) https://jgi.doe.gov/data-and-tools/software-tools/bbtools/bb-tools-user-guide/bbmap-guide/
3. Assembly using MEGAHIT https://github.com/voutcn/megahit
4. Running VIBRANT to recover viral genomes https://github.com/AnantharamanLab/VIBRANT
