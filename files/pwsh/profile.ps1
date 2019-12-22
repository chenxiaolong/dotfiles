# zsh-like autocomplete
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Use emacs edit mode to make ^D, ^A, ^E, etc. work
Set-PSReadlineOption -EditMode Emacs

# Disable the bell
Set-PSReadlineOption -BellStyle None

# NOTE: Only needed to get PSReadline to follow base16 conventions
# https://github.com/lukesampson/concfg/blob/master/README.md
#try { $null = Get-Command concfg -ea stop; concfg tokencolor -n enable } catch { }

# FZF
Remove-Item env:TERM -ErrorAction Ignore
Remove-PSReadlineKeyHandler 'Ctrl+r'
Import-Module PSFzf -ArgumentList 'Ctrl+t','Ctrl+r'

# Git integration
Import-Module posh-git

# oh-my-posh themes
Import-Module oh-my-posh
Set-Theme wedisagree

# https://github.com/JanDeDobbeleer/oh-my-posh/issues/52
Copy-Item Function:prompt Function:promptorig
Remove-Item Function:prompt
function prompt {
    if (-not $? -and $error.Count -eq $ThemeSettings.ErrorCount) {
        try { throw } catch {}
    }

    # Also preserve $LASTEXITCODE
    $exitCodeOrig = $global:LASTEXITCODE
    promptorig
    $global:LASTEXITCODE = $exitCodeOrig
}

# Enable colors with ls
Import-Module DirColors

# Set default file encoding to UTF-8 without BOM
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8NoBOM'

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}