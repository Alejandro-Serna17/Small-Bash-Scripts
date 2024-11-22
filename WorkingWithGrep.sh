#!/bin/bash

echo -e "\nNumber of words that have at least three a's: `grep -oi '\b\w*a\w*a\w*a\w*\b' dictionary.txt | wc -w`\n"

echo "Number of words that have exactly 3 e's where all e's are separated: `grep -Eoi '\b[a-df-z]*e[a-df-z]+e[a-df-z]+e[a-df-z]*\b' dictionary.txt | wc -w`"

touch fullWords.txt

grep -Eoi '\b(e{2,}[a-z]*|[a-z]*e{2,}|[a-z]*e{2,}[a-z]*)\b' dictionary.txt > fullWords.txt

touch lastThree.txt

grep -Eoi '\w{3}\b' fullWords.txt > lastThree.txt
echo -e "\nThree most common last three letter for words that have two adjacent e's:\n"
sort lastThree.txt | uniq -c | sort -nr | head -n3

rm fullWords.txt lastThree.txt

