# Array of websites containing threat intell
$drop_urls = @('https://rules.emergingthreats.net/blockrules/emerging-botcc.rules','https://rules.emergingthreats.net/blockrules/compromised-ips.txt')


# Loop through the URLs for the rules list
foreach ($u in $drop_urls) {

    # Extract the filename
    $temp = $u.split("/")
    
    # The last element in the array plucked off is the filename
    $file_name = $temp[-1]

    if (Test-Path $file_name) {

        continue

    } else {

        # Download the rules list
        Invoke-WebRequest -Uri $u -OutFile $file_name


    } # close if statement

} # close the foreach loop

# Array containing the filename
$input_paths = @('compromised-ips.txt','.\emerging-botcc.rules')

# Extract the IP addresses
# 108.190.109.107
# 108.191.2.72
$regex_drop = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'

# Append the IP addresses to the temporary IP list
Select-String -Path $input_paths -Pattern $regex_drop | `
ForEach-Object { $_.Matches } | `
ForEach-Object { $_.Value } | Sort-Object | Get-Unique | `
Out-File -FilePath "ips-bad.tmp"

# Get the IP addresses discovered, loop through and replace the behinning of the line with IPtables syntax
# After the IP address, add the remaining IPtables syntax and save the results to a file
# iptables -A INPUT -s 108.191.2.72 IP -j DROP 

$ruleSet = ".\ips-bad.tmp"

$message = read-host -prompt "Enter 0 for IPTables, 1 for Cisco or 2 for Windows Rulesets"

Switch ($message) {
    0 { (Get-Content -Path $ruleSet) | % `
        { $_ -replace "^","iptables -A INPUT -s" -replace "$","-j DROP" } | `
        Out-File -FilePath "iptables.bash" }

        #Cisco Ruleset
        1 { (Get-Content -Path $ruleSet) | % `
        { $_ -replace "^","access-list 1 deny host" -replace "$" } | `
        Out-File -FilePath "cisco.bash" }

        # Windows Ruleset
        2 { (Get-Content -Path $ruleSet) | % `
        { $_ -replace "^","netsh advfirewall add rulename='IPBlock' dir=in interface=any action=block remoteip=" -replace "$","/32"} |`
        Out-File -FilePath "windowsfirewall.bash" }

    }




