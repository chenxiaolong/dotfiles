#Requires -RunAsAdministrator

[CmdletBinding()]
param ()

$ErrorActionPreference = "Stop"

function New-DotFileSymlink {
    [CmdletBinding()]
    param (
        [string]$source,
        [string]$target
    )

    New-Item `
        -Path (Split-Path $source) `
        -Type Directory `
        -ErrorAction SilentlyContinue `
        | Out-Null

    $absTarget = (Get-Item $target).FullName

    if ($path = Get-Item -Path $source -ErrorAction SilentlyContinue) {
        if ($path.LinkType -ne "SymbolicLink") {
            throw "$($path.FullName): path exists and is not a symlink"
        } elseif ($path.Target -ne $absTarget) {
            throw "$($path.FullName): path exists and is symlinked to $($path.Target)"
        } else {
            Write-Verbose "$($path.FullName): path already correctly linked"
            return
        }
    }

    Write-Verbose "Symlinking $source to $absTarget"
    New-Item `
        -Path $source `
        -ItemType SymbolicLink `
        -Value $absTarget `
        | Out-Null
}

Set-Location (Split-Path $MyInvocation.MyCommand.Path)

# pwsh
New-DotFileSymlink $PROFILE.CurrentUserAllHosts files\pwsh\profile.ps1
@{
    DOTNET_CLI_TELEMETRY_OPTOUT = '1';
    POWERSHELL_TELEMETRY_OPTOUT = '1';
}.GetEnumerator() | ForEach-Object {
    [System.Environment]::SetEnvironmentVariable(
        $_.Name, $_.Value, [System.EnvironmentVariableTarget]::User)
}

# For non-Windows, also use install.sh
if ($PSVersionTable.PSVersion.Major -gt 5 -and !$IsWindows) {
    & ./install.sh
    exit
}

# git
if (Get-Command git -ErrorAction SilentlyContinue) {
    New-DotFileSymlink ~\.gitconfig files\git\gitconfig
    New-DotFileSymlink ~\.gitconfig.delta files\git\gitconfig.delta
    New-DotFileSymlink ~\.gitconfig.platform files\git\gitconfig.windows
}

# gpg
if (Get-Command gpg -ErrorAction SilentlyContinue) {
    New-DotFileSymlink $env:APPDATA\gnupg\gpg-agent.conf files\gnupg\gpg-agent.conf
}

# rg
if (Get-Command rg -ErrorAction SilentlyContinue) {
    New-DotFileSymlink ~\.ripgreprc files\ripgreprc
}

# vim
if (Get-Command vim -ErrorAction SilentlyContinue) {
    New-DotFileSymlink ~\vimfiles files\vim
    New-DotFileSymlink ~\.vimrc files\vim\vimrc
}

# starship
if (Get-Command starship -ErrorAction SilentlyContinue) {
    New-DotFileSymlink ~\.config\starship.toml files\starship.toml
}

# vscode
if (Get-Command code -ErrorAction SilentlyContinue) {
    New-DotFileSymlink $env:APPDATA\Code\User\keybindings.json files\vscode\keybindings.json
    New-DotFileSymlink $env:APPDATA\Code\User\settings.json files\vscode\settings.json
}

# https://github.com/PowerShell/PowerShell/issues/13138
if ($PSVersionTable.PSVersion -ge [version]'7.1') {
    Import-Module Appx -UseWindowsPowerShell
}

# Windows Terminal
(
    'Microsoft.WindowsTerminal',
    'Microsoft.WindowsTerminalPreview'
) | ForEach-Object {
    if ($appx = Get-AppxPackage $_) {
        $localStatePath = "$env:LOCALAPPDATA\Packages\$($appx.Name)_$($appx.PublisherId)\LocalState"
        New-DotFileSymlink $localStatePath\settings.json files\windows_terminal\settings.json
    }
}

# bat
if (Get-Command bat -ErrorAction SilentlyContinue) {
    New-DotFileSymlink (bat --config-dir) files\bat
    bat cache --build
}
