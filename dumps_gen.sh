#!/bin/bash
#script for generating 234 & 121 dumps(saurabh)

echo -e "Generating DC2 234 dumps"
cd /home/ussd/SIP_Manager/testingscriptdirectory/files/

cat 234_Cirle_WISE_`TZ=GMT+24 date +%Y%m%d`*.txt | grep  ",00," | cut  --complement -d ','  -f 3,5  | cut --complement -d '|' -f2 | tr -s ',' ' ' > /tmp/234_DC2.txt
echo -e "Complete"

echo -e "Running Command in DR1.Enter password"

ssh root@10.64.33.132 "cd /tmp/;bash 234_DR1.sh"
echo -e "Complete"

echo -e "Copying file Enter DR1 password"
rsync -avzP root@10.64.33.132:/tmp/234_DR1.txt /tmp/



echo -e "Running Command in DR2.Enter password"

ssh root@10.64.33.142 "cd /tmp/;bash 234_DR2.sh"
echo -e "Complete"

echo -e "Copying file Enter DR2 password"
rsync -avzP root@10.64.33.142:/tmp/234_DR2.txt /tmp/



echo -e "Running Command in DC1.Enter password"

ssh -p5757 root@10.64.1.140 "cd /tmp/;bash 234_DC1.sh"
echo -e "Complete"

echo -e "Copying file Enter DC1 password"
rsync -avzP -e 'ssh -p5757' root@10.64.1.140:/tmp/234_DC1.txt /tmp/ 

wait $!
cd /tmp/
echo "-----------------------------------"
rm -rf 234_north.txt 234_north.txt 2> /dev/null

echo "DR1 Count"

cat 234_DR1.txt | wc -l

echo "DR2 Count "

cat 234_DR2.txt | wc -l

echo "Append"

cat 234_DR2.txt >> 234_DR1.txt

echo "Total count South"

cat 234_DR1.txt | wc -l


echo "DC1 Count "

cat 234_DC1.txt | wc -l

echo "DC2 count "

cat 234_DC2.txt | wc -l

echo "Append"

cat 234_DC2.txt >> 234_DC1.txt

echo "Total Count North"

cat 234_DC1.txt | wc -l


echo "Removing & renaming files"

rm -rf 234_DR2.txt 234_DC2.txt

mv 234_DC1.txt 234_north.txt

mv 234_DR1.txt 234_south.txt

echo -e "234_Dumps Complete"


echo -e "------------------------------------------- \nStarting 121 Dumps generation wait"

sleep 6

echo -e "Generating DC2 121 dumps"
cd /home/ussd/SIP_Manager/MIS/121_Circle_wise_mis

zcat 121_Cirle_WISE_`TZ=GMT+24 date +%Y%m%d`.txt.gz | cut --complement -d ',' -f 5  | cut --complement -d ':' -f 2 |cut --complement -d '|' -f2- |tr ',' ' '> /tmp/121_DC2.txt

echo -e "Running Command in DR1.Enter password"

ssh root@10.64.33.132 "cd /tmp/;bash 121_DR1.sh"

echo -e "Copying file Enter DR1 password"
rsync -avz root@10.64.33.132:/tmp/121_DR1.txt /tmp/



echo -e "Running Command in DR2.Enter password"

ssh root@10.64.33.142 "cd /tmp/;bash 121_DR2.sh"

echo -e "Copying file Enter DR2 password"
rsync -avz root@10.64.33.142:/tmp/121_DR2.txt /tmp/



echo -e "Running Command in DC1.Enter password"

ssh -p5757 root@10.64.1.140 "cd /tmp/;bash 121_DC1.sh"

echo -e "Copying file Enter DC1 password"
rsync -avz -e 'ssh -p5757' root@10.64.1.140:/tmp/121_DC1.txt /tmp/

wait $!
cd /tmp/
echo "-----------------------------------"
rm -rf 121_north.txt 121_south.txt 2> /dev/null

echo "DR1 Count "

cat 121_DR1.txt | wc -l

echo "DR2 Count "

cat 121_DR2.txt | wc -l

echo "Append"

cat 121_DR2.txt >> 121_DR1.txt

echo "Total count South"

cat 121_DR1.txt | wc -l


echo "DC1 Count "

cat 121_DC1.txt | wc -l

echo "DC2 count "

cat 121_DC2.txt | wc -l

echo "Append"

cat 121_DC2.txt >> 121_DC1.txt

echo "Total Count North"

cat 121_DC1.txt | wc -l


echo "Removing & renaming files"

rm -rf 121_DR2.txt 121_DC2.txt 2> /dev/null

mv 121_DC1.txt 121_north.txt

mv 121_DR1.txt 121_south.txt
