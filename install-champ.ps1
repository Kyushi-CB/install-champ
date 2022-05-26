############################## SETUP THE SCRIPT ##############################
echo "Install Champ-Script v.1.0 by Jack Höhndorf | https://github.com/Kyushi-CB"

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
$mainDir = "$env:SystemDrive\packages\.!Drivers\"

#Set in which order sub-directorys should be accessed.
$dirOrder = @(
    "chipset",
    "audio",
    "network",
    "display",
    "misc",
    "ds",
    "bios" 
)

#Set Wildcards, which file format should be executed.
$wildcards = 
    ".exe",
    ".msi"



##############################################################################
                    


#Iterate through ordered dirs defined in "$dirOrder" Array.
for ($i=0; $i -lt $dirOrder.length; $i++) {

    #set/reset app-index for current iterated folder 
    $appIndex=0

    # get all files with extensions defined in "$wildcards" from selected folder, pass it to foreach method
    Get-ChildItem ($mainDir + $dirOrder[$i] + "\") -Recurse | where {$_.extension -in $wildcards} | 
    ForEach-Object {
        #increase on each iteration
        $appIndex++

        #pass path + index number from current item as string to clipboard
        Set-Clipboard -Value ($_.DirectoryName + "\" + $appIndex)
 
        #execute selected application, wait until the process is finshed
        Start-Process $_.FullName -wait
    }
}
