#!/bin/bash

re='^[-+]?[0-9]+([.,][0-9]+)?$'
if [ $# -ne 1 ]
then
   echo Invalid input!
elif [[ $1 =~ $re ]]
then
    echo Invalid input!
else
    echo ""$1
fi