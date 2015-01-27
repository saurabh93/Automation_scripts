#/bin/bash

cat /dev/null > count
for i in `seq 1 25`
do 
	num=`ls -1 | egrep  USSD_PARTNER_FINDER_ | sed -n "$i p"`
	zcat $num | cut -d '#' -f 4 | sed '/^$/d' > temp.txt
	k=`tail -1 temp.txt`
	
	sed -i "/$k/d;/[A-Z]/d;s/^/91/g"  temp.txt 
	cat Upload_base150.txt >> temp.txt
	j=`echo $num | tr '-' '_' | cut -d '_' -f 4`
	sort temp.txt | uniq > $j-file.txt
	echo $j >> count
	cat $j-file.txt | wc -l >> count
	
done
