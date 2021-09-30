# Use the Get-WMIObject cmdlet
# Get-wmiobject -Class win32_service | Select Name, Path, ProcessID

# Get-WmiObject -list | where { $_.Name -ilike "win32_[n-z]*" } | sort-object

# Get-WmiObject -Class win32_account | Get-Member

# Task: Grab the network adapter information using the WMI class
# Get the IP, default gateway, and DNS servers
# BONUS: get the DHCP server
# post code to GitHub

Get-WMIObject -Class Win32_NetworkAdapterConfiguration | select IPAddress, DefaultIPGateway, DNSServerSearchOrder, DHCPServer
