

$i = 0
Set-Location "C:\Program Files\NVIDIA Corporation\NVSMI"
while($i -ne 6){
    Write-Host "~~~~~~GPU $i Overclock Setting~~~~~~"
    $GPU_Param = [ordered]@{
        Core_Clock = (read-host -prompt "Enter core clock");
        Mem_Clock = (read-host -prompt "Enter memory clock");
        Power_Limit = (read-host -prompt "Enter power limit");
        Temp_Limit = (read-host -prompt "Enter temp limit")
    }
    
    $arg = 0
    $NVIDIA_SMI_OP = "sudo ./nvidia-smi --id=$i --lock-gpu-clocks=", "sudo ./nvidia-smi --id=$i --lock-memory-clocks=", "sudo ./nvidia-smi --id=$i --power-limit=", "sudo ./nvidia-smi --id=$i --gpu-target-temp="
    while ($GPU_Param[$arg]){
        invoke-expression ($($NVIDIA_SMI_OP[$arg])+$GPU_Param[$arg])
        $arg++
    }
    # $Core_Clock = (read-host -prompt "Enter core clock")
    # $Mem_Clock = (read-host -prompt "Enter memory clock")
    # $Power_Limit = (read-host -prompt "Enter power limit")
    # $Temp_Limit = (read-host -prompt "Enter temp limit")
    
    # sudo ./nvidia-smi --lock-gpu-clocks=$Core_Clock --id=$i
    # sudo ./nvidia-smi --lock-memory-clocks=$Mem_Clock --id=$i
    # sudo ./nvidia-smi --power-limit=$Power_Limit --id=$i
    # sudo ./nvidia-smi --gpu-target-temp=$Temp_Limit  --id=$i
    $i++
}
Set-Location $home
