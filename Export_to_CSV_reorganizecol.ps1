#*****CHANGE LOG*************************************************************************

#*****End Change Log*********************************************************************

$tableauinstalldirectory = "E:\Tableau Server\packages\bin.x\"
$filename1 = "\\name\of\directory"+".csv"
$filename2 = "\\name\of\directory"+".csv"
$localfilename1 = "\\name\of\directory"+".csv"
$localfilename2 = "\\name\of\directory"+".csv"

#navigate to Tableau Bin directory
cd $tableauinstalldirectory

#Deleting the old files from the directory so that only the newest file is there
ECHO "-------------Removing old files------------"
Remove-Item -path "\\name\of\directory*.csv*"
ECHO "-------------Old files removed-directory empty--------"

#Starting a tabcmd session - logging into the server no cet check
ECHO "=====Starting a Tabcmd session and logging into the server"
.\tabcmd login -s https://url.com -u username -p password --no-certcheck

#Exporting specified workbook views to .csv file no cert check
ECHO "=====Exporting view to .csv file"
.\tabcmd.exe get "views/#.csv" --filename $localfilename1 --no-certcheck
.\tabcmd.exe get "views/#.csv" --filename $localfilename2 --no-certcheck

#Importing/reading the new file name, sorting by column in descending order, then exporting the new sorted file to .CSV 
ECHO "-------------IMPORTING FILE-SORTING by COLUMN-EXPORTING NEW SORTED CSV FILE-------------"
Import-Csv $localfilename1 | SELECT 'COLUMN A', 'COLUMN B', 'COLUMN C', 'COLUMN D', 'COLUMN E'  | Export-Csv -path $filename1 -NoTypeInformation 
Import-Csv $localfilename2 | SELECT 'COLUMN A', 'COLUMN B', 'COLUMN C', 'COLUMN D', 'COLUMN E'  | Export-Csv -path $filename2 -NoTypeInformation 

#Removing .csv from local location
Remove-Item -Path $localfilename1
Remove-Item -Path $localfilename2
 
#End tabcmd sesson - logging out
ECHO "=====Complete. Sessing ending"
.\tabcmd logout

exit
