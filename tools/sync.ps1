# Copies the live skin from Rainmeter's Skins folder into Coreglow-backup\
# and resets machine-specific generated files.
$root = Split-Path $PSScriptRoot -Parent
$live = "$env:USERPROFILE\Documents\Rainmeter\Skins\Coreglow"
$dst  = "$root\Coreglow-backup\Coreglow"

if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
Copy-Item $live $dst -Recurse

Set-Content "$dst\@Resources\Cores.inc"      "[Variables]`r`nCoreCount=0" -Encoding ascii
Set-Content "$dst\@Resources\ThemeState.inc" "[Variables]`r`nIsLight=0`r`nCollapsed=0" -Encoding ascii
Write-Host "Synced $live -> $dst"
