
Invoke-command {
    Set-Location $HOME
    $wshell = New-Object -ComObject wscript.shell
    $status = ""
    $Brave_Main = "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
    $Brave_Beta = "C:\Program Files\BraveSoftware\Brave-Browser-Beta\Application\brave.exe"
    
    function Start_Brave {
        Clear-Host $$ Start-Sleep -Seconds 1
        Start-Process $Brave_Main
        Start-Sleep -Seconds 3
        #Check_Status
        $status = "ACTIVATING"
        Write-Host -NoNewline $status -BackgroundColor Green -ForegroundColor White
        Start-Sleep -Seconds 1
        for ($i = 0; $i -lt 3; $i++){
            Write-Host -NoNewline '.' -BackgroundColor Green -ForegroundColor White
            Start-Sleep -Milliseconds 500
        }
        Clear-Host
    }
    
<#     [void] __START__AD_SERVICE_($Exe_FilePath) {
        Start-Process $Exe_FilePath
        while (!$wshell.AppActivate) {
            Write-Host -NoNewline "."
            Start-Sleep -Milliseconds 100
        }
    } #>

    function Start_Brave_Beta {
        Clear-Host $$ Start-Sleep -Seconds 1
        Start-Process $Brave_Beta
        Start-Sleep -Seconds 3
        #Check_Status
        $status = "ACTIVATING"
        Write-Host -NoNewline $status -BackgroundColor Green -ForegroundColor White
        Start-Sleep -Seconds 1
        for ($i = 0; $i -lt 3; $i++){
            Write-Host -NoNewline '.' -BackgroundColor Green -ForegroundColor White
            Start-Sleep -Milliseconds 500
        }
        Clear-Host
    }

    function Stop_Brave {
        Clear-Host $$ Start-Sleep -Seconds 1
        $wshell.AppActivate("brave") && $wshell.SendKeys("{TAB}"+"%{F4}")
        Start-Sleep -Seconds 1
        $status = "INACTIVE"
        Write-Host -NoNewline -Object $status -BackgroundColor Red -ForegroundColor White
        Start-Sleep -Seconds 1
        for ($i = 0; $i -lt 3; $i++){
            Write-Host -NoNewline '.' -BackgroundColor Red -ForegroundColor White
            Start-Sleep -Milliseconds 500
        }
        Clear-Host
    }

    function refresh_loop {
        for ($i = 0; $i -lt 10; $i++) {
            Start-Sleep -Seconds 1
            #Check_Status
            if ($i -lt 1) {
                Write-Progress -Activity "Ad-Farmer" -PercentComplete 1 -Status "Loop: $($i + 1)/10"
            }
            else {
                Write-Progress -Activity "Ad-Farmer" -PercentComplete (($i+1) * 10) -Status "Loop: $($i + 1)/10"
            }
            Write-Host -NoNewline
            for ($j = 0; $j -lt 5; $j++) {
            <#     if ($wshell.AppActivate("brave")) {
                    $wshell.SendKeys("{F5}")
                    Start-Sleep -Milliseconds 350
                }
                else {
                    Start-Sleep -Milliseconds 350
                    Check_Status
                } #>
                $wshell.AppActivate("brave") && $wshell.SendKeys("{F5}")
                Start-Sleep -Milliseconds 350
                #Check_Status To-Do
            }
            #Write-Host "Loop:"($i + 1)
        }
        Write-Progress -Activity "Ad-Farmer" -Completed
        Start-Sleep -Seconds 20
        Stop_Brave
    }

    function Sleep_Task {
        Clear-Host
        $sleep_time = 3600
        $sleep_elapsed = 0
        $percent_completed = 0
        while ($sleep_elapsed -lt $sleep_time) {
            Start-Sleep -Seconds 1
            $sleep_elapsed++
            $percent_completed = ($sleep_elapsed / $sleep_time)
            while ($percent_completed -lt 1){
                $percent_completed = ($percent_completed*10)
            }
            Write-Progress -Activity "Regenerate" -PercentComplete $percent_completed -SecondsRemaining ($sleep_time - $sleep_elapsed) 
        }
        Write-Progress -Activity "Regenerate" -Completed
    }

 <#    function Check_Status {
        $count = 0;
        while ($wshell.AppActivate("brave") -ne 1) {
            Start_Brave_Beta
            $wshell.AppActivate("brave") ? ($status = Write-Output "ACTIVE") : ($status = Write-Output "ERROR")
            $count++
            $count -eq 5 ? (New_Instance) : (Start-Sleep -Seconds 60)
            Stop_Brave
        }
        Write-Host -NoNewline "NO ERR..."
        Start-Sleep -Milliseconds 500
        Clear-Host
    } #>

    function New_Instance {
        sudo wt pwsh -noexit -file "C:\Users\Christopher Dalag\custom_scripts\BAT_reward_generator.ps1"
        [Environment]::Exit(1)
    }
    
    while (1) {
        Start_Brave_Beta
        $wshell.AppActivate("brave") ? (refresh_loop) : ($status = Write-Output "ERROR")
        Start-Sleep -Seconds 10
        <# Start_Brave
        $wshell.AppActivate("brave") ? (refresh_loop) : ($status = Write-Output "ERROR")
        Start-Sleep -Seconds 10 #>
        Sleep_Task
        
        
        #__START__AD_SERVICE_ 
        <# if ($status -eq "ERROR") {
            Check_Status
        } #>
    }
}

# $browserPath = "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
# Start-Process -FilePath $browserPath #-WindowStyle Minimized
# start-sleep -Seconds 1
# $wshell = New-Object -ComObject wscript.shell
# $wshell.AppActivate("brave")
# Start-Sleep -Seconds 1

# while (1) {

#         for ($i = 0; $i -lt 10; $i++) {
#             for ($j = 0; $j -lt 5; $j++) {
                
#                 $wshell.SendKeys("{F5}")
#                 Start-Sleep -Milliseconds 100
#                 Write-Host "$j" -NoNewline
#             }
#             Start-Sleep -Seconds 1
#             Write-Host "Refresh: $i" -ForegroundColor Cyan 
#         }
#     Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~SLEEPING~~~~~~~~~~~~~~~~~~~~~~~~~" -BackgroundColor Yellow 
#     Start-Sleep -Seconds 4000
# }



