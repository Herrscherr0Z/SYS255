#!/bin/bash

# Script to parse file
read -p "Enter the password file name:" PASSWORD

awk -F : ' BEGIN { format = "%-19s %-9s %-9s %-9s %-75s %-30s %s\n"
        printf format, "Username", "Unused", "User ID", "Group ID", "Comment", "Home Directory", "Default Shell"
        printf format, "--------", "------", "-------", "--------", "-------", "--------------", "-------------" }
      { printf format, $1, $2, $3, $4, $5, $6, $7 }
' ${PASSWORD}
