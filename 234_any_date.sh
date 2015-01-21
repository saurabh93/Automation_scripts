#!/bin/bash
HOST=`hostname | cut -d '-' -f 2`
echo $HOST
read_date()
{
echo "Enter the date of 234 dumps you want"
echo -e "Format shoud be year/month/date e.g 2015/01/07"

read date_want

echo -e "Date entered $date_want \n Confirm y or n"

read confirm
}

check_date()
{
                if (( $month > $(date +%m) || $date_234 > $(date +%d) ));then
                        echo -e "Wrong Date \n"
                        exit 0
                fi
}

file_exist()
{
	fileexist="$(ls -ltr 234_Cirle_WISE_$year$month$date_234* | wc -l)"
	
	if [ $fileexist == 0 ] ;then
		echo "File Does not exist"
	else	
		
		echo $data	
	fi
}


#**** Program Starts Here ***#
read_date

if [ "$confirm" = "n" ];then #IF entered wrong date by mistake,ask for date again
        read_date
else
        year=`echo $date_want | cut -d '/' -f 1`
	date_234=`echo $date_want | cut -d '/' -f 3`
        month=`echo $date_want | cut -d '/' -f 2`

        if [ $year -eq `date +%Y` ];then 
                check_date
        #	a=$((`date +%m` - a))
	#	b=$((`date +%d` - b))
        #	month=`date --date="$a month ago" +%m`
	#	date_234=`date --date="$b days ago" +%d`
	#	echo -e "month=$month \n"
	#	echo -e "date = $date_234 \n"
		cd /home/ussd/SIP_Manager/testingscriptdirectory/files/
		file_exist
		data=`cat 234_Cirle_WISE_$year$month$date_234*.txt | grep  ",00," | cut  --complement -d ','  -f 3,5  | cut --complement -d '|' -f2 | tr -s ',' ' ' > /tmp/234_$HOST_$year$month$date_234.txt`
        else
		cd /home/ussd/SIP_Manager/MIS/234_Circle_wise_mis/
		file_exist		
	data=`zcat 234_Cirle_WISE_$year$month$date_234.txt.gz | cut --complement -d ',' -f 5  | cut --complement -d ':' -f 2 | cut --complement -d '#' -f 2 | tr -s ',' ' ' > /tmp/234_$HOST_$year$month$date_234.txt`
        fi

fi
