# zsh-like autocomplete
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Use emacs edit mode to make ^D, ^A, ^E, etc. work
Set-PSReadlineOption -EditMode Emacs

# Disable the bell
Set-PSReadlineOption -BellStyle None

# Make psreadline command highlighting use theme colors
try { $null = Get-Command concfg -ea stop; concfg tokencolor -n enable } catch { }

# FZF
Remove-Item env:TERM -ErrorAction Ignore
Remove-PSReadlineKeyHandler 'Ctrl+r'
Import-Module PSFzf -ArgumentList 'Ctrl+t','Ctrl+r'

# Git integration
Import-Module posh-git

# Enable colors with ls
Import-Module Get-ChildItemColor

Set-Alias l Get-ChildItemColor -option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -option AllScope

# Set default file encoding to UTF-8 without BOM
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8NoBOM'

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}