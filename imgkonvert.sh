#!/bin/bash
# Test
# Script to convert all mage files from a directory (parameter) into png format file
# it also reduces size
#First change
# Sanity checks ?
if [ $1 = "-h" ]
then
	echo ""
	echo "	HELP FOR DIRECTORIES"
	echo "	--------------------"
	echo "Example			Select the subdirectory 'Example'"
	echo "Example/example1 	Select the subdirectory 'example1' from the subdirectory"
	echo "			'Example'"
	echo "..			Select the parent of the current directory"
	echo "../..			Select the parent's parent of the current directory"
	echo "/Users			Select the top of the boot volume, then into the"
	echo "			top-level directory named 'Users'"
	echo "~			Select your home directory (note: that's a tilde, not a"
	echo "			dash)"
	echo "~/Documents		Select your home directory, then into your 'Documents'"
	echo "			directory"
	echo "'/Applications (MacOS 9)'	Select the of the boot volume, then into the"
	echo "			top-level directory named 'Applications (MacOS 9)'. The"
	echo "			quote marks tell the shell (command interpreter) to"
	echo "			ignore the special characters (spaces and parentheses)"
	echo "			in the directory name that would otherwise confuse it."
	echo   ""
	echo   "	HELP FOR ACTIONS"
	echo   "	----------------"
	echo   "1		Change the format of the image"
	echo   "2		Change the size of the image"
	echo   "3		Change the name of the image"
	echo ""
	echo   "	HELP FOR EXTRA PARAMETER"
	echo   "	------------------------"
	echo   "If action is changing the format of the image:"
	echo   "jpg		Set format as jpg"
	echo   "png		Set format as png"
	echo   "raw		Set format as raw"
	echo   "If action is changing the size of the image:"
	echo   "[number]	Set size as [number]x[number]"
	echo   "[number]%	Set size as [previus]*[number]/100"
	echo   "If action is changing the name of the image:"
	echo   "[name]		Set name as [name]"
	exit 1
fi
if [ $# != 3 ]
then
	echo "Wrong parameters"
	echo "Usage: imgkonvert.sh directory action parameter"
	echo "Use imgkonvert -h for help"
	exit 1
fi

# Main code

ls -1 $1*.jpg > imagefiles

while read imgfile 
do
	lengthname=${#imgfile}
	namefile=${imgfile;0;$lengthname-4}
	convert $imgfile -resize 200x200 $namefile.png	

done < imagefiles
rm imagefiles
exit 0
