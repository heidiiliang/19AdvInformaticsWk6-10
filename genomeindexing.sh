#!/bin/bash
#$ -N index
#$ -q sam

module load bwa/0.7.8
module load samtools/1.3
module load bcftools/1.3
module load enthought_python/7.3.2
module load gatk/2.4-7
module load picard-tools/1.87
module load java/1.7
module load bowtie2/2.2.7

# -----------------------------------------------------------------------------------------
# index your reference genome first, best do this for all the indexes you are like to need
# -----------------------------------------------------------------------------------------
# I put these in "ref"
# write a script, submit to queue
# you will have to complete each command

# link the ref folder by ln -sf ../../ref (2 folder above= ../../ref), and a light blue color folder will show in the "actual" folder.
# or write: ref=../../ref/dmel-all-chromosome-r6.13.fasta

# ${var} bracket is a saferway and can be "quote" if necessary

ref="ref/dmel-all-chromosome-r6.13.fasta"
bwa index ${ref}
samtools faidx  ${ref}
java -d64 -Xmx128g -jar /data/apps/picard-tools/1.87/CreateSequenceDictionary.jar R=$ref O=ref/dmel-all-chromosome-r6.13
bowtie2-build ${ref} ref/dmel-all-chromosome-r6.13




