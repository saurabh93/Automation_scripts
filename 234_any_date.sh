#!/bin/bash

cd /home/ussd/SIP_Manager/testingscriptdirectory/files/

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
                if (( $a > $(date +%m)));then
                        echo -e "Wrong Date \n"
                        exit 0
                fi
}

get_data()
{



read_date

if [ "$confirm" = "n" ];then
        read_date
else
        a=`echo $date_want | cut -d '/' -f 1`
        if [ $a -eq `date +%Y` ];then
                a=`echo $date_want | cut -d '/' -f 2`
                check_date
                echo $a
                a=$((`date +%m` - a))
                month=`date --date="$a month ago" +%m`
                a=`echo $date_want | cut -d '/' -f 3`

        else
                echo "2014"
        fi

fi

