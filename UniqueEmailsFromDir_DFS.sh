#!/bin/bash

if [ $# -ne 1 ]; then
	echo "You need one argument (directory)."
	exit 100
elif ! [ -d $1 ]; then
	echo "Argument needs to be a directory."
	exit 100
fi

main=$PWD
array=()

search() {
	for things in *;do
		if [ -d $things ]; then
			cd $things
			search
			cd ..
		elif [ -f $things ]; then
			array+=("$PWD/$things")
		fi
	done
}

touch unique_emails.txt
cd $1
search
touch tempFile.txt

for things in "${array[@]}"; do
	grep -E '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}' "$things" >> tempFile.txt
done

sort -u tempFile.txt >> $main/unique_emails.txt
rm tempFile.txt

echo "Success!"
