#!/bin/bash

. lib.sh
START_TIME=$(date +"%s.%1N")
mycheck $# $1
myprint $1
END_TIME=$(date +"%s.%1N")
echo $START_TIME $END_TIME | awk '{printf "Script execution time (in seconds) = %.1f\n", $2 - $1}'
