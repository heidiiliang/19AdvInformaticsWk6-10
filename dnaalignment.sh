# Align your data!  Now the directory structure helps you

# do each sample in parallel using a shell script
# you may want a shell script or python program to generate "$file"
# below are some "hints" you will have to change *some* filenames to variables!
# I would make sure I can run each caller on a single small pair of files before writing a shell script
#       - zcat blah.blah.F.fq.gz | head -n 1000000 | gzip -c > test.F.fq.gz
#       - zcat blah.blah.R.fq.gz | head -n 1000000 | gzip -c > test.R.fq.gz
# these 250K read pair files will run very quickly ... even from a qrsh shell to debug


# how many tasks?
# with make 8 you want -R set to yes.

#!/bin/bash
#$ -N bwamemalignment
#$ -q abi*
#$ -pe make 4
#$ -R y
#$ -ckpt restart
#$ -t 1-12


# with ckpt restart, your list must be all intel or all AMD. The "i" after the queue indicates intel

# ----------------
# module load -- what do I have to load, versions, versions, versions
# ----------------
module load bwa/0.7.8
module load samtools/1.3
module load bcftools/1.3
module load enthought_python/7.3.2
module load gatk/2.4-7
module load picard-tools/1.87
module load java/1.7
module load bowite2/2.2.7

# or pass the file name to the shell script, how would I do this?

ls *.fq.gz  > jobfilefromfile.txt

filename=jobfilefromfile.txt

# here is a hint if you had a tab delimited input file


# ------------------
# bwa mem alignments
# ------------------
# you need to add readgroups to merge and use GATK
# reference_genome, READ1.fq.gz, READ2.fq.gz, folder should likely all be shell variables

# one more thing to think about you can't just step through each fq.gz file, you have to step through each PAIR!!

# When testing just through commandline, need to set SGE_TASK_ID=# (ex. SGE_TASK_ID=1)

###original sample
# ls *1.fq.gz | sed 's/_1.fq.gz//' >DNAseq.prefixes.txt  # outside the array
# prefix=`head -n $SGE_TASK_ID DNAseq.prefixes.txt | tail -n 1`
# bwa mem -t 8 -M $ref $prefix_1.fq.gz $prefix_2.fq.gz | samtools view -bS - > folder/$SGE_TASK_ID.bam
# samtools sort folder/$SGE_TASK_ID.bam -o folder/$SGE_TASK_ID.sort.bam
# java -Xmx20g -jar /data/apps/picard-tools/1.87/AddOrReplaceReadGroups.jar I=folder/$SGE_TASK_ID.sort.bam O=folder/$SGE_TASK_ID.RG.bam SORT_ORDER=coordinate RGPL=illumina RGPU=D109LACXX RGLB=Lib1 RGID={your sample name} RGSM={your sample name} VALIDATION_STRINGENCY=LENIENT
# samtools index folder/$prefix.RG.bam


prefix=$(cat $filename | awk -F '_' '{print $1"_"$2"_"$3}' | sort | uniq | head -n $SGE_TASK_ID | tail -n 1)

MYOUTDIR="Alignment"
mkdir -p ${MYOUTDIR}

bwa mem -t ${NSLOTS} -M ${ref} ${prefix}_1.fq.gz ${prefix}_2.fq.gz | samtools view -bS - > ${MYOUTDIR}/${prefix}.bam

samtools sort ${MYOUTDIR}/${prefix}.bam -o ${MYOUTDIR}/${prefix}.sort.bam

java -Xmx20g -jar /data/apps/picard-tools/1.87/AddOrReplaceReadGroups.jar I=${MYOUTDIR}/${prefix}.sort.bam O=${MYOUTDIR}/${prefix}.RG.bam SORT_ORDER=coordinate RGPL=illumina RGPU=HFYHYBBXX RGLB=Lib1 RGID=${prefix} RGSM=${prefix} VALIDATION_STRINGENCY=LENIENT

samtools index ${MYOUTDIR}/${prefix}.RG.bam
