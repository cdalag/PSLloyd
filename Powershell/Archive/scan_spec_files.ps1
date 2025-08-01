

Scanning_Directory = "&{
Read-Host -Prompt 'Paste the directory to scan'
}"
function Scanning_Directory {
    param (
        OptionalParameters
    )
    
}

Set-Location -Path ${$Scanning_Directory}
foreach ($Current_Directory in $Scanning_Directory){
    Set-Location $Current_Directory | Get-ChildItem -
}

#connecting to rig1 shell
Enter-PSSession -ComputerName Rig1 -Credential "Christopher Dalag"