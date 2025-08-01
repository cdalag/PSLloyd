Set-Location $HOME
#wt pwsh -noexit -file "C:\Users\Christopher Dalag\mine_flux.ps1"
$x = 0
while (1)
{
   start-process "C:\Users\Christopher Dalag\AppData\Local\Microsoft\WindowsApps\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\wt.exe" -argumentlist "pwsh -file mine_flux.ps1" -wait
   $x++
   Start-Sleep -Seconds 5
   write-host "Retry #$x"
}
