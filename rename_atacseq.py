import glob
import os
myfiles = glob.glob('*.fq.gz')

# need to make sure only table in the txt or csv
# all spaces are only space or tab
# only one extra line at the end
lookupfile = 'ATACseqsamples.txt' 

# Hash mydict, mydict=
mydict = dict()

for line in open(lookupfile):
	#ignore first line do something for this
	# mydict['key']
	# mydict['P013'] = ['A4','WD','1'], line[1]=A4, line[2]=WD, line[3]=1
	line = line.split()
	mydict[line[0]] = [line[2],line[1],line[3]]

#make a file recording oldfile match newfilename
outfile = open('oldnewfilename.csv','w')

# This returns the list after the equal
for file in myfiles:

	#split your oldfile name by _ and use it as a key for Mylist = mydict[‘P013’], [4]is BARCODE, [5]R1/R2.fq.gz
	oldfile = [file.split('_')[4],file.split('_')[5]]
	mylist = mydict[oldfile[0]]

	#this makes newfilename = 'WD_A7_Rep1_P058_R1.fq.gz'
	newfilename = mylist[0] + '_' + mylist[1] + '_' + 'Rep' + mylist[2] + '_' + oldfile[0] + '_' + oldfile[1]
	
	#rename actual files
	os.rename(file, newfilename)

	#record names in for loop and sort names
	outfile.write(file + ',' + newfilename + '\n')

outfile.close()	


