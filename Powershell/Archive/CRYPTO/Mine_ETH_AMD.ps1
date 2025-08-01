set GPU_MAX_ALLOC_PERCENT=100
set GPU_SINGLE_ALLOC_PERCENT=100
set GPU_MAX_HEAP_SIZE=100
set GPU_USE_SYNC_OBJECTS=1

#$miner_location = "C:\Users\Christopher Dalag\PhoenixMiner_5.7b_Windows"
$miner_location = "C:\Users\Christopher Dalag\teamredminer-v0.8.4-win"
Set-Location -Path $miner_location


#./PhoenixMiner.exe -pool us1.ethermine.org:4444 -wal 0x9b2E1e038Ac345C7d8B71cBC42CA8dfE1648dCad -pass x -worker PcTotoy_Rig1 -coin eth -amd -mi 14 -clkernel 0

./teamredminer.exe -a ethash --enable_compute -o stratum+tcp://us1.ethermine.org:4444 -u 0x9b2E1e038Ac345C7d8B71cBC42CA8dfE1648dCad.PcTotoy_Rig1 -p x --eth_config=A572 --eth_no_4gb_kernels