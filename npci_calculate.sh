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
	filename=$1
	
	for j in `seq 2 8`
	do
	sum=0
		for i in `seq 24`
		do
			a=`cat $filename | tr -s '[:blank:]' ',' | cut -d ',' -f $j | sed -n "$i p"`
	
			sum=$((sum+a))
	
		done
	done

	echo $sum
}

npci_cal /home/saurabh/testlinux/npcidc1.txt

