#!/bin/bash


check_serv()
{
a=0
b=0
ps -ef | grep [c]heck

if [ $? != 0 ];then
	echo "Not running"
	a=1
else
	echo "Running"
fi

netstat -anp | grep mysql &> /dev/null

if [ $? != 0 ];then
	echo "Not Running"
	b=1
else
	echo "Running"
fi
}

bin_restart()
{
cd /home/saurabh/testlinux
	./checkservice.sh &> running.txt &
	
	test $? -eq 0 && echo "Service restarted successfully" || echo "Something Wrong.Start process Mannualy"
}

for ((;;))
do
check_serv


test $a -eq 1 && echo "Binary not running." && sleep 10 && check_serv && \
test $a -eq 1 && echo "Starting Binary wait" && bin_restart
test $b -eq 1 -a $a -eq 0 && echo "Killing application" && kill -9 `pgrep [c]heck` && \
echo "Kill successfull.Now restarting application" && sleep 10 && bin_restart

#test $? -ne 0 -a $a -eq 0 -a $b -eq 1 && echo "Something is Wrong.Start process mannualy"


sleep 20
done
