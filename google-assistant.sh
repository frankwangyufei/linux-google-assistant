#!/bin/bash
for pid in $(pidof -x googlesamples-assistant-pushtotalk); do
    if [ $pid != $$ ]; then
        kill -9 $pid
    fi 
done
source ~/env/bin/activate
googlesamples-assistant-pushtotalk --once 2>&1 | parallel -uj1 '
if  (echo {}) | grep -e '[rR]ecording' ;
then
 beep
fi '
