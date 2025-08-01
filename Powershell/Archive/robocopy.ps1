
$fileName = Read-Host -Prompt "Input the file name, including it's extension (eg. movie.mkv)";   #$args[0] 
$fromDir  = Read-Host -Prompt "Copy and paste from directory source (eg. C:\videos)" #$args[1]
$toDir    = Read-Host -Prompt "Copy and paste directory destination (eg. Z:\external_drive\videos)" #$args[2]
$title = $fileName
$item = get-item "$fromDir\$fileName"
$time = 0
$fileSize = $item.length/1024/1024 #Bytes -> MegaBytes
$stopWatch = New-Object -TypeName System.Diagnostics.Stopwatch
$stopWatch.reset()
$stopWatch.start()

robocopy $fromDir "$toDir" "$fileName" /log:C:\Users\'Christopher Dalag'\File_TX_Log.txt /V /BYTES /tee /MT:32 | ForEach-Object{
	$data = $_.Split("`t")

	if ($title -and $data[0] -match '\d+(?=%)') {
		$progressSize = [math]::round($filesize*$matches[0]*0.01, 2)
		$processed = [math]::round($filesize*$matches[0]*0.00001, 2)
		$percent = $matches[0]
		$time = $stopWatch.elapsedmilliseconds*0.001
		$transferRate = [math]::round($progressSize/$time, 2)
		Write-Progress $title -Status "$processed GB: $transferRate MB/s $percent%" -PercentComplete $matches[0]
	}
	
	if($data[4]) {$title = $data[4]}

}
$stopWatch.stop()
Write-Progress $title -complete