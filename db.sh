#!/bin/bash -x

filename=CRESTA_FULL_RL`date -u +%y%m%d`

if [ -f $filename ];then
	echo "Process"
else
	echo "mail"
fi
