#!/bin/bash

echo -n "Please enter a directory: "
read directory

if ! [ -d $directory ]; then
	echo "Directory \"$directory\" does not exist."
	echo -n "Would you like to create one? [Y/n] "
	read choice
	if [ $choice = n ]; then
		echo "Goodbye."
		exit 0
	elif [ $choice = Y ]; then
		echo -n "Enter the name of the directory: "
		read directory
		mkdir $directory
		echo "Directory $directory has been created."
	else
		echo "Invalid choice."
		exit 100
	fi

fi

cd "$directory"
directory=`pwd`
dirBaseName=`basename $directory`

while true; do

	echo -e "\nList of files and directories inside $dirBaseName:\n"

	for things in *; do
		echo $things
	done

	echo -n -e "\nPlease select a file or subdirectory from $dirBaseName or type \"exit\" to exit the script: "
	read selection
	echo -e "\n"

	numberOfLines=10

	if [ $selection = exit ]; then
		echo "Goodbye"
		exit 0
	fi

	if [ -f "$selection" ]; then
		echo "First 10 lines from $selection:"
		head -n$numberOfLines $selection
		echo -n "Would you like more lines to be displayed? [Y/n] "
		read choice

		if [ $choice = Y ]; then
			while [ $choice = Y ]; do
				fileLines=`wc -l < "$selection"`
				if [ $fileLines -lt $numberOfLines ]; then
					echo -e "\nEnd of file has been reached!\n"
					break
				fi
				((numberOfLines+=10))
				echo -e "10 more lines added!\n"
				head -n$numberOfLines "$selection"
				echo -n "Would you like to add more lines? [Y/n] "
				read choice
				if [ $choice = Y ]; then
					continue
				elif [ $choice = n ]; then
					echo "Got it!"
					break
				fi
			done
		elif [ $choice = n ]; then
			echo "Got it!"
		else
			echo "Invalid choice."
		fi
	fi

	array=()

	search() {
		for things in *; do
		        if [ -d "$things" ]; then
        			cd "$things"
				 search
	    			cd ..
		        elif [ -f "$things" ]; then
        		    	timeNow=$(date +%s)
            			lastModTime=$(stat -c %Y "$things")
				difference=$((timeNow - lastModTime))
				if [ $difference -le 86400 ]; then
					array+=("$PWD/$things")
				fi
	        	fi
		done
	}

	if [ -d $selection ]; then
		cd $selection
		search
		if [ ${#array[@]} -eq 0 ]; then
			echo -e "No files from \"$selection\" have been modified in the last 24hrs.\n"
		else
			echo -e "The following files have been modified in the last 24hrs:\n"
			count=0

			for list in "${array[@]}"; do
				baseName=`basename "$list"`
				((count++))
				echo "($count) $baseName"
			done

			echo -n -e "\nPlease select one of the files by number: "
			read answer
			adjust=$(($answer-1))
	        	index=${array[$adjust]}
			baseNameIndex=`basename "$index"`
			echo "First 10 lines from $baseNameIndex:"
        		head -n$numberOfLines $index
		        echo -n "Would you like more lines to be displayed? [Y/n] "
	        	read choice

	        	if [ $choice = Y ]; then
        	        	while [ $choice = Y ]; do
                	        	fileLines=`wc -l < "$index"`
                        		if [ $fileLines -lt $numberOfLines ]; then
                                		echo -e "\nEnd of file has been reached!\n"
                                		break
                        		fi
                        		((numberOfLines+=10))
                        		echo -e "10 more lines added!\n"
	                        	head -n$numberOfLines "$index"
        	                	echo -n "Would you like to add more lines? [Y/n] "
                	        	read choice
                        		if [ $choice = Y ]; then
	                                	continue
        	                	elif [ $choice = n ]; then
                	                	echo "Got it!"
                        	        	break
                        		fi
	                	done
        		elif [ $choice = n ]; then
                		echo "Got it!"
	        	else
        		        echo "Invalid choice."
		        fi
		fi
	fi

	array=()
	echo "Back to the main menu!"
	cd $directory
done
