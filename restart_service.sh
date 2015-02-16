#!/bin/bash

check_serv()
{
a=0
b=0
ps -ef | grep [c]heck

if [ $? != 0 ];then
	echo "Not running"
	cd /home/saurabh/testlinux
	./checkservice.sh &> running.txt &
	
	test $? -eq 0 && echo "binary started successfully" || echo "Not able to start"
else
	echo "Running"
fi

netstat -anp | grep mysql &> /dev/null

if [ $? != 0 ];then
	echo "Not Running"
	a=1
else
	echo "Running"
fi
}

check_serv

#test $a -eq 1 -o  $b -eq 1 && sleep 10 && check_serv && test $a -eq 1 -o $b -eq 1 && \
#echo "Running service..wait"


#if [ `ps -ef | grep [c]heck` ];then
#	cd /home/saurabh/testlinux
#	./checkservice.sh &> running.txt &
#	
#	test $? -eq 0 && echo "Service started successfully" || echo "Not able to start"
#	check_serv
#else	
