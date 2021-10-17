# Create an array of IPs
$to_ping = @('10.0.5.2','10.0.5.3','10.0.5.4','10.0.5.5','10.0.5.6')

# Loop through the array
foreach ($ip in $to_ping) {

    # Ping each host
    $the_ping = Test-Connection -ComputerName $ip -quiet -Count 1

    # Check the status of the ping for each host
    if ($the_ping) {
    
        # Host is up
        write-host -BackgroundColor Green -ForegroundColor white "$ip is up."
    
    } else {

        # Output the results if it is down to a file
        echo "$ip is down." | Out-File -Append -FilePath ".\host-down.txt"
        
    }

}

# Check whether to send an email ONLY if host-down.txt exist.
if (Test-Path ".\host-down.txt") {

    # Send an email with the host-down.txt attachment.
    Send-MailMessage -From "noreply@joshua.local" -To "joshua@joshua.local" `
    -Subject "Host Report." -Body "Attached report forhosts that are down." `
    -Attachments ".\host-down.txt" -SmtpServer mail01.joshua.local

    if ($?) {
        echo "Email Sent \(0u0\)"

    } else {
        echo "Error: Email not sent!"

    }

    # Delete host-down.txt

    Remove-item ".\host-down.txt"

} # End of test-path