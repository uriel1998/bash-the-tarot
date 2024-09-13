#!/bin/bash
export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
TempDir="${SCRIPT_DIR}/tmp"

Instring="$@" 
selected=$(echo "${Instring}" | awk -F ':' '{print $1}' | awk -F ' ' '{print $2}')
#Command=$(echo "$Instring" | sed 's/ (/./g' | sed 's/)//g' | sed 's/:man:/:man -Pcat:/g' | awk -F ':' '{print $2 " " $1}')
#eval "$Command" 
    if [ "$selected" == "X" ];then 
        echo " This will export your entire reading, with color to "
        echo " ${HOME}/tarot_reading_DATE.txt"
        echo " where the date is formatted YearMonthDay_HourMinSec "
        echo " and then quit. "
    else
        if [ "$selected" == "Q" ];then 
            echo " This will quit and remove the reading."
        else
            selected=$(( selected-1 ))
            cat "${TempDir}"/"${selected}".txt
            read
        fi
    fi
