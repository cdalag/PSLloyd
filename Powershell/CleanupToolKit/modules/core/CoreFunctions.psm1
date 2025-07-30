# CoreFunctions.psm1
# Module: CoreFunctions
# Description: Core utility functions for CleanupToolKit

# Exported Functions
Export-ModuleMember -Function Get-Example, Set-Example

function Get-Example {
    <#
    .SYNOPSIS
        Example function to get information.
    .DESCRIPTION
        This is a placeholder function for demonstration.
    .EXAMPLE
        Get-Example
    #>
    [CmdletBinding()]
    param()
    Write-Output "This is an example function."
}

function Set-Example {
    <#
    .SYNOPSIS
        Example function to set information.
    .DESCRIPTION
        This is a placeholder function for demonstration.
    .EXAMPLE
        Set-Example -Value "Test"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Value
    )
    Write-Output "You set the value to: $Value"
}