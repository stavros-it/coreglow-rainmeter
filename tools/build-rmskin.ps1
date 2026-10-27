# Builds dist\<name>_<version>.rmskin from Coreglow-backup\Coreglow.
# -Skin Coreglow1 / Coreglow2 packages only that skin (plus shared @Resources);
# without -Skin both skins are packaged and Coreglow1 is loaded.
# An .rmskin is a zip (RMSKIN.ini + Skins\...) followed by a 16-byte footer:
# int64 zip size, 1 byte flags, "RMSKIN\0".
param([string]$Version = '1.4', [ValidateSet('', 'Coreglow1', 'Coreglow2')][string]$Skin = '')

Add-Type -AssemblyName System.IO.Compression.FileSystem
$root  = Split-Path $PSScriptRoot -Parent
$src   = "$root\Coreglow-backup\Coreglow"
$stage = Join-Path ([IO.Path]::GetTempPath()) "coreglow-rmskin"
$dist  = "$root\dist"
$name  = if ($Skin) { $Skin } else { 'Coreglow' }
$load  = if ($Skin) { $Skin } else { 'Coreglow1' }
$out   = "$dist\$($name)_$Version.rmskin"

if (Test-Path $stage) { Remove-Item $stage -Recurse -Force }
New-Item -ItemType Directory "$stage\Skins" -Force | Out-Null
New-Item -ItemType Directory $dist -Force | Out-Null
Copy-Item $src "$stage\Skins\Coreglow" -Recurse

# Single-skin package: drop the other skin and its own resources
if ($Skin -eq 'Coreglow1') { Remove-Item "$stage\Skins\Coreglow\Coreglow2", "$stage\Skins\Coreglow\@Resources\Coreglow2" -Recurse -Force }
if ($Skin -eq 'Coreglow2') { Remove-Item "$stage\Skins\Coreglow\Coreglow1" -Recurse -Force }

@"
[rmskin]
Name=$name
Author=Stavros Antoniou
Version=$Version
MinimumRainmeter=4.5.6
MinimumWindows=10.0
LoadType=Skin
Load=Coreglow\$load\$load.ini
VariableFiles=Coreglow\@Resources\Variables.inc
"@ | Set-Content "$stage\RMSKIN.ini" -Encoding Unicode

if (Test-Path $out) { Remove-Item $out }
$zip = "$stage.zip"
if (Test-Path $zip) { Remove-Item $zip }
[IO.Compression.ZipFile]::CreateFromDirectory($stage, $zip)

$bytes  = [IO.File]::ReadAllBytes($zip)
$footer = [BitConverter]::GetBytes([int64]$bytes.Length) + [byte]0 + [Text.Encoding]::ASCII.GetBytes("RMSKIN`0")
[IO.File]::WriteAllBytes($out, $bytes + $footer)

Remove-Item $stage -Recurse -Force; Remove-Item $zip
Write-Host "Built $out"
