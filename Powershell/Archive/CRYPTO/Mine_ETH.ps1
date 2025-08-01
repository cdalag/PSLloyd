#Set-Location miniZ_v1.8y2_win-x64
#Set-Location miniZ_v1.8y4rc1_win-x64
#./miniz.exe --par=ethash --intensity=100 --url=0x9b2e1e038ac345c7d8b71cbc42ca8dfe1648dcad.PcTotoy@eu1.ethermine.org:4444 --latency --extra --gpu-line --show-mode

#Set-Location miniZ_v1.8y3_win-x64
#./miniz.exe --par=ethash --intensity=100 --url=0x9b2e1e038ac345c7d8b71cbc42ca8dfe1648dcad.PcTotoy@us2.ethermine.org:4444  --list-modes --latency --extra --gpu-line --show-mode
$miner_location = "C:\Users\Christopher Dalag\t-rex-0.21.6-win"
Set-Location -Path $miner_location
#./t-rex.exe --algo ethash --coin eth --intensity 25 --kernel 4 --url stratum+tcp://us1.ethermine.org:4444 --user 0x9b2e1e038ac345c7d8b71cbc42ca8dfe1648dcad --worker PcTotoy --api-bind-telnet 0 --api-bind-http 10.0.0.142:20000 --gpu-report-interval 5 --cpu-priority 5 --fan 100 --mclock -502 --lock-cv 660,650,655,665,650,660 --cclock -265,-280,-270,-260,-255,-265

./t-rex.exe --algo ethash --coin eth --intensity 25 --url stratum+tcp://us1.ethermine.org:4444 --user 0x9b2e1e038ac345c7d8b71cbc42ca8dfe1648dcad --worker PcTotoy --api-bind-telnet 0 --api-bind-http 10.0.0.142:20000 --gpu-report-interval 5 --cpu-priority 5



