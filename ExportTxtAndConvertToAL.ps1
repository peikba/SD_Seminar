Set-ExecutionPolicy RemoteSigned
# Import the module for the Export-NAVApplicationObject cmdLet
Import-Module 'C:\Program Files (x86)\Microsoft Dynamics NAV\110\RoleTailored Client\Microsoft.Dynamics.Nav.Ide.psm1' 
# Import the module for the Split-NAVApplicationObjectFile cmdLet
Import-Module 'C:\Program Files (x86)\Microsoft Dynamics NAV\110\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1' 
# Export objects from database
Export-NAVApplicationObject -DatabaseServer 'localhost' -DatabaseName 'Demo Database NAV (11-0)' -Filter 'Type=Page;Id=20..21' -Path 'c:\temp\Al-Conversion\Objects.txt' -Username 'Admin' -Password 'Passw0rd'
# Split the txt file into separate txt files pr object
Split-NAVApplicationObjectFile -Source 'C:\temp\Al-Conversion\*.txt' -Destination 'c:\temp\Al-Conversion\cal'
# Create the .al files
$Command = "C:\Program Files (x86)\Microsoft Dynamics NAV\110\RoleTailored Client\txt2al.exe" 
& $Command --source c:\temp\Al-Conversion\cal --target c:\temp\Al-Conversion\al
# Clean up all text files
Remove-Item c:\temp\Al-Conversion\cal\*.*
Remove-Item c:\temp\Al-Conversion\*.*