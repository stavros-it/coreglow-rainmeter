# Builds dist\Coreglow_<version>.rmskin from Coreglow-backup\Coreglow.
# An .rmskin is a zip (RMSKIN.ini + Skins\...) followed by a 16-byte footer:
# int64 zip size, 1 byte flags, "RMSKIN\0".
param([string]$Version = '1.1')

Add-Type -AssemblyName System.IO.Compression.FileSystem
$root  = Split-Path $PSScriptRoot -Parent
$src   = "$root\Coreglow-backup\Coreglow"
$stage = Join-Path ([IO.Path]::GetTempPath()) "coreglow-rmskin"
$dist  = "$root\dist"
$out   = "$dist\Coreglow_$Version.rmskin"

if (Test-Path $stage) { Remove-Item $stage -Recurse -Force }
New-Item -ItemType Directory "$stage\Skins" -Force | Out-Null
New-Item -ItemType Directory $dist -Force | Out-Null
Copy-Item $src "$stage\Skins\Coreglow" -Recurse

@"
[rmskin]
Name=Coreglow
Author=Stavros
Version=$Version
MinimumRainmeter=4.5.0
MinimumWindows=10.0
LoadType=Skin
Load=Coreglow\Coreglow.ini
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
