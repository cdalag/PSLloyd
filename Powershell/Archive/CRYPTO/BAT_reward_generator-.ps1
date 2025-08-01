# $browserPath = "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
# Start-Process -FilePath $browserPath #-WindowStyle Minimized
# start-sleep -Seconds 1
# $wshell = New-Object -ComObject wscript.shell
# $wshell.AppActivate("New Tab - Brave")

# $processName = Get-Process "brave"
# Start-Sleep -Seconds 1
Set-Location
$browser = "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
Start-Process -FilePath $browser
$wshell = New-Object -ComObject wscript.shell
$toggle = $wshell.AppActivate("brave")
$refresh = $wshell.SendKeys("{F5}")
Start-Sleep -Seconds 3
function refresh_loop {
    for ($i = 0; $i -lt 10; $i++) {
        for ($j = 0; $j -lt 5; $j++) {
            $toggle
            $refresh
            Start-Sleep -Milliseconds 100
            Write-Host $j -NoNewline
        }
        Write-Progress -Activity "Loop Farming" -PercentComplete ($i * 10)
        Start-Sleep -Seconds 1
    }
}
while (1) {
    $toggle ? (refresh_loop) : (Write-Host "ERROR")
    sudo Stop-Process -Name "brave"
    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~SLEEPING~~~~~~~~~~~~~~~~~~~~~~~~~" -BackgroundColor Yellow
    $sleep_time = 4000
    $sleep_elapsed = 0
    while ($sleep_elapsed -lt $sleep_time){
        Start-Sleep -Seconds 1
        $sleep_elapsed++
        Write-Progress -Activity "Sleeping" -PercentComplete (($sleep_elapsed/$sleep_time) * 100) -SecondsRemaining ($sleep_time - $sleep_elapsed)
        
    }
}



