#!/bin/bash

function usage() {

echo """
Enter the disks to partition at the prompt with space as delimiter, Example: sdb sdc sdd sdf
The disks provided will be partitoned with a single partion of 90% in GPT
"""

}
usage

read -p "Enter the disks to partition: "  disks

if [ -z "$disks" ]
then

 echo "No disks specified !!!!"
 usage
 exit 1

fi

function command_exist {
  command -v "$@" > /dev/null 2>&1
}

for i in "parted lsb-release" 
   if ! command_exist $i; then
     apt-get install $i -y
   fi


for i in $disks
do
 parted -s /dev/$i mklabel gpt
 parted -s -a optimal /dev/$i mkpart primary 2048s 90%
 echo "Partitioning /dev/"$i "completed"
done
