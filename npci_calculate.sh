#!/bin/bash

echo -e "Getting DC2 NPCI"
#cat /home/ussd/SIP_Manager/MIS/NPCI_MIS/NPCI_DC2_`TZ=GMT+24 date +%Y%m%d`.txt | sed -n '0~4p' > npcidc2.txt 
#cat /home/ussd/SIP_Manager/MIS/NPCI_MIS/NPCI_DC2_`date +%Y%m%d`.txt | sed -n '0~4p' >> npcidc2.txt

#echo -e "Running command in DR1.Enter DR1 password"
#cat /home/ussd/SIP_Manager/MIS/NPCI_MIS/NPCI_DR1__`TZ=GMT+24 date +%Y%m%d`.txt > /tmp/npcidr1.txt
#cat /home/ussd/SIP_Manager/MIS/NPCI_MIS/NPCI_DR1__`date +%Y%m%d`.txt >> /tmp/npcidr1.txt

#echo -e
#cat /home/ussd/SIP_Manager/MIS/NPCI_MIS/NPCI_DR2_`TZ=GMT+24 date +%Y%m%d`.txt | sed -n '0~4p'> npcidr2.txt
#cat /home/ussd/SIP_Manager/MIS/NPCI_MIS/NPCI_DR2_`date +%Y%m%d`.txt | sed -n '0~4p' >> npcidr2.txt

#cat /home/ussd/SIP_Manager/MIS/NPCI_MIS/NPCI_DC1_`TZ=GMT+24 date +%Y%m%d`.txt | sed -n '0~4p'> npcidc1.txt 
#cat /home/ussd/SIP_Manager/MIS/NPCI_MIS/NPCI_DC1_`date +%Y%m%d`.txt | sed -n '0~4p' >> npcidc1.txt


#cat /home/SOAP/NPCI/log/`TZ=GMT+24 date +%Y%-m%d`-req.txt | grep -v BARRED* | wc -l
 
npci_cal()
{
	if [ $# == 0 ];then
		echo "Usage: `basename $0` filename1 filename2 filename3 filename4"
	fi
	
	cat /dev/null > ~/testlinux/sum_npci.txt
	filename=$1
	filename2=$2
	filename3=$3
	filename4=$4
		
	for j in `seq 2 8`
	do
	sum=sum_2=sum_south=sum_south2=0
		for i in `seq 24`
		do
			a=`cat $filename | tr -s '[:blank:]' ',' | cut -d ',' -f $j | sed -n "$i p"`
			b=`cat $filename2 | tr -s '[:blank:]' ',' | cut -d ',' -f $j | sed -n "$i p"`
			c=`cat $filename3 | tr -s '[:blank:]' ',' | cut -d ',' -f $j | sed -n "$i p"`
			d=`cat $filename4 | tr -s '[:blank:]' ',' | cut -d ',' -f $j | sed -n "$i p"`

			sum=$((sum+a+b))
			sum_south=$((sum_south+c+d))
		done

		echo "Field $j" >> ~/testlinux/sum_npci.txt
		
		if [ $j -lt 6 ];then
			echo -e $sum "\t" $sum_south >> ~/testlinux/sum_npci.txt
		else
			echo -e $((sum+sum_south)) >> ~/testlinux/sum_npci.txt
		fi
	done

	#echo $sum
}

npci_cal /home/saurabh/testlinux/npcidc1.txt /home/saurabh/testlinux/npcidc2.txt /home/saurabh/testlinux/npcidr1.txt /home/saurabh/testlinux/npcidr2.txt
