# Writes the Windows Location Service position to Location.txt ("lat,lon") next to this script.
# Needs Settings > Privacy & security > Location turned on.
# Reuse the saved position for 6 hours so Windows location is not touched (no taskbar icon) on every run
$out = Join-Path $PSScriptRoot 'Location.txt'
if ((Test-Path $out) -and ((Get-Item $out).LastWriteTime -gt (Get-Date).AddHours(-6))) { exit }
Add-Type -AssemblyName System.Device
$w = New-Object System.Device.Location.GeoCoordinateWatcher([System.Device.Location.GeoPositionAccuracy]::Default)
[void]$w.TryStart($false, [TimeSpan]::FromSeconds(30))
$c = $w.Position.Location
if ($c -and -not $c.IsUnknown) {
    $ci = [Globalization.CultureInfo]::InvariantCulture
    $txt = '{0},{1}' -f $c.Latitude.ToString('0.####', $ci), $c.Longitude.ToString('0.####', $ci)
    [IO.File]::WriteAllText((Join-Path $PSScriptRoot 'Location.txt'), $txt)
}
$w.Stop()