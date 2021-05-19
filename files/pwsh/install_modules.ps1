[CmdletBinding()]
param ()

$ErrorActionPreference = "Stop"

$extensions = @(
    'DirColors',
    'NtObjectManager',
    'posh-git',
    'PSFzf',
    'PSReadline',
    'SpeculationControl'
)

Install-Module -Scope CurrentUser $extensions
