#!/bin/bash
#script for generating ussd_total_mis ubort,tOut & sim activation count
	
#cd /home/ussd/url_log
#echo -e "Taking DC2 sim Activation count"
#sh test1.sh > /tmp/dumps_gen_script/DC2_sim.txt

#echo -e "Running Command in DC1.Enter password"
#ssh -p5757 root@10.64.1.140 "cd /home/ussd/url_log/;sh test1.sh > /tmp/DC1_sim.txt"

#echo -e "Copying files.Enter DC1 Password"
#rsync -avz -e 'ssh -p5757' root@10.64.1.140:/tmp/DC1_sim.txt /tmp/dumps_gen_script/DC1_sim.txt

#cd /tmp/dumps_gen_script/
#echo -e "Calculation sum North region"
cat /dev/null > sum_sim.txt
i=1
for so in {c,b,d,e,a};
do
        a=`grep -A 9 "Unique Activation" DC1_sim.txt | sed -n '0~2p'| tr -s '\r' '\n' | sed -n "$i p"`
        b=`grep -A 9 "Unique Activation" DC2_sim.txt | sed -n '0~2p'| tr -s '\r' '\n' | sed -n "$i p"`
        sum=$((a+b))
	echo $sum > sum_north.txt
	echo `sed "s/$sum/$so$sum/" sum_north.txt` >> sum_sim.txt
	i=$(($i+1))	
done

echo `sort sum_sim.txt` > sum_sim.txt
echo `sed "s/[a-e]//g" sum_sim.txt` > sum_sim.txt 
