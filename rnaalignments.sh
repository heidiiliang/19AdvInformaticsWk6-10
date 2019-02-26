#!/bin/bash
#$ -N tophat
#$ -q abi*
#$ -pe make 8
#$ -R y
#$ -ckpt restart
#$ -t 1-2

module load bwa/0.7.8
module load samtools/1.3
module load bcftools/1.3
module load enthought_python/7.3.2
module load gatk/2.4-7
module load picard-tools/1.87
module load java/1.7
module load bowite2/2.2.7
module load tophat/2.1.0 

ls ./Sample_*/*.fastq.gz > RNAsamples.txt

file=RNAsamples.txt
for i in $(cat $file); do echo $i | awk -F '/' '{print $3}' | sort | uniq | head -n $SGE_TASK_ID | tail -n 1 >> RNAworking.txt; done

workingfile="RNAworkingfile.txt"
for i in $(cat $workingfile); do echo $i | awk -F '_' '{print $1"_"$2"_"$3}' | sort | uniq | head -n $SGE_TASK_ID | tail -n 1 >> prefixes.txt; done

# always link ref index folder close to the working file
ref=../ref/dmel-all-r6.13.gtf
bowtieindex=../ref/dmel-all-chromosome-r6.13.4.bt2

MYOUTDIR="tophatresult"
mkdir -p ${MYOUTDIR}

# tophat (calls bowtie2 ... module load tophat/2.1.0 , bowtie2/2.2.7)
# tophat is for RNAseq, here you can't align to the genome
# ... but have to consider transcripts
tophat -p 8 -G ${ref} -o ${MYOUTDIR} ${bowtieindex} ${prefix}_R1.001.fq.gz ${prefix}_R2.001.fq.gz
#samtools sort ${MYOUTDIR}/${prefix}_accepted_hits.bam -o ${MYOUTDIR}/${prefix}_accepted_hits.sort.bam
#samtools index 

