#! /usr/bin/bash

Swap(){
    tmp=$a
    a=$b
    b=$tmp
}
# Dump Logical_Name from lsblk to the array logiName[]:
logiName=(`lsblk -S | sed -e '1d' | awk '{ print $1 }'`)
# Dump SCSI_Bus_Number from lsblk to the array infoBus[]:
infoBus=(`lsblk -S | sed -e '1d' | awk '{ print $2 }'`)
# Get the length of the array infoBus[] and record it as numDisk:
numDisk=${#infoBus[*]}

# Empty slotmap.txt file.
cat /dev/null > slotmap.txt
# 
for (( i=0; i < numDisk; i++))
do
    numSlot[$i]=`dmesg | grep "${infoBus[$i]}" | egrep -o "slot\(.+\)" | cut -c6- | sed 's/)//'`
    echo "${numSlot[$i]},${infoBus[$i]},${logiName[$i]}" >> slotmap.txt
    if (( i<numDisk-1 ))
    then
        for (( j=0; j<numDisk-i-1; j++ ))
        do
            if (( numSlot[j] > numSlot[j+1] ))
            then
                tmp1=${numSlot[j]}
                tmp2=${logiName[j]}
                tmp3=${infoBus[j]}
                numSlot[j]=${numSlot[j+1]}
                logiName[j]=${logiName[j+1]}
                infoBus[j]=${infoBus[j+1]}
                numSlot[j+1]=$tmp1
                logiName[j+1]=$tmp2
                infoBus[j+1]=$tmp3
            fi
        done
    fi
done
