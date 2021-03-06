#!/bin/bash

# Script to convert all image files from a directory (parameter) into png format file
# it also reduces size

# Sanity checks ?
# ...

# Main code

ls -1 $1/*.png > imagefiles
cat imagefiles
while read imgfile 
do
	echo "IMG file: $imgfile"
	lengthname=${#imgfile}
	namefile=${imgfile:0:$lengthname-4}
	convert "$1/$imgfile" -resize 200x200 "$namefile.jpg"	
	#mogrify -resize 200x200 *.png
	#mogrify -format png *.jpg
	
done < imagefiles
rm imagefiles
exit 0
