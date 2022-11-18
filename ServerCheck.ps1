#Checks server status. If server down restart server and send email. If server up ignore script

#If Tableau Server is not RUNNING, send an email reading Restart Failed and print Server not running
$Status = (tsm status).ToString()

Write-Output "`n`r$($Status)"    
if ($Status -ne 'Status: RUNNING'){
$lookupSMTP = Resolve-DnsName smtp.dnsname.com
$smtpaddr = [string]$lookupSMTP.NameHost
#Send email
Send-MailMessage -SmtpServer $smtpaddr -Port 25 -From "OUTGOINGEMAIL@x.com" -To "INGOING@x.com" -Subject "Server Restart Failed" -Body "Tableau Server is down. Restarting server. Please check status." -UseSsl 
Write-Output "Server is not running. Email sent.`n`r" 
tsm stop
tsm start

#If Tableau Server is RUNNING, ignore script
}else {
Write-Output "`n`r Yay, Server is running.`n`r"  
}
