#!/bin/bash

cat /dev/null > sum_all.txt	#Empty file

filename1="$1"			#Filename input as arguments
filename2="$2"

if [ $# != 2 ];then
	echo "Usage $0 filename1 filename2"
	exit 1
fi

for i in `seq 38`;
do
	for q in `seq 5`;
	do
		#get single column number from file
	a="$(grep -w "$(sed -n "$i p" arrange.txt)" "$filename1" | tr -s '[:blank:]' '|' | cut -d '|' -f $q)"
	b="$(grep -w "$(sed -n "$i p" arrange.txt)" "$filename2" | tr -s '[:blank:]' '|' | cut -d '|' -f $q)"
	
	#c="$(echo $a |tr -s ' ' '\n' | wc -w)"
	#echo $c

		#search for any duplicate entry in file
	if (( $(echo $a | tr -s ' ' '\n' | wc -w) > 1 ));then
			if (( $(echo $a | cut -d ' ' -f 1) > $(echo $a | cut -d ' ' -f 2) ));then
				a=`echo $a | cut -d ' ' -f 1`
			else
				a=`echo $a | cut -d ' ' -f 2`
			fi
	fi
	if (( $(echo $b |tr -s ' ' '\n' | wc -w) > 1 ));then
			if (( $(echo $b | cut -d ' ' -f 1) > $(echo $b | cut -d ' ' -f 2) ));then
				b=`echo $b | cut -d ' ' -f 1`
			else
				b=`echo $b | cut -d ' ' -f 2`
			fi
	fi
	echo "a=$a"
	sum=$((a+b))	
	
	if [ $q -eq 1 ];then
		echo $sum > sum_main.txt
	elif [ $q -gt 1 ];then
		echo $sum > temp.txt
		echo `join -j $q  sum_main.txt temp.txt` > sum_main.txt
	#	cat sum_temp.txt
	#	cat sum_temp.txt > sum_main.txt
	fi
	done
	cat sum_main.txt | tr -s '[:blank:]' ',' >> sum_all.txt #add ',' in place of space (optional)

	if [ $i == 9 ];then
		echo "25%"
	elif [ $i -eq 19 ];then
		echo "50%"
	elif [ $i -eq 36 ];then
		echo "95%"
	fi
	

done
