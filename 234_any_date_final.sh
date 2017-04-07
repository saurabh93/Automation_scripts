#!/bin/bash

HOST=`hostname | cut -d '-' -f 2`

echo -e "Which dumps you want 121 or 234"
read dump_want


read_date()
{
echo "Enter the date of $dump_want dumps you want"
echo -e "Format shoud be year/month/date e.g 2015/01/07 \n (!!!Minimum date Error checking.So Enter right date & in mentioned Format!!!)"

read date_want

echo -e "Date entered $date_want \n Confirm y or n"

read confirm
}

check_date()
{
                if (( $month > $(date +%m) || $date_dump > $(date +%d) ));then
                        echo -e "Wrong Date \n"
                        exit 1
                fi
}

file_exist()
{
        fileexist="$(ls -ltr "$dump_want"_Cirle_WISE_$year$month$date_dump* 2> /dev/null | wc -l)" #To check Multiple files existence

        if [ $fileexist == 0 ] ;then
                echo "File Does not exist"
                exit 1
        else
                echo -e "Generating Dumps-------- wait"
                echo $data
        fi
}


#**** Program Starts Here ****#
read_date

if [ $confirm = "n" ];then #IF entered wrong date by mistake,prompt for date again
        read_date
else
        year=`echo $date_want | cut -d '/' -f 1`
        date_dump=`echo $date_want | cut -d '/' -f 3`
        month=`echo $date_want | cut -d '/' -f 2`

        if [ $year == `date +%Y` ] && [ $dump_want == 234 ];then
                check_date
        #       a=$((`date +%m` - a))
        #       b=$((`date +%d` - b))
        #       month=`date --date="$a month ago" +%m`
        #       date_dump=`date --date="$b days ago" +%d`
        #       echo -e "month=$month \n"
        #       echo -e "date = $date_dump \n"
                cd /home/ussd/SIP_Manager/testingscriptdirectory/files/
                file_exist
                data=`cat "$dump_want"_Cirle_WISE_$year$month$date_dump*.txt 2> /dev/null | grep  ",00," | cut  --complement -d ','  -f 3,5  | cut --complement -d '|' -f2 | tr -s ',' ' ' > /tmp/"$dump_want"_$HOST-$year$month$date_dump.txt`
        else
                if [[ $month > 12 || $date_dump > 31 ]];then
                        echo -e "Wrong date"
                        exit 1
                fi

                #cd /home/ussd/SIP_Manager/MIS/"$dump_want"_Circle_wise_mis/
        cd `find /home/ussd/SIP_Manager/MIS/"$dump_want"_Circle_wise_mis/ -name "$dump_want"_Cirle_WISE_$year$month$date_dump* -printf "%h\n" | sed -n '1p'`

                pwd
                file_exist
        data=`zcat "$dump_want"_Cirle_WISE_$year$month$date_dump*.txt.gz 2> /dev/null | cut --complement -d ',' -f 5  | cut --complement -d ':' -f 2 | cut --complement -d '#' -f 2 | cut --complement -d '|' -f 2- | tr -s ',' ' ' > /tmp/"$dump_want"_$HOST-$year$month$date_dump.txt`
        fi

fi