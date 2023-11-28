#!/bin/bash

mycheck() {
    if [[ $1 -ne 0 ]]
    then
        echo Run without parameters!
        exit 1
    fi

    if [[ -z $column1_background ]]
    then
        column1_background=5
        back1_flag=1
    fi

    if [[ -z $column1_font_color ]]
    then
        column1_font_color=1
        font1_flag=1
    fi

    if [[ -z $column2_background ]]
    then
        column2_background=3
        back2_flag=1
    fi

    if [[ -z $column2_font_color ]]
    then
        column2_font_color=6
        font2_flag=1
    fi

    if [[ $2 = $3 || $4 = $5 ]]
    then
        echo Colors are the same.
        echo Run the script again and enter different values.
        exit 2
    fi
}

setcolors() {
    case $1 in
        1 )
            back1="\e[107m"
            back1_color=white ;;
        2 )
            back1="\e[41m"
            back1_color=red ;;
        3 )
            back1="\e[42m"
            back1_color=green ;;
        4 )
            back1="\e[44m"
            back1_color=blue ;;
        5 )
            back1="\e[45m"
            back1_color=purple ;;
        6 )
            back1=$"\e[40m"
            back1_color=black ;;
        * )
        echo Something is wrong
    esac

    case $2 in
        1 )
            font1="\e[97m"
            font1_color=white ;;
        2 )
            font1="\e[31m"
            font1_color=red ;;
        3 )
            font1="\e[32m"
            font1_color=green ;;
        4 )
            font1="\e[34m"
            font1_color=blue ;;
        5 )
            font1_color="\e[35m"
            font1_color=purple ;;
        6 )
            font1=$"\e[30m"
            font1_color=black ;;
        * )
        echo Something is wrong
    esac

    case $3 in
        1 )
            back2="\e[107m"
            back2_color=white ;;
        2 )
            back2="\e[41m"
            back2_color=red ;;
        3 )
            back2="\e[42m"
            back2_color=green ;;
        4 )
            back2="\e[44m"
            back2_color=blue ;;
        5 )
            back2="\e[45m"
            back2_color=purple ;;
        6 )
            back2=$"\e[40m"
            back2_color=black ;;
        * )
        echo Something is wrong
    esac

    case $4 in
        1 )
            font2="\e[97m"
            font2_color=white ;;
        2 )
            font2="\e[31m"
            font2_color=red ;;
        3 )
            font2="\e[32m"
            font2_color=green ;;
        4 )
            font2="\e[34m"
            font2_color=blue ;;
        5 )
            font2="\e[35m"
            font2_color=purple ;;
        6 )
            font2=$"\e[30m"
            font2_color=black ;;
        * )
        echo Something is wrong
    esac
}

myprint_report() {
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

myprint_colortheme() {
    if [[ -n $back1_flag ]]
    then
        echo "Column 1 background = default (purple)"
    else
        echo "Column 1 background =  $column1_background ($back1_color)"
    fi

    if [[ -n $font1_flag ]]
    then
        echo "Column 1 font color = default (white)"
    else
        echo "Column 1 font color = $column1_font_color ($font1_color)"
    fi

    if [[ -n $back2_flag ]]
    then
        echo "Column 2 background = default (green)"
    else
        echo "Column 2 background = $column2_background ($back2_color)"
    fi

    if [[ -n $font2_flag ]]
    then
        echo "Column 2 font color = default (black)"
    else
        echo "Column 2 font color = $column2_font_color ($font2_color)"
    fi
}