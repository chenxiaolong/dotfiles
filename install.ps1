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
    New-DotFileSymlink ~\.gitconfig.urls files\git\gitconfig.urls
    New-DotFileSymlink ~\.gitconfig.platform files\git\gitconfig.windows
}

# gpg
if (Get-Command gpg -ErrorAction SilentlyContinue) {
    New-DotFileSymlink $env:APPDATA\gnupg\gpg-agent.conf files\gnupg\gpg-agent.conf
}

# nvim
if (Get-Command nvim -ErrorAction SilentlyContinue) {
    New-DotFileSymlink $env:LOCALAPPDATA\nvim files\nvim
}

# starship
if (Get-Command starship -ErrorAction SilentlyContinue) {
    New-DotFileSymlink ~\.config\starship.toml files\starship.toml
}

# bat
if (Get-Command bat -ErrorAction SilentlyContinue) {
    New-DotFileSymlink (bat --config-dir) files\bat
    bat cache --build
}

# yt-dlp
if (Get-Command yt-dlp -ErrorAction SilentlyContinue) {
    New-DotFileSymlink $env:APPDATA\yt-dlp\config files\yt-dlp\config
}

# wezterm
if (Get-Command wezterm -ErrorAction SilentlyContinue) {
    New-DotFileSymlink ~\.config\wezterm files\wezterm
}
