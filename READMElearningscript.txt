#count total line
ls -F |grep -v / | wc -l

# short way:
# get all file names from all files
ls *.fq.gz  > jobfilefromfile.txt

# get prefixes that will be needed 
cat jobfilefromfile.txt | awk -F '_' '{print $1"_"$2"_"$3"_"$4}' | sort | uniq
# results: 
ED_A4_Rep2_P004
ED_A4_Rep3_P005
ED_A4_Rep4_P006
ED_A5_Rep1_P019
ED_A5_Rep2_P020
ED_A5_Rep3_P021
ED_A6_Rep1_P034
ED_A6_Rep2_P035
ED_A6_Rep3_P036
ED_A7_Rep1_P049
ED_A7_Rep2_P050
ED_A7_Rep3_P051
WD_A4_Rep1_P013
WD_A4_Rep2_P014
WD_A4_Rep4_P015
WD_A5_Rep1_P028
WD_A5_Rep2_P029
WD_A5_Rep3_P030
WD_A6_Rep1_P043
WD_A6_Rep2_P044
WD_A6_Rep3_P045
WD_A7_Rep1_P058
WD_A7_Rep2_P059
WD_A7_Rep3_P060


# long way: (understanding awk, sort, uniq step by step)
# make prefix: get file names (make a file.txt with only one column first) and process them and  put into a jobfile.txt

# content in the oldnewfilename.csv
Sample_GTATCTC-TATGCAGT_4R009_L1_P043_R2.fq.gz,WD_A6_Rep1_P043_R2.fq.gz
Sample_ACCAGCA-TATGCAGT_4R009_L1_P059_R2.fq.gz,WD_A7_Rep2_P059_R2.fq.gz
Sample_TCGCCAA-CTCCTTAC_4R009_L1_P005_R2.fq.gz,ED_A4_Rep3_P005_R2.fq.gz
Sample_CACTTGA-CTCCTTAC_4R009_L1_P049_R1.fq.gz,ED_A7_Rep1_P049_R1.fq.gz
Sample_ATGCATG-CTCCTTAC_4R009_L1_P004_R1.fq.gz,ED_A4_Rep2_P004_R1.fq.gz
Sample_CACGTTC-CTCCTTAC_4R009_L1_P035_R2.fq.gz,ED_A6_Rep2_P035_R2.fq.gz
Sample_CGTTCTT-CTCCTTAC_4R009_L1_P020_R1.fq.gz,ED_A5_Rep2_P020_R1.fq.gz
Sample_AGAGTGC-TATGCAGT_4R009_L1_P028_R1.fq.gz,WD_A5_Rep1_P028_R1.fq.gz
Sample_GGAATGT-CTCCTTAC_4R009_L1_P051_R1.fq.gz,ED_A7_Rep3_P051_R1.fq.gz
Sample_TTCGACG-CTCCTTAC_4R009_L1_P021_R2.fq.gz,ED_A5_Rep3_P021_R2.fq.gz
Sample_CACGTTC-CTCCTTAC_4R009_L1_P035_R1.fq.gz,ED_A6_Rep2_P035_R1.fq.gz
Sample_GGAATGT-CTCCTTAC_4R009_L1_P051_R2.fq.gz,ED_A7_Rep3_P051_R2.fq.gz
Sample_AGAGTGC-TATGCAGT_4R009_L1_P028_R2.fq.gz,WD_A5_Rep1_P028_R2.fq.gz
Sample_CGTTCTT-CTCCTTAC_4R009_L1_P020_R2.fq.gz,ED_A5_Rep2_P020_R2.fq.gz
Sample_TTCGACG-CTCCTTAC_4R009_L1_P021_R1.fq.gz,ED_A5_Rep3_P021_R1.fq.gz
Sample_GTATCTC-TATGCAGT_4R009_L1_P043_R1.fq.gz,WD_A6_Rep1_P043_R1.fq.gz
Sample_ACCAGCA-TATGCAGT_4R009_L1_P059_R1.fq.gz,WD_A7_Rep2_P059_R1.fq.gz
Sample_TCGCCAA-CTCCTTAC_4R009_L1_P005_R1.fq.gz,ED_A4_Rep3_P005_R1.fq.gz
Sample_ATGCATG-CTCCTTAC_4R009_L1_P004_R2.fq.gz,ED_A4_Rep2_P004_R2.fq.gz
Sample_CACTTGA-CTCCTTAC_4R009_L1_P049_R2.fq.gz,ED_A7_Rep1_P049_R2.fq.gz
Sample_CCTAGAT-TATGCAGT_4R009_L1_P045_R2.fq.gz,WD_A6_Rep3_P045_R2.fq.gz
Sample_CGTTCTT-TATGCAGT_4R009_L1_P029_R2.fq.gz,WD_A5_Rep2_P029_R2.fq.gz
Sample_ATGCATG-TATGCAGT_4R009_L1_P013_R1.fq.gz,WD_A4_Rep1_P013_R1.fq.gz
Sample_ATAGCTG-TATGCAGT_4R009_L1_P015_R2.fq.gz,WD_A4_Rep4_P015_R2.fq.gz
Sample_CACTTGA-TATGCAGT_4R009_L1_P058_R2.fq.gz,WD_A7_Rep1_P058_R2.fq.gz
Sample_TCGCCAA-TATGCAGT_4R009_L1_P014_R1.fq.gz,WD_A4_Rep2_P014_R1.fq.gz
Sample_CACGTTC-TATGCAGT_4R009_L1_P044_R1.fq.gz,WD_A6_Rep2_P044_R1.fq.gz
Sample_CCTAGAT-CTCCTTAC_4R009_L1_P036_R1.fq.gz,ED_A6_Rep3_P036_R1.fq.gz
Sample_ACCAGCA-CTCCTTAC_4R009_L1_P050_R1.fq.gz,ED_A7_Rep2_P050_R1.fq.gz
Sample_GTATCTC-CTCCTTAC_4R009_L1_P034_R2.fq.gz,ED_A6_Rep1_P034_R2.fq.gz
Sample_GGAATGT-TATGCAGT_4R009_L1_P060_R2.fq.gz,WD_A7_Rep3_P060_R2.fq.gz
Sample_AGAGTGC-CTCCTTAC_4R009_L1_P019_R2.fq.gz,ED_A5_Rep1_P019_R2.fq.gz
Sample_TTCGACG-TATGCAGT_4R009_L1_P030_R1.fq.gz,WD_A5_Rep3_P030_R1.fq.gz
Sample_ATAGCTG-CTCCTTAC_4R009_L1_P006_R1.fq.gz,ED_A4_Rep4_P006_R1.fq.gz
Sample_GTATCTC-CTCCTTAC_4R009_L1_P034_R1.fq.gz,ED_A6_Rep1_P034_R1.fq.gz
Sample_ACCAGCA-CTCCTTAC_4R009_L1_P050_R2.fq.gz,ED_A7_Rep2_P050_R2.fq.gz
Sample_TTCGACG-TATGCAGT_4R009_L1_P030_R2.fq.gz,WD_A5_Rep3_P030_R2.fq.gz
Sample_AGAGTGC-CTCCTTAC_4R009_L1_P019_R1.fq.gz,ED_A5_Rep1_P019_R1.fq.gz
Sample_GGAATGT-TATGCAGT_4R009_L1_P060_R1.fq.gz,WD_A7_Rep3_P060_R1.fq.gz
Sample_ATAGCTG-CTCCTTAC_4R009_L1_P006_R2.fq.gz,ED_A4_Rep4_P006_R2.fq.gz
Sample_CGTTCTT-TATGCAGT_4R009_L1_P029_R1.fq.gz,WD_A5_Rep2_P029_R1.fq.gz
Sample_CCTAGAT-TATGCAGT_4R009_L1_P045_R1.fq.gz,WD_A6_Rep3_P045_R1.fq.gz
Sample_ATGCATG-TATGCAGT_4R009_L1_P013_R2.fq.gz,WD_A4_Rep1_P013_R2.fq.gz
Sample_CACTTGA-TATGCAGT_4R009_L1_P058_R1.fq.gz,WD_A7_Rep1_P058_R1.fq.gz
Sample_ATAGCTG-TATGCAGT_4R009_L1_P015_R1.fq.gz,WD_A4_Rep4_P015_R1.fq.gz
Sample_CCTAGAT-CTCCTTAC_4R009_L1_P036_R2.fq.gz,ED_A6_Rep3_P036_R2.fq.gz
Sample_CACGTTC-TATGCAGT_4R009_L1_P044_R2.fq.gz,WD_A6_Rep2_P044_R2.fq.gz
Sample_TCGCCAA-TATGCAGT_4R009_L1_P014_R2.fq.gz,WD_A4_Rep2_P014_R2.fq.gz

# set file= xxxx first
file = oldnewfilename.csv

# get WD_A6_Rep1_P043_R2.fq.gz
# cut -d"," becuase its a csv file; the default is a tab delimited, "cut -f1" is good for default
# add $() to make it run 
prefix=$(head -n 1 $file | tail -n 1 | cut -d"," -f2)

# use "echo" to see results 
echo $prefix

# get WD_A6_Rep1_P043_R2 (first line in file)
prefix=$(basename $(head -n 1 $file | tail -n 1 | cut -d"," -f2) .fq.gz)

# get WD_A7_Rep2_P059_R2 (second line in file)
prefix=$(basename $(head -n 2 $file | tail -n 1 | cut -d"," -f2) .fq.gz)

# get WD A7 Rep2 (remove "_" from the origninal name)
prefix=$(echo $(basename $(head -n 2 $file | tail -n 1 | cut -d"," -f2) .fq.gz) | awk -F '_' '{print $1,$2,$3}')

# get WD_A7_Rep2 (put in "_")
prefix=$(echo $(basename $(head -n 2 $file | tail -n 1 | cut -d"," -f2) .fq.gz) | awk -F '_' '{print $1"_"$2"_"$3}')

# put the prefixes into a jobfile.txt from file(=oldnewfilename.csv) 
for i in $(cat $file); do echo $i | cut -d"," -f2 >> jobfile.txt; done
# in jobfile.txt: 
WD_A6_Rep1_P043_R2.fq.gz
WD_A7_Rep2_P059_R2.fq.gz
ED_A4_Rep3_P005_R2.fq.gz
ED_A7_Rep1_P049_R1.fq.gz
ED_A4_Rep2_P004_R1.fq.gz
ED_A6_Rep2_P035_R2.fq.gz
ED_A5_Rep2_P020_R1.fq.gz
WD_A5_Rep1_P028_R1.fq.gz
ED_A7_Rep3_P051_R1.fq.gz
ED_A5_Rep3_P021_R2.fq.gz
ED_A6_Rep2_P035_R1.fq.gz
ED_A7_Rep3_P051_R2.fq.gz
WD_A5_Rep1_P028_R2.fq.gz
ED_A5_Rep2_P020_R2.fq.gz
ED_A5_Rep3_P021_R1.fq.gz
WD_A6_Rep1_P043_R1.fq.gz
WD_A7_Rep2_P059_R1.fq.gz
ED_A4_Rep3_P005_R1.fq.gz
ED_A4_Rep2_P004_R2.fq.gz
ED_A7_Rep1_P049_R2.fq.gz
WD_A6_Rep3_P045_R2.fq.gz
WD_A5_Rep2_P029_R2.fq.gz
WD_A4_Rep1_P013_R1.fq.gz
WD_A4_Rep4_P015_R2.fq.gz
WD_A7_Rep1_P058_R2.fq.gz
WD_A4_Rep2_P014_R1.fq.gz
WD_A6_Rep2_P044_R1.fq.gz
ED_A6_Rep3_P036_R1.fq.gz
ED_A7_Rep2_P050_R1.fq.gz
ED_A6_Rep1_P034_R2.fq.gz
WD_A7_Rep3_P060_R2.fq.gz
ED_A5_Rep1_P019_R2.fq.gz
WD_A5_Rep3_P030_R1.fq.gz
ED_A4_Rep4_P006_R1.fq.gz
ED_A6_Rep1_P034_R1.fq.gz
ED_A7_Rep2_P050_R2.fq.gz
WD_A5_Rep3_P030_R2.fq.gz
ED_A5_Rep1_P019_R1.fq.gz
WD_A7_Rep3_P060_R1.fq.gz
ED_A4_Rep4_P006_R2.fq.gz
WD_A5_Rep2_P029_R1.fq.gz
WD_A6_Rep3_P045_R1.fq.gz
WD_A4_Rep1_P013_R2.fq.gz
WD_A7_Rep1_P058_R1.fq.gz
WD_A4_Rep4_P015_R1.fq.gz
ED_A6_Rep3_P036_R2.fq.gz
WD_A6_Rep2_P044_R2.fq.gz
WD_A4_Rep2_P014_R2.fq.gz



# use "awk" to extract the columns and  "-F '_'" to keep those terms($1,$2,$3,$4) separated
# use "sort" to	sort the names
# use "uniq" to remove duplicates because of R1 and R2 in the original name (forward and reverse)
cat jobfile.txt | awk -F '_' '{print $1"_"$2"_"$3"_"$4}' | sort | uniq 
# get the following in the jobfile.txt: 
ED_A4_Rep2_P004
ED_A4_Rep3_P005
ED_A4_Rep4_P006
ED_A5_Rep1_P019
ED_A5_Rep2_P020
ED_A5_Rep3_P021
ED_A6_Rep1_P034
ED_A6_Rep2_P035
ED_A6_Rep3_P036
ED_A7_Rep1_P049
ED_A7_Rep2_P050
ED_A7_Rep3_P051
WD_A4_Rep1_P013
WD_A4_Rep2_P014
WD_A4_Rep4_P015
WD_A5_Rep1_P028
WD_A5_Rep2_P029
WD_A5_Rep3_P030
WD_A6_Rep1_P043
WD_A6_Rep2_P044
WD_A6_Rep3_P045
WD_A7_Rep1_P058
WD_A7_Rep2_P059
WD_A7_Rep3_P060

