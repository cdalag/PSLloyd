Set-Location $HOME
$x = 0
while (1)
{
   sudo start-process "C:\Users\Christopher Dalag\AppData\Local\Microsoft\WindowsApps\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\wt.exe" -argumentlist "pwsh -file Mine_ETH_AMD.ps1" -wait
   $x++
   Start-Sleep -Seconds 5
   write-host "Retry #$x"
}