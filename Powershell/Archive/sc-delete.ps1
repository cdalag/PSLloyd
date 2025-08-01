# SC is a command line program used for communicating with the Service Control Manager and services.
$collection = Get-Service | Format-List -Property Name, DisplayName
# if ($collection.Name() = ) {
    <# Action to perform if the condition is true #>
# }
#$currentItemName = Get-Service -Name $(Read-Host -Prompt "What's the service name you want to delete?")