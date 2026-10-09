# Copies the live skin from Rainmeter's Skins folder into Coreglow-backup\
# and resets machine-specific generated files.
$root = Split-Path $PSScriptRoot -Parent
$live = "$env:USERPROFILE\Documents\Rainmeter\Skins\Coreglow"
$dst  = "$root\Coreglow-backup\Coreglow"

if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
Copy-Item $live $dst -Recurse

Set-Content "$dst\@Resources\Cores.inc"      "[Variables]`r`nCoreCount=0" -Encoding ascii
Set-Content "$dst\@Resources\ThemeState.inc" "[Variables]`r`nIsLight=0`r`nCollapsed=0" -Encoding ascii

# The shipped default is auto-detect; a personal pinned location stays in the live skin only
$vars = "$dst\@Resources\Variables.inc"
$text = [IO.File]::ReadAllText($vars) -replace '(?m)^WeatherLoc=.*?(\r?)$', 'WeatherLoc=$1'
[IO.File]::WriteAllText($vars, $text, (New-Object Text.UTF8Encoding $false))
Write-Host "Synced $live -> $dst"
