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
#for j in {1,2};
#do
i=1
#cat /dev/null > sim_temp.txt
	for so in {c,b,e,d,a};
	do
        #	if [ $j -eq 1 ];then
		a=`grep -A 9 "Unique Activation" DC1_sim.txt | sed -n '0~2p'| sed -n "$i p"`
        	b=`grep -A 9 "Unique Activation" DC2_sim.txt | sed -n '0~2p'| sed -n "$i p"`
	#	else
      #		a=`grep -A 9 "Unique Activation" DR1_sim.txt | sed -n '0~2p'| tr -s '\r' '\n' | sed -n "$i p"`
       # 	b=`grep -A 9 "Unique Activation" DR2_sim.txt | sed -n '0~2p'| tr -s '\r' '\n' | sed -n "$i p"`
	#	fi
        sum=$((a+b))
	echo $sum > sum_sim_single.txt
	echo `sed "s/$sum/$so$sum/" sum_sim_single.txt` >> sim_temp.txt
	i=$(($i+1))	
	done
echo `sort sim_temp.txt` > sim_temp.txt
echo `sed "s/[a-e]//g" sim_temp.txt` >> sum_sim.txt 
#done
