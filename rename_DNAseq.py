import glob
import os
myfiles = glob.glob('*.fq.gz')

# need to make sure only table in the txt or csv
# all spaces are only space or tab
# only one extra line at the end
lookupfile = 'DNAseqsamples.txt' 

# Hash mydict, mydict=
mydict = dict()

for line in open(lookupfile):
	#ignore first line do something for this
	# mydict['key']
	# mydict['ADL06']=['A4'], line[0]=A4,line[1]=ADL06
	line = line.split()
	mydict[line[1]] = [line[0]]

#make a file recording oldfile match newfilename
outfile = open('oldnewfilename.csv','w')

# This returns the list after the equal
for file in myfiles:

	#split your oldfile name by _ and use it as a key for Mylist = mydict[oldfile[]], [1]is Rep number, [2]is 1/2.fq.gz
	oldfile = [file.split('_')[0],file.split('_')[1],file.split('_')[2]]
	mylist = mydict[oldfile[0]]

	#this makes newfilename = 'A4_ADL06_Rep1_1.fq.gz'
	newfilename = mylist[0] + '_' +  oldfile[0] + '_' + 'Rep' +  oldfile[1] + '_' + oldfile[2]
	
	#rename actual files
	os.rename(file, newfilename)

	#record names in for loop and sort names
	outfile.write(file + '\t' + newfilename + '\n')

outfile.close()	



