#!/bin/bash
#Script for generating dumps of 121 or 234 of given date (only Work in bash 4 version or above

HOST=`hostname | cut -d '-' -f 2`

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

echo -e "Which Region Dumps you want? \n 1)North \n 2)South \n 3)Both"

read region

echo -e "121 or 234"
read dump_want

read_date

if [[ -z $dump_want  || -z $date_want ]];then
        echo "No input Given"
        exit 1
fi

if [ $confirm = "n" ];then #IF entered wrong date by mistake,prompt for date again
        read_date
fi

year=`echo $date_want | cut -d '/' -f 1`
date_dump=`echo $date_want | cut -d '/' -f 3`
month=`echo $date_want | cut -d '/' -f 2`

case $region in
        "Both")
                #Generate both Regions Dump (No Break in case statement)
        ;&

        "South")
                echo -e "Enter DR1 Password"
                ssh  root@10.64.33.132 "cd /tmp/dump_script/;bash dumps_any_date.sh $dump_want $date_want $year $date_dump $month"
                rsync -avz  root@10.64.33.132:/tmp/"$dump_want"_DR1-"$year$month$date_dump".txt /tmp/

                echo -e "Enter DR2 password"
                 ssh  root@10.64.33.142 "cd /tmp/dump_script/;bash dumps_any_date.sh $dump_want $date_want $year $date_dump $month"
                rsync -avz  root@10.64.33.142:/tmp/"$dump_want"_DR2-"$year$month$date_dump".txt /tmp/

                if [ $region == "South" ];then
                        echo -e "Done"
                        exit 0
                fi

        ;&

        "North")
                echo -e "Enter DC1 Password"
                ssh  -p5757 root@10.64.1.140 "cd /tmp/dump_script/;bash dumps_any_date.sh $dump_want $date_want $year $date_dump $month"
                rsync -avz -e 'ssh -p5757' root@10.64.1.140:/tmp/"$dump_want"_DC1-"$year$month$date_dump".txt /tmp/
        #       echo -e "Copying files.Enter DC2 Password"
        #       rsync -avz -e 'ssh -p5757' root@10.64.1.140;'/tmp/"$dump_want"_$HOST-$year$month$date_dump.txt/' /tmp/


        ;;
        *)
                echo -e "No Region Selected"
                exit 1
        ;;
esac

#**** Program Starts Here ****#
echo -e "Generating $dump_want DC2.Wait......"

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

        cd `find /home/ussd/SIP_Manager/MIS/"$dump_want"_Circle_wise_mis/ -name "$dump_want"_Cirle_WISE_$year$month$date_dump* -printf "%h\n" | sed -n '1p'`

                pwd
                file_exist
        data=`zcat "$dump_want"_Cirle_WISE_$year$month$date_dump*.txt.gz 2> /dev/null | cut --complement -d ',' -f 5  | cut --complement -d ':' -f 2 | cut --complement -d '#' -f 2 | cut --complement -d '|' -f 2- | tr -s ',' ' ' > /tmp/"$dump_want"_$HOST-$year$month$date_dump.txt`
        fi
