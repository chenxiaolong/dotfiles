[CmdletBinding()]
param (
    [Parameter(Mandatory=$true, Position=0)]
    [string]$cmd
)

$ErrorActionPreference = "Stop"

Set-Location (Split-Path $MyInvocation.MyCommand.Path)

Get-Content extensions.txt | ForEach-Object {
    & $cmd --install-extension $_
}
