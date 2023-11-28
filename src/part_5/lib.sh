#!/bin/bash

mycheck() {
    if [ $1 -ne 1 ]
    then
        echo "Run with one parameter (path to directory)!"
        exit 1
    fi

    if ! [[ -d $2 ]]
    then
        echo "No such directory. Run with one parameter (path to directory)."
        exit 2
    fi
    if ! [[ $2 =~ .*\/$ ]]
    then
        echo "Parameter must end by '/'"
        exit 3
    fi
}

myprint() {
    echo "Total number of folders (including all nested ones) = $(du $1| wc -l)"
    echo "TOP 5 folders of maximum size arranged in descending order (path and size):" 
    max1=$(du $1 | sort -n -r | awk 'NR == 2{print $2}')
    max2=$(du $1 | sort -n -r | awk 'NR == 3{print $2}')
    max3=$(du $1 | sort -n -r | awk 'NR == 4{print $2}')
    max4=$(du $1 | sort -n -r | awk 'NR == 5{print $2}')
    max5=$(du $1 | sort -n -r | awk 'NR == 6{print $2}')
    echo "1 - $max1, $(du -h -s $max1 | awk '{print $1}')"
    echo "2 - $max2, $(du -h -s $max2 | awk '{print $1}')"
    echo "3 - $max3, $(du -h -s $max3 | awk '{print $1}')"
    echo "4 - $max4, $(du -h -s $max4 | awk '{print $1}')"
    echo "5 - $max5, $(du -h -s $max5 | awk '{print $1}')"
    echo "Total number of files = $(find $1 -type f | wc -l)"
    echo "Number of:"
    echo "Configuration files (with the .conf extension) = $(find $1 -name "*.conf" | wc -l)"
    echo "Text files = $(find $1 -name "*.txt" | wc -l)"
    find $1 > result.txt #finding all files in this directory
    echo "Executable files = $(file -f result.txt | sed -r s/'[^:]+:'/''/ | grep executable | wc -l)"
    echo "Log files (with the extension .log) = $(find $1 -name "*.log" | wc -l)"
    echo "Archive files = $(file -f result.txt | sed -r s/'[^:]+:'/''/ | grep archive | wc -l)"
    rm result.txt
    echo "Symbolic links = $(find $1 -type l | wc -l)"
    
    myprint_top10_files $1
    myprint_top10_exe $1
}

myprint_top10_files() {
    echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
    find $1 -type f -exec du -h {} + | sort -rh | head -n 10 > tmp_res.txt
    maxf1=$(cat tmp_res.txt | awk 'NR == 1{print $2}')
    maxf2=$(cat tmp_res.txt | awk 'NR == 2{print $2}')
    maxf3=$(cat tmp_res.txt | awk 'NR == 3{print $2}')
    maxf4=$(cat tmp_res.txt | awk 'NR == 4{print $2}')
    maxf5=$(cat tmp_res.txt | awk 'NR == 5{print $2}')
    maxf6=$(cat tmp_res.txt | awk 'NR == 6{print $2}')
    maxf7=$(cat tmp_res.txt | awk 'NR == 7{print $2}')
    maxf8=$(cat tmp_res.txt | awk 'NR == 8{print $2}')
    maxf9=$(cat tmp_res.txt | awk 'NR == 9{print $2}')
    maxf10=$(cat tmp_res.txt | awk 'NR == 10{print $2}')
    rm tmp_res.txt

    if [[ -n $maxf1 ]]
    then
        echo "1 - $maxf1, $(du -h $maxf1 | awk '{print $1}'), $(echo $maxf1 | sed -r s/'[^\.]*\.'/''/)"
    fi
    
    if [[ -n $maxf2 ]]
    then
    echo "2 - $maxf2, $(du -h $maxf2 | awk '{print $1}'), $(echo $maxf2 | sed -r s/'[^\.]*\.'/''/)"
    fi

    if [[ -n $maxf3 ]]
    then
    echo "3 - $maxf3, $(du -h $maxf3 | awk '{print $1}'), $(echo $maxf3 | sed -r s/'[^\.]*\.'/''/)"
    fi

    if [[ -n $maxf4 ]]
    then
    echo "4 - $maxf4, $(du -h $maxf4 | awk '{print $1}'), $(echo $maxf4 | sed -r s/'[^\.]*\.'/''/)"
    fi

    if [[ -n $maxf5 ]]
    then
    echo "5 - $maxf5, $(du -h $maxf5 | awk '{print $1}'), $(echo $maxf5 | sed -r s/'[^\.]*\.'/''/)"
    fi

    if [[ -n $maxf6 ]]
    then
    echo "6 - $maxf6, $(du -h $maxf6 | awk '{print $1}'), $(echo $maxf6 | sed -r s/'[^\.]*\.'/''/)"
    fi

    if [[ -n $maxf7 ]]
    then
    echo "7 - $maxf7, $(du -h $maxf7 | awk '{print $1}'), $(echo $maxf7 | sed -r s/'[^\.]*\.'/''/)"
    fi

    if [[ -n $maxf8 ]]
    then
    echo "8 - $maxf8, $(du -h $maxf8 | awk '{print $1}'), $(echo $maxf8 | sed -r s/'[^\.]*\.'/''/)"
    fi

    if [[ -n $maxf9 ]]
    then
    echo "9 - $maxf9, $(du -h $maxf9 | awk '{print $1}'), $(echo $maxf9 | sed -r s/'[^\.]*\.'/''/)"
    fi

    if [[ -n $maxf10 ]]
    then
    echo "10 - $maxf10, $(du -h $maxf10 | awk '{print $1}'), $(echo $maxf10 | sed -r s/'[^\.]*\.'/''/)"
    fi
}
myprint_top10_exe() {
    echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)"
    find $1 -type f -name "*.exe" -exec du -h {} + | sort -rh | head -n 10 > tmp_res.txt
    maxe1=$(cat tmp_res.txt | awk 'NR == 1{print $2}')
    maxe2=$(cat tmp_res.txt | awk 'NR == 2{print $2}')
    maxe3=$(cat tmp_res.txt | awk 'NR == 3{print $2}')
    maxe4=$(cat tmp_res.txt | awk 'NR == 4{print $2}')
    maxe5=$(cat tmp_res.txt | awk 'NR == 5{print $2}')
    maxe6=$(cat tmp_res.txt | awk 'NR == 6{print $2}')
    maxe7=$(cat tmp_res.txt | awk 'NR == 7{print $2}')
    maxe8=$(cat tmp_res.txt | awk 'NR == 8{print $2}')
    maxe9=$(cat tmp_res.txt | awk 'NR == 9{print $2}')
    maxe10=$(cat tmp_res.txt | awk 'NR == 10{print $2}')
    rm tmp_res.txt
    if [[ -n $maxe1 ]]
    then
        echo "1 - $maxe1, $(du -h $maxe1 | awk '{print $1}'), $(md5sum $maxe1 | awk '{print $1}')"
    fi
    
    if [[ -n $maxe2 ]]
    then
    echo "2 - $maxe2, $(du -h $maxe2 | awk '{print $1}'), $(md5sum $maxe2 | awk '{print $1}')"
    fi

    if [[ -n $maxe3 ]]
    then
    echo "3 - $maxe3, $(du -h $maxe3 | awk '{print $1}'), $(md5sum $maxe3 | awk '{print $1}')"
    fi

    if [[ -n $maxe4 ]]
    then
    echo "4 - $maxe4, $(du -h $maxe4 | awk '{print $1}'), $(md5sum $maxe4 | awk '{print $1}')"
    fi

    if [[ -n $maxe5 ]]
    then
    echo "5 - $maxe5, $(du -h $maxe5 | awk '{print $1}'), $(md5sum $maxe5 | awk '{print $1}')"
    fi

    if [[ -n $maxe6 ]]
    then
    echo "6 - $maxe6, $(du -h $maxe6 | awk '{print $1}'), $(md5sum $maxe6 | awk '{print $1}')"
    fi

    if [[ -n $maxe7 ]]
    then
    echo "7 - $maxe7, $(du -h $maxe7 | awk '{print $1}'), $(md5sum $maxe7 | awk '{print $1}')"
    fi

    if [[ -n $maxe8 ]]
    then
    echo "8 - $maxe8, $(du -h $maxe8 | awk '{print $1}'), $(md5sum $maxe8 | awk '{print $1}')"
    fi

    if [[ -n $maxe9 ]]
    then
    echo "9 - $maxe9, $(du -h $maxe9 | awk '{print $1}'), $(md5sum $maxe9 | awk '{print $1}')"
    fi

    if [[ -n $maxe10 ]]
    then
    echo "10 - $maxe10, $(du -h $maxe10 | awk '{print $1}'), $(md5sum $maxe10 | awk '{print $1}')"
    fi
}
