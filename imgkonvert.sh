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

# Easter Egg

if [ $1 = "tongue-twister" ] && [ $2 = "easter" ] && [ $3 = "egg" ]
then
	echo "You have found an Easter Egg:"
	echo "How much wood would a woodchuck chuck if a woodchuck could chuck wood?"
	echo "A woodchuck would chuck as much wood as a woodchuck could chuck if a"
	echo "woodchuck could chuck wood."
	exit 0
fi
# Main code

case $2 in 
	 1 ) 
	ls -1 $1/*.* > imagefiles
	cat imagefiles
	while read imgfile 
	do
	echo "IMG file: $imgfile"
	lengthname=${#imgfile}
	namefile=${imgfile:0:$lengthname-4}
	convert  "$namefile.$3"	
	#mogrify -resize 200x200 *.png
	#mogrify -format png *.jpg
	
	done < imagefiles
	rm imagefiles
	exit 0
	;;
	2 )

		pattern= '^[[:digit:]]+%$'	
		if [[ pattern =~ $3 ]]
		then 
			ls -1 $1/*.* > imagefiles
			cat imagefiles
			while read imgfile 
			do
				convert -resize $2x$2 $1/$imagefiles "$1/t_$imagefiles"
				echo "IMG file: $imgfile"
			done < imagefiles
			rm imagefiles
			exit 0
		else ls -1 $1 > imagefiles
			cat imagefiles
			while read imgfile 
			do
				echo "IMG file: $imgfile"
				lengthname=${#imgfile}
				namefile=${imgfile:0:$lengthname-4}
				if ! test -d $1/Converted 
				then 
					mkdir "$1/Converted"
				fi
				convert "$1/$imgfile" -resize $3x$3 "$1/Converted/$namefile.jpg"	
			done < imagefiles
			rm imagefiles
			exit 0
		fi
	;;
	3 ) ls -1 $1 > imagefiles
	cat imagefiles
	while read imgfile 
	do
	echo "IMG file: $imgfile"
	lengthname=${#imgfile}
	namefile=${imgfile:$lengthname-3:3}
	convert "$1/$imgfile" "$3.$namefile"	
	#mogrify -resize 200x200 *.png
	#mogrify -format png *.jpg
	done < imagefiles
	rm imagefiles
	exit 0
	;;
esac
