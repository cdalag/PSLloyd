$OriginalPath = Read-Host -Prompt "Enter directory of the audio files"
if ($OriginalPath.StartsWith('"') -or $OriginalPath.EndsWith('"')) {
  $OriginalPath = $OriginalPath.Trim('"')
}
if ($OriginalPath.EndsWith('\')) {
  $OriginalPath = $OriginalPath.TrimEnd('\')
}


Write-Host $OriginalPath
Read-Host -Prompt "PRESS ENTER TO CONTINUE"

$ConvertTo = Read-Host -Prompt "Enter new frequency rate in kHz"
# while (-not ($ConvertTo -le 24 -or $ConvertTo -ge 192)) {
#   Write-Output $ConvertTo
#   "Enter the value 24, 32, 44.1, 48, 96, or 192"
#   $ConvertTo = Read-Host -Prompt "Enter new frequency rate in kHz"
# }

$ValidRates = @(24, 32, 44.1, 48, 96, 192)

while ($ValidRates -notcontains $ConvertTo) {
    Write-Output $ConvertTo
    "Enter the value 24, 32, 44.1, 48, 96, or 192"
    $ConvertTo = Read-Host -Prompt "Enter new frequency rate in kHz"
}

$PathAfterConversion = "$OriginalPath" + " $ConvertTo" + "kHz\"
if ($PathAfterConversion.StartsWith(" ") -or $PathAfterConversion.EndsWith(" ")) {
  $PathAfterConversion = $PathAfterConversion.Trim(" ")
}
Write-Host $PathAfterConversion
Read-Host -Prompt "PRESS ENTER TO CONTINUE"

[uint32]$ConvertTo = [uint32]$ConvertTo*1000

function ConvertAudioFrequency {
  foreach ($item in $(Get-Childitem -Path $OriginalPath)) {
    if ($item.Extension -eq ".flac") {
      ffmpeg -i $item -ar $ConvertTo (($PathAfterConversion + $item.Name.Insert($item.BaseName.Length, " $($ConvertTo/1000)" + "kHz"))) #" 96kHz" #optimize this line
      Write-Host $($PathAfterConversion + $item.Name.Insert($item.BaseName.Length, " $($ConvertTo/1000)" + "kHz")) #optimize this line
      Write-Host $item.DirectoryName
      # Read-Host -Prompt "PRESS ENTER TO CONTINUE"
	  }
  }
}

function CreateNewFolder {
  New-Item -Path $PathAfterConversion -ItemType Directory
}

if (-not (Test-Path -Path $PathAfterConversion)) {
  CreateNewFolder
}
ConvertAudioFrequency

<#
  # $OriginalPath = Read-Host -Prompt "Enter directory of the audio files"
  # if ($OriginalPath.StartsWith('"')) {$OriginalPath = $OriginalPath.Split('"')}

  # Write-Host $OriginalPath -BackgroundColor Green -ForegroundColor Red
  # Read-Host -Prompt "PRESS ENTER TO CONTINUE"

  # $ConvertTo = Read-Host -Prompt "Enter new frequency rate in kHz"
  # while (-not ($ConvertTo -ge 24 -and $ConvertTo -le 96)) {
  #   "Enter the value 24, 32, 44.1, 48, or 96"
  #   $ConvertTo = Read-Host -Prompt "Enter new frequency rate in kHz"}


  # $PathAfterConversion = $OriginalPath + $ConvertTo + "kHz"
  # Write-Host $PathAfterConversion -BackgroundColor Green -ForegroundColor Red
  # Read-Host -Prompt "PRESS ENTER TO CONTINUE"

  # $ConvertTo = [int]$ConvertTo*1000

  # function ConvertAudioFrequency {
  #   foreach ($item in $(Get-Childitem -Path $OriginalPath)) {
  #       if ($item.Extension -eq ".flac") {
  #           ffmpeg -i $item -ar $ConvertTo (($PathAfterConversion + $item.Name.Insert($item.BaseName.Length, ' 96kHz')))
  #           Write-Host $item.DirectoryName -BackgroundColor Green -ForegroundColor Red
  #           Read-Host -Prompt "PRESS ENTER TO CONTINUE"
  #       }
  #   }
  # }

  # function CreateNewFolder {New-Item -Path $PathAfterConversion -ItemType Directory}
  # if (-not (Test-Path -Path $PathAfterConversion)) {CreateNewFolder}
  # ConvertAudioFrequency
#>

<#
  ##### FROM COPILOT ######
  # $OriginalPath = Read-Host -Prompt "Enter directory of the audio files"
  # if ($OriginalPath -match '^"') { $OriginalPath = $OriginalPath -replace '"', '' }

  # Write-Host $OriginalPath -BackgroundColor Green -ForegroundColor Red
  # Read-Host -Prompt "PRESS ENTER TO CONTINUE"

  # # Validate frequency input
  # do {
  #     $ConvertTo = Read-Host -Prompt "Enter new frequency rate in kHz"
  #     if ($ConvertTo -in @(24, 32, 44.1, 48, 96)) { break }
  #     Write-Output "Enter a valid value: 24, 32, 44.1, 48, or 96"
  # } while ($true)

  # $PathAfterConversion = "$OriginalPath\$ConvertTo kHz\"
  # Write-Host $PathAfterConversion -BackgroundColor Green -ForegroundColor Red
  # Read-Host -Prompt "PRESS ENTER TO CONTINUE"

  # $ConvertTo = [int]$ConvertTo * 1000

  # function ConvertAudioFrequency {
  #     foreach ($item in Get-ChildItem -Path $OriginalPath -Filter "*.flac") {
  #         $newFileName = "$($item.BaseName) $ConvertTo kHz$($item.Extension)"
  #         $newFilePath = Join-Path -Path $PathAfterConversion -ChildPath $newFileName

  #         ffmpeg -i "$($item.FullName)" -ar $ConvertTo "$newFilePath"

  #         Write-Host "Converted: $newFilePath" -BackgroundColor Green -ForegroundColor Red
  #         Read-Host -Prompt "PRESS ENTER TO CONTINUE"
  #     }
  # }

  # function CreateNewFolder {
  #     if (-not (Test-Path -Path $PathAfterConversion)) {
  #         New-Item -Path $PathAfterConversion -ItemType Directory | Out-Null
  #     }
  # }

  # CreateNewFolder
  # ConvertAudioFrequency
#>