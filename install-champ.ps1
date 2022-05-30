############################## SCRIPT SETUP #############################################
echo "Install Champ Script v.1.0 by Jack Hoehndorf | https://github.com/Kyushi-CB"

sleep 1                            

Write-Host
 
@"
How it works:
    Be sure your directory structure looks like the following example,
    otherwise it won't work as expected:

                             maindir
                                |
                                |
      _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
     |                       |                |                |
     |                       |                |                |
install-champ.ps1          folder1          folder2          folder3
                             |                |                |
                             |                |                |
                        installer.exe    installer.exe    installer.exe"



"@

pause

#Set the work directory where the script should be executed.
$mainDir = "$env:SystemDrive\packages\!Drivers\"

#Set in which order sub-directorys should be accessed.
$dirOrder = @(
    "Chipset",
    "Audio",
    "Input",
    "Memory",
    "Misc",
    "Network",
    "Video",
    "DS",
    "BIOS" 
)

#Set wildcards for which file formats to run.
$wildcards = 
    ".exe"
    



##############################################################################

#Iterates through ordered directorys defined in "$dirOrder" Array.

for ($i=0; $i -lt $dirOrder.length; $i++) {

    #set/reset app-index for current iterated folder. 
    $appIndex=0

    #get all files with extensions defined in "$wildcards" from selected folder, pass it to foreach method.
    Get-ChildItem ($mainDir + $dirOrder[$i] + "\") | where {$_.extension -in $wildcards} | 
    ForEach-Object {

        #increase on each iteration.
        $appIndex++

        #pass path + index number from current item as string to clipboard
        Set-Clipboard -Value ($_.DirectoryName + "\" + $appIndex)
 
        #execute selected application, wait until the process is finshed
        Write-Host $_.FullName "wird jetzt installiert..."
        Try {
            Start-Process $_.FullName -wait
        }
        Catch
        {
            Write-Host "Die Aktion wurde vom Benutzer abgebrochen!" $_.FullName "wird übersprungen."
        }

        #loop starts again after confirming until all items in the current directory are executed
        Write-Host ">> done"
        #pause
    }
}

Write-Host "Alle Programme im angegebenen Verzeichnis wurden ausgeführt. Nothing to do here!"

sleep 5

return
