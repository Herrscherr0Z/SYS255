#!/usr/bin/bash

: '
# Parse the threatintell file and extract IPs
if [[ -f "access.log" ]];
then 

        read -p "File exists. Do you want to delete it? [y|n] " deleteOrNote

        if [[ "${deleteOrNot}" == 'y' ]];
        then

                rm -f "access.log"
                wget https://nowire.champlain.edu/sys320-file/access.log

        else

                wget https://nowire.champlain.edu/sys320-file/access.log

        fi


fi
'
# Parse the IP address
toDrop=$(egrep -o "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/[0-9]{1,3}" access.log | sort -u)

saveFile='iptables-output.rules'

if [[ -f "${saveFile}" ]]; then

        rm -f ${saveFile}

fi
# Flush the IPTabes ruleset
iptables -F

# Create a for loop to put the IPs into iptables format.
for eachIP in ${toDrop}; do 

        echo "iptables -A INPUT -s ${eachIP} -j DROP" >> ${saveFile}
        echo "iptables -A OUTPUT -d ${eachIP} -j DROP" >> ${saveFile}

done

# Load The Rules
bash ${saveFile}
