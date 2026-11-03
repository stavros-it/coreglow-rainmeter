param([Parameter(Mandatory)][ValidateSet('CPU','GPU','Memory')][string]$Column)
# Opens Task Manager sorted (highest first) by the given column on the Processes page.
# Task Manager stores its sort in settings.json (SortDir + bit 25 of Flags on the sorted column) and
# reads it at start-up, so no admin rights are needed.
# If Task Manager is already open it only brings the existing window forward (it keeps its current sort).
$f = Join-Path $env:LOCALAPPDATA 'Microsoft\Windows\TaskManager\settings.json'
$SortBit = [int64]33554432   # 2^25

if (-not (Get-Process Taskmgr -ErrorAction SilentlyContinue) -and (Test-Path $f)) {
    $target = @{ CPU = 'TmColCPUPercent'; GPU = 'TmColGPUPercent'; Memory = 'TmColMemory' }[$Column]
    $t = [IO.File]::ReadAllText($f)
    # Only the first list (Processes page): everything before the second TabId
    $second = $t.IndexOf('"TabId"', $t.IndexOf('"TabId"') + 1)
    if ($second -lt 0) { $second = $t.Length }
    $head = $t.Substring(0, $second)
    $tail = $t.Substring($second)
    $head = [regex]::Replace($head, '\{"ColElementId":"(\w+)"[^}]*\}', {
        param($m)
        $s = $m.Value
        if ($m.Groups[1].Value -notmatch '^TmCol(CPUPercent|GPUPercent|Memory|Disk|Network)$') { return $s }
        $isTarget = ($m.Groups[1].Value -eq $target)
        $s = [regex]::Replace($s, '"SortDir":\d+', ('"SortDir":' + [int]$isTarget))
        [regex]::Replace($s, '"Flags":(\d+)', {
            param($fm)
            $v = [int64]$fm.Groups[1].Value
            if ($isTarget) { $v = $v -bor $SortBit } else { $v = $v -band (-bnot $SortBit) }
            '"Flags":' + $v
        })
    })
    [IO.File]::WriteAllText($f, ($head + $tail), (New-Object Text.UTF8Encoding $false))
}
Start-Process taskmgr.exe
