#*****CHANGE LOG*************************************************************************

#*****End Change Log*********************************************************************

$tableauinstalldirectory = ""
$filename1 = ""+ (Get-Date -UFormat "%Y-%m-%d") +".csv"
$filename2 = ""+ (Get-Date -UFormat "%Y-%m-%d") +".csv"
$localfilename1 = "C:\Scripts\"+ (Get-Date -UFormat "%Y-%m-%d") +".csv"
$localfilename2 = "C:\Scripts\"+ (Get-Date -UFormat "%Y-%m-%d") +".csv"

#navigate to Tableau Bin directory
cd $tableauinstalldirectory

#Deleting the old files from the directory so that only the newest file is there
ECHO "-------------Removing old files------------"
Remove-Item -path "\\file.csv*"
ECHO "-------------Old files removed-directory empty--------"

#Starting a tabcmd session - logging into the server with no cert check
ECHO "=====Starting a Tabcmd session and logging into the server"
.\tabcmd login -s url -u username -p password --no-certcheck

#Exporting specified workbook views to .csv file
ECHO "=====Exporting x view to .csv file"
.\tabcmd.exe get "views/x.csv" --filename $localfilename1 --no-certcheck
.\tabcmd.exe get "views/x.csv" --filename $localfilename2 --no-certcheck

#Moving .csv's to Network location
Move-Item -Path $localfilename1 -Destination $filename1
Move-Item -Path $localfilename2 -Destination $filename2
 
#End tabcmd sesson - logging out
ECHO "=====Complete. Sessing ending"
.\tabcmd logout

exit
