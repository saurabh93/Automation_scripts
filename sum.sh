#!/bin/bash

cat /dev/null > sum_all.txt	#Empty file

filename1="$1"			#Filename input as arguments
filename2="$2"

if [ $# != 2  ];then
	echo "Wrong Arguments.Give two file names as Arguments"
	exit 0
fi
for i in `seq 1 37`;
do
	for q in `seq 1 5`;
	do
		#get single column number from file
	a="$(grep -w "$(sed -n "$i p" arrange.txt)" "$filename1" | tr -s '[:blank:]' '|' | cut -d '|' -f $q)"
	b="$(grep -w "$(sed -n "$i p" arrange.txt)" "$filename2" | tr -s '[:blank:]' '|' | cut -d '|' -f $q)"
		
	sum=$((a+b))	
	if [ $q -eq 1 ];then
		echo $sum > sum_main.txt
	elif [ $q -gt 1 ];then
		echo $sum > temp.txt
		join -j $q sum_main.txt temp.txt > sum_temp.txt
		cat sum_temp.txt > sum_main.txt
	fi
	done
	cat sum_main.txt | tr -s '[:blank:]' ',' >> sum_all.txt #add ',' at space (optional)

done
