#requires -Version 2 -Modules posh-git

# Based on https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/wedisagree.zsh-theme

function Write-Theme {
    param(
        [bool]
        $lastCommandFailed,
        [string]
        $with
    )

    $leftComponents = [System.Collections.ArrayList]@()
    $rightComponents = [System.Collections.ArrayList]@()

    if ($with) {
        $leftComponents.Add(@{
            Text = "[$($with.ToUpper())]";
            Color = $sl.Colors.WithForegroundColor
        }) | Out-Null
    }

    if (Test-VirtualEnv) {
        $leftComponents.Add(@{
            Text = "[$(Get-VirtualEnvName)]";
            Color = $sl.Colors.VirtualEnvForegroundColor
        }) | Out-Null
    }

    $path = $sl.PromptSymbols.HomeSymbol
    if ($pwd.Path -ne $HOME) {
        $path = Split-Path -Leaf -Path $pwd
    }
    $leftComponents.Add(@{
        Text = "[$path] ";
        Color = $sl.Colors.DriveForegroundColor
    }) | Out-Null

    if (Test-Administrator) {
        $rightComponents.Add(@{
            Text = " $($sl.PromptSymbols.ElevatedSymbol)";
            Color = $sl.Colors.AdminIconForegroundColor
        }) | Out-Null
    }

    $rightComponents.Add(@{
        Text = " $(Get-Date -Format HH:mm:ss)";
        Color = if ($lastCommandFailed) {
            $sl.Colors.CommandFailedIconForegroundColor
        } else {
            $sl.colors.TimestampForegroundColor
        }
    }) | Out-Null

    if ($vcsStatus = Get-VCSStatus) {
        $vcsInfo = Get-VcsInfo -status ($vcsStatus)
        $rightComponents.Add(@{
            Text = " $($vcsInfo.VcInfo)";
            Color = $vcsInfo.BackgroundColor
        }) | Out-Null
    }

    $prompt += Set-CursorForRightBlockWrite `
        -textLength (($rightComponents | ForEach-Object { $_.Text }) -join '').Length

    $writeItems = { $prompt += Write-Prompt -Object $_.Text -ForegroundColor $_.Color }

    $rightComponents | ForEach-Object $writeItems
    $prompt += Write-Prompt -Object "`r"
    $leftComponents | ForEach-Object $writeItems

    $prompt
}

$sl = $global:ThemeSettings
$sl.Colors.CommandFailedIconForegroundColor = [ConsoleColor]::Red
$sl.Colors.DriveForegroundColor = [ConsoleColor]::Magenta
$sl.Colors.TimestampForegroundColor = [ConsoleColor]::Green
$sl.Colors.VirtualEnvForegroundColor = [System.ConsoleColor]::Magenta
$sl.Colors.WithForegroundColor = [ConsoleColor]::DarkRed