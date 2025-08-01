$Url = Read-Host -Prompt "Paste URL address of file "
$ZipFile = 'C:\Users\Christopher Dalag\Downloads\' + $(Split-Path -Path $Url -Leaf) 
$Destination= 'C:\Users\Christopher Dalag\Downloads\' 
 
Invoke-WebRequest -Uri $Url -OutFile $ZipFile 
 
$ExtractShell = New-Object -ComObject Shell.Application 
$Files = $ExtractShell.Namespace($ZipFile).Items() 
$ExtractShell.NameSpace($Destination).CopyHere($Files)
Start-Process $Destination

# [System.Windows.Forms.SendKeys]::SendWait("{F5}")
[System.Windows.Forms.SendKeys]::SendWait("{F5}")