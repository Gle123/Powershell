#*****CHANGE LOG*************************************************************************
#05-26-2022 changed tableauinstalldirectory to 
#11-03-2021 changed tableauinstalldirectory to E:\Tableau Server\packages\bin.20204.21.0511.0936\
#11-13-2020 changed to 20203.20.1018.2303
#05-12-2020 changed installdirectory from 20194.19.1211.1636 to 20201.20.0326.1623
#01-30-2019 by Andrea Hardy - Changed path of install directory to \bin.20194.19.1211.1636"
#Sept  2019 by Andrea Hardy - Script to export data from the workbook view 'CreditKarma' to a csv file on X\Marketing/MRC
#Changed/updated the install directory path from bin.20191.19.0612.2121 to bin.20192.19.0818.2120
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

#Starting a tabcmd session - logging into the server
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
