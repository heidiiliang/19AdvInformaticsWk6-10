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

#### need to check the file names fastq.gz/fq.gz/fasta.gz or other types and change the names accordingly in the following

### 
# ----------------------
# make a createjobfile.sh
# -----------------------
#get all filenames into a file
#ls ./Sample_*/*.fastq.gz > RNAsamples.txt
#get list of ./Sample_10/10_GGAATGT_L001_R1_001.fastq.gz

#get names for workingfile
#file=RNAsamples.txt
#if [ -f RNAworking.txt ]; then
#   rm -rf RNAworking.txt
#fi
#for i in $(cat $file); do echo $i | awk -F '/' '{print $3}' | sort | uniq  >> RNAworking.txt; done
#get 10_GGAATGT_L001_R1_001.fastq.gz
###

#get prefix
workingfile="RNAworking.txt"
prefix=$(cat $workingfile | awk -F '_' '{print $1"_"$2"_"$3}' | sort | uniq | head -n $SGE_TASK_ID | tail -n 1)
#get 10_GGAATGT_L001

#get name for mydir(directory name) under the output folder
mydir=$(echo $prefix | awk -F ["_"] '{print "Sample_"$1}')


# get the file types "fastq.gz"
fileext=$(cat $workingfile | cat $workingfile | awk -F '.' '{print $2"."$3}' | sort | uniq )

# always link ref index folder close to the working file
gtf=../ref/dmel-all-r6.13.gtf
bowtieindex=../ref/dmel-all-chromosome-r6.13

# setup outputfolder
MYOUTDIR="tophatresult"
mkdir -p ${MYOUTDIR}
mkdir -p ${MYOUTDIR}/${mydir}

# run tophat and samtools
# tophat (calls bowtie2 ... module load tophat/2.1.0 , bowtie2/2.2.7)
# tophat is for RNAseq, here you can't align to the genome
# ... but have to consider transcripts
tophat -p ${NSLOTS} -G ${gtf} -o ${MYOUTDIR}/${mydir} ${bowtieindex} ${mydir}/${prefix}_R1_001.${fileext} ${mydir}/${prefix}_R2_001.${fileext}


#change name for accepted_hits.bam
cd ${MYOUTDIR}
ln -sf ${mydir}/accepted_hits.bam ${mydir}_accepted_hits.bam

samtools sort -@ ${NSLOTS} ${mydir}_accepted_hits.bam -o ${mydir}_accepted_hits.sort.bam

samtools index ${mydir}_accepted_hits.sort.bam
