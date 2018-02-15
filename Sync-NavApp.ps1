Set-ExecutionPolicy RemoteSigned
Import-Module 'C:\Program Files\Microsoft Dynamics NAV\110\Service\NavAdminTool.ps1'
#Import-Module 'C:\Program Files (x86)\Microsoft Dynamics NAV\110\RoleTailored Client\Microsoft.Dynamics.Nav.Ide.psm1'
#Import-Module "C:\Program Files (x86)\Microsoft Dynamics NAV\110\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1"
Sync-NAVApp -ServerInstance DynamicsNAV110 -Path '.\D. E. Veloper_SD Seminar_1.0.0.0.app' -Tenant 'Default'
