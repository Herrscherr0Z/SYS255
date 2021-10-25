# Storyline: Review the Security Event Log

# Directory to save files

$myDir = "C:\Users\joshua.leonmejia-adm\Desktop\"

# list all the available Windows Event Logs
Get-Eventlog -list

# Create a prompt to allow user to select the log to view
$readLog = Read-host -Prompt "Please select a log to review from the list above."

# String Search Process Prompt
$Sprompt = Read-Host -Prompt "Enter string to search."

# Print the results for the log
Get-EventLog -LogName $readLog -Newest 40 | Export-Csv -NoTypeInformation -Path "$myDir\securityLogs.csv"

# | where {$_.Message -ilike "*$Sprompt*"}  | for some reason whenever I used this line of code it didnt output the file correctly for me and would output nothing into it
# when I removed it everyhting worked as intended, I would like some more assistance on this since codeing isnt my strongest area 

# Task: Create a prompt that allows the user to specify a keyword or phrase to search on.
# Find a string from your event logs to search on

