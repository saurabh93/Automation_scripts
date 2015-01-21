#!/bin/bash

echo -e "Your choice ?\n"

echo -e "1) foo\n"

echo -e "2) bar\n"

echo -e "3) or enter nothing!!\n"


read INPUT;

echo -e "You have entered: " $INPUT

case $INPUT in

bar)

echo -e "foo\n"

;;

foo)

echo -e "bar\n"

;;

*)

echo -e "foobar\n"

;;

esac 

