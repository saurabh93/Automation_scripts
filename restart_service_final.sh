#!/bin/bash

check_serv()
{
a=0
b=0

date +%R
ps -ef | grep -q [E]LD141

if [ $? != 0 ];then
        echo -e "141 service not running"
        a=1;

else
        echo -e "141 binary running"
fi

netstat -anp | egrep -w '10.64.18.4' | egrep -q ESTABLISHED

if [ $? != 0 ];then
        echo -e "Connection not established"
        b=1
else
        echo -e "connection Established\n"

fi
}

bin_restart()
{
        cd /home/ussd/smpp/
        sh smpp_multiple.sh &> /dev/null

        test $? -eq 0 && echo "Service restarted successfully" || echo "Something Wrong.Start process Mannualy"
        sleep 10
}


for((;;))
do

check_serv

#echo $a;echo $b
test $a -eq 1 && echo "Binary not running." && sleep 65 && check_serv && \
test $a -eq 1 && echo "Starting Binary wait" && bin_restart
test $b -eq 1 -a $a -eq 0 && echo "Killing application" && kill -9 `ps -ef | grep [E]LD141 | tr -s ' ' ',' | cut -d ',' -f2` && \
echo "Kill successfull.Now restarting application" && sleep 10 && bin_restart && check_serv


sleep 120
done
