# $syncHash = [hashtable]::Synchronized(@{ 
#     Browser = $null
#     Window = $null
#  })

# $psCmd = [powershell]::Create()
# $newRunspace = [RunspaceFactory]::CreateRunspace()
# $newRunspace.Open()

# $newRunspace.SessionStateProxy.SetVariable('syncHash',  $syncHash)
# $psCmd.Runspace = $newRunspace

# $sb = {
# $c= 0
# while ($true) {
# Start-Sleep -Seconds 10
# $c++

# if ($c % 2) {
#     $syncHash.Window.Dispatcher.invoke([action] {
#     try {
#         $syncHash.Window.Title = "google"
#         $syncHash.Browser.Navigate('http://www.google.com') 
#         $syncHash.Window.InvalidateVisual()
#         } catch {}
#     })
# }
# else {
#     $syncHash.Window.Dispatcher.invoke([action] {
#     try {
#         $syncHash.Window.Title = "bing"
#         $syncHash.Browser.Navigate('http://www.bing.com') 
#         $syncHash.Window.InvalidateVisual()
#     } catch {}
#     })
# }
# }
# }

# $psCmd.AddScript($sb)
# $psCmd.BeginInvoke()

# [void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
# [xml]$xaml = @'
# <Window
# xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
# xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
# Title="PowerShell HTML GUI" WindowStartupLocation="Manual">
# <Grid>
# <WebBrowser
#     HorizontalAlignment="Left"
#     Width="415"
#     Height="340"
#     Margin="10,10,0,0"
#     VerticalAlignment="Top"
#     Name="WebBrowser"
# />
# </Grid>
# </Window>
# '@
# $reader = New-Object System.Xml.XmlNodeReader($xaml)
# $Form = [Windows.Markup.XamlReader]::Load($reader)
# $Form.Width = 415
# $Form.Height = 340
# $Form.Topmost = $True
# $WebBrowser = $Form.FindName('WebBrowser')
# $WebBrowser.add_Loaded({$this.Navigate('http://www.bing.com')})
# $syncHash.Window = $Form
# $syncHash.Browser = $WebBrowser
# $Form.ShowDialog()
# $psCmd.Stop()

$Objshell = New-Object -COMObject "Shell.Application"
add-type -AssemblyName System.Windows.Forms
Start-Sleep -Milliseconds 250

while (1) {
    $objshell.ShellExecute("C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe")
    Start-Sleep 2
        for ($i = 0; $i -lt 10; $i++) {
            for ($j = 0; $j -lt 10; $j++) {
                [System.Windows.Forms.SendKeys]::SendWait("{F5}")
             
                
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