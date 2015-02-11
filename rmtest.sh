#!/bin/bash

echo "test" > rmtest.txt

alias rm='mv "$@" /tmp/'

rm rmtest.txt
