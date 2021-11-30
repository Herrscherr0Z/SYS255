#!

# Script to parse an Apache Log file

# 81.19.44.12 - - [30/Sep/2018:06:26:55 -0500] "GET /console HTTP/1.1" 404 444 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:5
7.0) Gecko/20100101 Firefox/57.0"

# Create a prompt that requests the location of the file
read -p "Please enter the apache log file name: " APACHE_LOG

# Remove the left bracket and the double quotes
sed -e "s/\[//g" -e "s/\"//g" ${APACHE_LOG} | \
egrep -i "test|shell|echo|passwd|select|phpmyadmin|setup|admin" | \
awk ' BEGIN { format = "%-15s %-20s %-7s %-6s %-10s %s\n"
       printf format, "IP", "Date", "Method", "Status", "Size", "URI"
       printf format, "--", "---", "------", "------", "----", "------"  }
        { printf format, $1, $4, $6, $9, $10, $7 }

'
