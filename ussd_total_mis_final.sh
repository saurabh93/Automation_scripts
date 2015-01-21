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
cat /dev/null > sum_sim.txt > sum_ubort.txt > sum_tout.txt

sim_act()
{
echo -e "Calculation sim Activation North & south region ---"
i=1
cat /dev/null > sim_temp.txt
	for so in {c,b,e,d,a};
	do
		a=`grep -A 9 "Unique Activation" $1_sim1.txt | sed -n '0~2p'| tr -s '\r' '\n' | sed -n "$i p"`
        	b=`grep -A 9 "Unique Activation" $1_sim2.txt | sed -n '0~2p'| tr -s '\r' '\n' | sed -n "$i p"`
        sum=$((a+b))
	echo $sum > sum_sim_single.txt
	echo `sed "s/$sum/$so$sum/" sum_sim_single.txt` >> sim_temp.txt
	i=$(($i+1))	
	done
echo `sort sim_temp.txt` > sim_temp.txt
echo `sed "s/[a-e]//g" sim_temp.txt` >> sum_sim.txt 
}

ubort_sum()
{
echo -e "Calculating Ubort north & South.Wait ----"

for u in `seq 24`;
do
cat /dev/null > sum_temp.txt
	a="$(sed -n "$u p" DC1_$1.txt)"
	b="$(sed -n "$u p" DC2_$1.txt)"
	c="$(sed -n "$u p" DR1_$1.txt)"
	d="$(sed -n "$u p" DR2_$1.txt)"
	
	sum_north=$((a+b))
	sum_south=$((c+d))

	echo $sum_north >> sum_temp.txt
	echo $sum_south >> sum_temp.txt

	echo `cat sum_temp.txt | tr '\n' ','` > sum_temp.txt
	cat sum_temp.txt >> sum_$1.txt
done
sed -i "1i North,South" sum_$1.txt
}

sim_act DC
sim_act DR
sed -e  "1i North" -e  "2i South" sum_sim.txt > tmp.txt && mv tmp.txt sum_sim.txt
sleep 3
ubort_sum ubort
ubort_sum tout

