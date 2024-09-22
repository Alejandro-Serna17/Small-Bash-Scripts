#!/bin/bash

echo -e "\nWelcome to Rock, Paper, Scissors!\n"
echo -e "The rules are as follows:\nRock beats Scissors (by crushing them)\nScissors beat Paper (by cutting it)\nPaper beats Rock (by covering it)\n"

rock=0
paper=1
scissor=2
tie=0
while [ $tie -eq 0 ]; do
	computer_move=$((RANDOM % 3))
	echo -n "Please enter your move:"
	read move
	case $move in
		rock) 
		if [ $computer_move -eq $scissor ]; then
			echo -e "Computer's selection: scissor\nYou Win!"
			tie=1
		elif [ $computer_move -eq $paper ]; then
			echo -e "Computer's selection: paper\nYou lose..."
			tie=1
		else
			echo -e "Computer's selection: rock\nTie!"
		fi
		;;
		paper) 
		if [ $computer_move -eq $rock ]; then
			echo -e "Computer's selection: rock\nYou Win!"
			tie=1
		elif [ $computer_move -eq $scissor ]; then
			echo -e "Computer's selection: scissor\nYou lose..."
			tie=1
		else
			echo -e "Computer's selection: paper\nTie!"
		fi	
		;;
		scissor) 
		if [ $computer_move -eq $paper ]; then
			echo -e "Computer's selection: paper\nYou Win!"
			tie=1
		elif [ $computer_move -eq $rock ]; then
			echo -e "Computer's selection: rock\nYou lose..."
			tie=1
		else
			echo -e "Computer's selection: scissor\nTie!"
		fi
		;;
		*) echo "Invalid move!";;
	esac
done
