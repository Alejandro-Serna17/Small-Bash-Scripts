#!/bin/bash

if [ "$#" -lt 3 ]; then
	echo "Not enough arguments not provided (Need at least 3)"
	exit 100	
fi

timeStamp=`date +'%Y%m%d'`
dir="backup_$timeStamp"
mkdir $dir
logFile=./$dir/log.txt
touch $logFile

for arguments in "$@"; do
	if [ -e "$arguments" ]; then
       		 cp "$arguments" "$dir/${arguments}_$timeStamp"
       		 echo "Original file name: "$arguments" " >> $logFile
       		 echo "New file name: ${arguments}_$timeStamp" >> $logFile
	 else
		 echo ""$arguments" doesn't exist and it will be skipped."
		 continue
	fi
done

echo -e "The backup is complete!\nThe location of the backup directory is: `pwd`/$dir"
