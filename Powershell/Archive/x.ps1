
$Objshell = New-Object -COMObject "Shell.Application"
add-type -AssemblyName System.Windows.Forms
Start-Sleep -Milliseconds 250

while (1) {
    $Objshell.ShellExecute("C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe")
    #$Objshell.AppActivate("brave")
    Start-Sleep 2
        for ($i = 0; $i -lt 10; $i++) {
            for ($j = 0; $j -lt 10; $j++) {
                [System.Windows.Forms.SendKeys]::SendWait("{F5}")
                #$Objshell.SendKeys("{F5}")
                
                Start-Sleep -Milliseconds 200
                Write-Host "$j" -NoNewline
            }
            Start-Sleep -Seconds 3
            Write-Host "Refresh: $i" -ForegroundColor Cyan 
        }
        Stop-Process -Name brave
    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~SLEEPING~~~~~~~~~~~~~~~~~~~~~~~~~" -BackgroundColor Yellow 
    Start-Sleep -Seconds 4000
}
