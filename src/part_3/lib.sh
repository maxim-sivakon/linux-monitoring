#!/bin/bash

mycheck() {
    if [[ $5 -ne 4 ]]
    then
        echo Enter 4 parameters.
        exit 1
    elif [[ $1 != [1-6] || $2 != [1-6] || $3 != [1-6] || $4 != [1-6] ]]
    then
        echo Enter right parameters from 1 to 6.
        exit 2
    elif [[ $1 -eq $2 || $3 -eq $4 ]]
    then
        echo Parameters first and second or third and fourth are the same.
        echo Run the script again and enter different values.
        exit 3
    fi
}

setcolors() {
    case $1 in
        1 )
            back1="\e[107m" ;;
        2 )
            back1="\e[41m" ;;
        3 )
            back1="\e[42m" ;;
        4 )
            back1="\e[44m" ;;
        5 )
            back1="\e[45m" ;;
        6 )
            back1=$"\e[40m" ;;
        * )
        echo Something is wrong
    esac

    case $2 in
        1 )
            font1="\e[97m" ;;
        2 )
            font1="\e[31m" ;;
        3 )
            font1="\e[32m" ;;
        4 )
            font1="\e[34m" ;;
        5 )
            font1="\e[35m" ;;
        6 )
            font1=$"\e[30m" ;;
        * )
        echo Something is wrong
    esac

    case $3 in
        1 )
            back2="\e[107m" ;;
        2 )
            back2="\e[41m" ;;
        3 )
            back2="\e[42m" ;;
        4 )
            back2="\e[44m" ;;
        5 )
            back2="\e[45m" ;;
        6 )
            back2=$"\e[40m" ;;
        * )
        echo Something is wrong
    esac

    case $4 in
        1 )
            font2="\e[97m" ;;
        2 )
            font2="\e[31m" ;;
        3 )
            font2="\e[32m" ;;
        4 )
            font2="\e[34m" ;;
        5 )
            font2="\e[35m" ;;
        6 )
            font2=$"\e[30m" ;;
        * )
        echo Something is wrong
    esac
}

myprint() {
    reset="\e[0m"
    timez=$(date +"%z" | head -c 3)
    tmp_RAM=$(vmstat -s -S k | grep total -m1 | awk '{print $1}')
    tmp_uRAM=$(vmstat -s -S k | grep used -m1 | awk '{print $1}')
    tmp_fRAM=$(vmstat -s -S k | grep free -m1 | awk '{print $1}')
    tmp_root=$(df -B1 / | awk '{print($2)}' | grep -v '1B-blocks')
    tmp_uroot=$(df -B1 / | awk '{print($3)}' | grep -v 'Used')
    tmp_froot=$(df -B1 / | awk '{print $4}' | grep -v 'Avail')
    echo -e "${back1}${font1}HOSTNAME${reset} = ${back2}${font2}$(hostname)${reset}"
    echo -e "${back1}${font1}TIMEZONE${reset} = ${back2}${font2}$(cat /etc/timezone) UTC $timez)${reset}"
    echo -e "${back1}${font1}USER${reset} = ${back2}${font2}$(whoami)${reset}"
    echo -e "${back1}${font1}OS${reset}=${back2}${font2} $(hostnamectl | grep System | sed -r s/'[^:]+:'/''/)${reset}"
    echo -e "${back1}${font1}DATE${reset} =${back2}${font2} $(date +"%d %B %Y %T")${reset}"
    echo -e "${back1}${font1}UPTIME${reset} =${back2}${font2} $(uptime -p)${reset}"
    echo -e "${back1}${font1}UPTIME_SEC${reset} =${back2}${font2} $(cat /proc/uptime | awk '{print $1}')${reset}"
    echo -e "${back1}${font1}IP${reset} = ${back2}${font2}$(hostname -I | awk '{print $1}')${reset}"
    echo -e "${back1}${font1}MASK${reset} = ${back2}${font2}$(route | awk 'NR == 4{print $3}')${reset}"
    echo -e "${back1}${font1}GATEWAY${reset} = ${back2}${font2}$(ip route | grep default | awk '{print $3}')${reset}"
    echo -e "${back1}${font1}RAM${reset} = ${back2}${font2}$(echo  "$tmp_RAM 1000000" | awk '{printf "%.3f\n", $1 / $2}') GB${reset}"
    echo -e "${back1}${font1}RAM_USED${reset} = ${back2}${font2}$(echo  "$tmp_uRAM 1000000" | awk '{printf "%.3f\n", $1 / $2}') GB${reset}"
    echo -e "${back1}${font1}RAM_FREE${reset} = ${back2}${font2}$(echo  "$tmp_fRAM 1000000" | awk '{printf "%.3f\n", $1 / $2}') GB${reset}"
    echo -e "${back1}${font1}SPACE_ROOT${reset} = ${back2}${font2}$(echo "$tmp_root 1000000" | awk '{printf "%.2f\n", $1 / $2}') MB${reset}"
    echo -e "${back1}${font1}SPACE_ROOT_USED${reset} = ${back2}${font2}$(echo "$tmp_uroot 1000000" | awk '{printf "%.2f\n", $1 / $2}') MB${reset}"
    echo -e "${back1}${font1}SPACE_ROOT_FREE${reset} = ${back2}${font2}$(echo "$tmp_froot 1000000" | awk '{printf "%.2f\n", $1 / $2}') MB${reset}"
}