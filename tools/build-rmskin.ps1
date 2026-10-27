# Builds dist\<Skin>_<version>.rmskin from Coreglow-backup\<Skin>.
# Each skin is its own root config (Skins\Coreglow1, Skins\Coreglow2), so the two installers don't overwrite each other.
# An .rmskin is a zip (RMSKIN.ini + Skins\...) followed by a 16-byte footer:
# int64 zip size, 1 byte flags, "RMSKIN\0".
param([string]$Version = '1.0', [Parameter(Mandatory)][ValidateSet('Coreglow1', 'Coreglow2')][string]$Skin)

Add-Type -AssemblyName System.IO.Compression.FileSystem
$root  = Split-Path $PSScriptRoot -Parent
$src   = "$root\Coreglow-backup\$Skin"
$stage = Join-Path ([IO.Path]::GetTempPath()) "coreglow-rmskin"
$dist  = "$root\dist"
$out   = "$dist\$($Skin)_$Version.rmskin"

if (Test-Path $stage) { Remove-Item $stage -Recurse -Force }
New-Item -ItemType Directory "$stage\Skins" -Force | Out-Null
New-Item -ItemType Directory $dist -Force | Out-Null
Copy-Item $src "$stage\Skins\$Skin" -Recurse

@"
[rmskin]
Name=$Skin
Author=Stavros Antoniou
Version=$Version
MinimumRainmeter=4.5.6
MinimumWindows=10.0
LoadType=Skin
Load=$Skin\$Skin.ini
VariableFiles=$Skin\@Resources\Variables.inc
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
