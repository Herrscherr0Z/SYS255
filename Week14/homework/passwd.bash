#!/bin/bash

# Script to parse file
read -p "Enter the password file name:" PASSWORD

awk -F: ' BEGIN { format = "%-18s %-9s %-9s %-65s %s\n"
        printf format, "Username", "User ID", "Group ID", "Home Directory", "Default Shell"
        printf format, "--------", "-------", "--------", "--------------", "-------------" }
      { printf format, $1, $3, $4, $5, $6  }
' ${PASSWORD}
