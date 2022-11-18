#script that deletes tabpy logs
$dateSaveRange = (Get-Date).AddDays(-10)            #10 days
$transferDirectory = "\\fake\directory\here"

#deletes files older than x days
ECHO ".....DELETING OLD LOGS....."
Get-ChildItem $transferDirectory -file *TabPyLogs -Recurse | Where-Object {($_.LastWriteTime -lt $dateSaveRange)} | Remove-Item

Write-Host 'Files cleared and deleted'
