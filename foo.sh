#!/bin/bash
f1=$1
if [ "$f1" == "foo" ];then
	echo "bar"
elif [ "$f1" == "bar" ];then
	echo "foo"
else
	echo "Type foo or bar"
fi	
