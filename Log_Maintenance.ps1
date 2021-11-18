#Range used to determine how many days logs we store

$dateSaveRange = (Get-Date).AddDays(-5)            
$logName = (Get-Date -uformat "x_%Y%m%d") + ".zip"
$logPath = "C:"
$directory = "C:"
$transferDirectory = "C:"

#Navigate to Tableau Bin directory
cd $directory

#Creating logs
ECHO ".....CREATING LOGS....."
.\tsm maintenance ziplogs -d -mi -t -m (Get-Date).AddDays(0).ToString('MM/dd/yyyy') -f $logName

#Copy and transfer Backup file
ECHO "--------TRANSFERRING FILE--------"
Move-Item -path $logPath\$logName -destination $transferDirectory

#deletes files older than x days
ECHO ".....DELETING OLD LOGS....."
Get-ChildItem $transferDirectory -file tablogs_* -Recurse | Where-Object {($_.LastWriteTime -lt $dateSaveRange)} | Remove-Item

#deletes log files located on local drive (E:)
#ECHO "---------DELETING LOCAL LOG FILE--------"
#Remove-Item -path $logPath\$logName

Exit