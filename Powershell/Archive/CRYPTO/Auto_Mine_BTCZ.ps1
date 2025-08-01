Set-Location $HOME
$x = 0
while (1)
{
   start-process "C:\Program Files\WindowsApps\Microsoft.WindowsTerminalPreview_1.10.1933.0_x64__8wekyb3d8bbwe\wt.exe" -argumentlist "pwsh -file Mine_BTCZ.ps1" -wait
   $x++
   Start-Sleep -Seconds 5
   write-host "Retry #$x"
}