#!/usr/bin/bash

: '
# Parse the threatintell file and extract IPs
if [[ -f "emerging-drop.suricata.rules" ]];
then 

	read -p "File exists. Do you want to delete it? [y|n] " deleteOrNote
	
	if [[ "${deleteOrNot}" == 'y' ]];
	then

		rm -f "emerging-drop.suricata.rules"
		wget http://rules.emergingthreats.net/blockrules/emerging-drop.suricata.rules

	else

		wget http://rules.emergingthreats.net/blockrules/emerging-drop.suricata.rules

	fi
	

fi
'
# Parse the IP address
toDrop=$(egrep -o "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/[0-9]{1,2}" emerging-drop.suricata.rules | sort -u)

saveFile='iptables-spamhaus.rules'

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


