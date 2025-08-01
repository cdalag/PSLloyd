oh-my-posh init pwsh --config .\OneDrive\.oh-my-posh.omp.json | Invoke-Expression
Set-Alias AudioStuff "C:\Users\CDalag\OneDrive\pwsh_custom_scripts\AudioStuff.ps1"
function AudioConvertMp3 {
    $AllItems = Get-ChildItem -Path (Read-Host -Prompt "Directory Path").Split('"') -Filter "*.mp3"
    foreach ($item in $AllItems) {
        ffmpeg -i $item -aq 0 -ar 96000 -acodec flac $item.FullName.Replace(".mp3"," 96kHz.flac")
    }
}
function Test-NumberParameters {
     [CmdletBinding()]
     param (
         [Parameter(Mandatory = $false)]
         [int16]$Value16 = 1234,

         [Parameter(Mandatory = $false)]
         [int32]$Value32 = 123456789,

         [Parameter(Mandatory = $false)]
         [int64]$Value64 = 1234567890123
     )

     process {
         Write-Output "Received values:"
         Write-Output "  [int16]   = $Value16 (Range: $([int16]::MinValue) to $([int16]::MaxValue))"
         Write-Output "  [int32]   = $Value32 (Range: $([int32]::MinValue) to $([int32]::MaxValue))"
         Write-Output "  [int64]   = $Value64 (Range: $([int64]::MinValue) to $([int64]::MaxValue))"
     }
}
<#function Convert-FlacToWav {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$InputFile,

        [Parameter(Mandatory=$true)]
        [string]$OutputFile
    )

    begin {
        # Check if FFmpeg is installed
        if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
            Write-Error "FFmpeg is not installed or not found in PATH."
            exit
        }
    }

    process {
        # Run FFmpeg command to convert FLAC to WAV
        $ffmpegCommand = "ffmpeg -i `"$InputFile`" -c:a pcm_s24le `"$OutputFile`""
        Write-Output "Executing: $ffmpegCommand"
        Invoke-Expression $ffmpegCommand
    }

    end {
        Write-Output "Conversion completed: $OutputFile"
    }
}#>

function Convert-AudioFile {
    [CmdletBinding()]
    param (
    # FFmpeg Docs| https://ffmpeg.org/documentation.html
    <# FFmpeg| Audio options:
    -aq <quality>       set audio quality (codec-specific)
    -ar[:<stream_spec>] <rate>  set audio sampling rate (in Hz)
    -ac[:<stream_spec>] <channels>  set number of audio channels
    -an                 disable audio
    -acodec <codec>     alias for -c:a (select encoder/decoder for audio streams)
    -ab <bitrate>       alias for -b:a (select bitrate for audio streams)
    -af <filter_graph>  alias for -filter:a (apply filters to audio streams)#>

        # Filepath of the input audio file.
        [Parameter(Mandatory=$true)]
        [string]
        $InputFile,

        # Audio Quality [0-10]. 0 (best), 10 (worst)
        [Parameter(Mandatory=$false)]
        [UInt16]
        $AudioQuality = 0,

        # Audio Rate in kHz. eg 24kHz, 48kHz, 96kHz, etc
        [Parameter(Mandatory=$false)]
        [UInt16]
        $AudioRate = 192,

        # Audio Channels. eg 1 (mono), 2 (stereo), 3, etc
        [Parameter(Mandatory=$false)]
        [UInt16]
        $AudioChannels = 2,

        # Audio Codec. eg flac, mp3, pcm_s24le, etc.
        [Parameter(Mandatory=$false)]
        [string]
        $AudioCodec = "pcm_s24le",

        # Audio Bitrate (opus/aac/etc). eg 256kbps, 320kbps, etc
        [Parameter(Mandatory=$false)]
        [UInt32]
        $AudioBitrate,

        # Audio Filter. eg Volume multiplier, bass frequencies, equalizer, etc
        [Parameter(Mandatory=$false)]
        [string]
        $AudioFilter,

        # Filepath of the output audio file.
        [Parameter(Mandatory=$false)]
        [string]
        $OutputFile
    )

    # Tests and Variables
    begin {
        # Testing if FFmpeg is installed
        if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
            Write-Error "FFmpeg is not installed or not found in PATH ('$'env:PSModulePath -split ";"). Please install FFmpeg first."
            return
        }
        else {
            $AudioCodec

            $AudioExtensions = @{
                "pcm_s24le" = @(".wav")
                "flac" = @(".flac")
                "mp3" = @(".mp3")
            }

            $Codec = $AudioExtensions[$AudioCodec] ?? @("Unknown")

            Write-Output $Codec
            Read-Host -Prompt "Not A Directory"
            Read-Host -Prompt $InputFile
        }

        # Transform $AudioRate to Hz
        [uint32]$AudioRateHz = $AudioRate * 1000

        # Make a new parent directory for the converted audio files
        # if (Test-Path -Path $InputFile -PathType Container) {
        #     $InputFileDir = Get-Item $InputFile.Trim('"')
        #     $NewDirectoryPath = $InputFileDir + " " + $AudioRate + ' kHz\'
        #     $NewDirectoryPath
        # }
        # if (Test-Path -Path $NewDirectoryPath -PathType Container) {
        #     Write-Output -InputObject $NewDirectoryPath
        #     Read-Host -Prompt "New directory PASS"
        #}
    }

    process {
        # $InputFile type. Directory, File, or Multiple files.
        $InputFileObject = Get-Item -Path $InputFile.Trim('"')
        if (Test-Path -Path $InputFileObject -PathType Container) {
            $ParentDir = '"'+$InputFileObject+" "+ $AudioRate +'kHz"'
            if (-not (Test-Path -Path $ParentDir -PathType Container)) {
                New-Item -Path $ParentDir.Trim('"') -ItemType Directory
                Read-Host -Prompt $ParentDir
            }
            foreach ($AudioFile in $(Get-ChildItem -Path $InputFileObject)) {
                Read-Host -Prompt $AudioFile
                $InputAudioFile = '"' + $AudioFile + '"'
                Read-Host -Prompt $InputAudioFile
                $OutputFile = '"' + $AudioFile.DirectoryName + " " + $AudioRate +"kHz\" + $AudioFile.BaseName + " " + $AudioRate + "kHz" + $Codec + '"'
                Read-Host -Prompt $OutputFile
                $FFmpegCommand = "ffmpeg -i $InputAudioFile -aq $AudioQuality -ar $AudioRateHz -acodec $AudioCodec $OutputFile"
                Invoke-Expression $FFmpegCommand
            }
        }
        # else {
        #     $AudioFile = Get-Item -LiteralPath $InputFile.Trim('"')
        #     Read-Host -Prompt $AudioFile.FullName
        #     New-Item -Path ($AudioFile.DirectoryName.Trim('"') + " " + $AudioRate +"kHz") -ItemType Directory -Verbose
        #     $OutputFile = '"' + $AudioFile.DirectoryName + " " + $AudioRate +"kHz\" + $AudioFile.BaseName + " " + $AudioRate + "kHz" + $Codec + '"'
        #     Read-Host -Prompt $OutputFile
        #     $FFmpegCommand = "ffmpeg -i $InputFile -aq $AudioQuality -ar $AudioRateHz -ac $AudioChannels -acodec $AudioCodec -ab $AudioBitrate $OutputFile"
        #     Read-Host -Prompt $FFmpegCommand
        # Invoke-Expression $FFmpegCommand
        # }


    }

    end {
        Write-Output "Conversion complete: $OutputFile"
    }
}

function Read-FilePropertyDetails {
    $FilePath = Read-Host -Prompt "Enter FilePath"
    $FilePath = $FilePath.Trim('"')
    $Shell = New-Object -ComObject shell.application -Verbose
    $Folder = $Shell.Namespace((Get-Item $FilePath).DirectoryName)
    $File = $Folder.ParseName((Get-Item $FilePath).Name)
    $i = 0
    $fileDetails = New-Item -Path $HOME\FilePropertyDetails.txt -Force -Verbose
    $fileLength = (get-item $filepath).length/512
    while($i -lt $fileLength){
        $FolderDetails = $Folder.GetDetailsOf($Folder.Items, $i)
        $FolderItems = $Folder.GetDetailsOf($File, $i)
        $thisoutput = $($FolderDetails + ": " + $FolderItems)
        Write-Progress -Activity "READING FILE PROPERTY DETAILS" -PercentComplete (($i/$fileLength)*100)
        if ($FolderDetails -and $FolderItems){
            Write-Host -ForegroundColor Green -Object $thisoutput
            $thisoutput >> $fileDetails
        }else{
            if ($FolderDetails -or $FolderItems) {
                Write-Host -ForegroundColor Red -Object $thisoutput
            }
        }
        ++$i
    }
    Write-Host
    Get-Content -Path $fileDetails
}
