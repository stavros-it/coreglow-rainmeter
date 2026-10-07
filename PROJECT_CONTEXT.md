# Coreglow – Project Context

Rainmeter desktop system monitor for Windows 11, modern style (Shape meters, rounded corners, gradients).
Owner: Stavros. Started 2026-10-07.

## Locations

| What | Path |
|---|---|
| Live skin (what Rainmeter runs) | `%USERPROFILE%\Documents\Rainmeter\Skins\Coreglow\` |
| Backup + install guide | `Desktop\New folder\Coreglow-backup\` (`INSTALL.md`) |
| Rainmeter settings / log | `%APPDATA%\Rainmeter\Rainmeter.ini`, `Rainmeter.log` (logging OFF; turn it on to debug) |
| Core Temp plugin | `C:\Program Files\Rainmeter\Plugins\CoreTemp.dll` |
| Tools | `tools\sync.ps1` (live → backup, resets generated files), `tools\build-rmskin.ps1` (→ `dist\`) |
| Git | local repo in `Desktop\New folder` (`dist\` ignored) |

**Workflow:** edit the live skin → `Rainmeter.exe !Refresh "<config>"` → check the log
(`!WriteKeyValue Rainmeter Logging 1 "%APPDATA%\Rainmeter\Rainmeter.ini"`) → `tools\sync.ps1` →
`tools\build-rmskin.ps1 -Version x.y` → git commit.
Debug trick: temporarily add `OnUpdateAction=[!Log "[Measure:]"]` + `DynamicVariables=1` to a measure.

## Structure

```
Coreglow\
├── Coreglow.ini           the skin (config "Coreglow")
└── @Resources\            shared by both (#@#)
    ├── Variables.inc      colors, font, thresholds, WeatherLoc
    ├── Theme0.inc / Theme1.inc / ThemeState.inc   dark/light theme + collapsed state
    ├── Cores.lua          generates Cores.inc (per-thread bars) from NUMBER_OF_PROCESSORS
    └── Cores.inc          generated
```

Formerly named CoreStats (Classic + Pro variants). Renamed to Coreglow on 2026-10-07; Classic was dropped and Pro became the only skin.

## Features

- **Features:** weather (wttr.in), CPU % ring, CPU max temp ring (green/amber/red), CPU power W, CPU clock MHz,
  RAM/SWAP bars, external IP, ↓/↑ speed + graph, uptime.
  plus GPU % ring + VRAM, per-thread bars (auto for any CPU), CPU name, clock/date, top process,
  C: usage + R/W, LAN IP + adapter, ping, total traffic, click actions, hover glow, ☰ collapse, auto light/dark theme.

## Data sources

| Data | Measure |
|---|---|
| Temp / power / clock / CPU name | `Plugin=CoreTemp`, `CoreTempType=MaxTemperature / Power / CpuSpeed / CpuName` |
| GPU %, VRAM, disk R/W, top process | `Plugin=UsageMonitor` (Alias GPU / VRAM / CPU, Category LogicalDisk) |
| External IP | WebParser `https://api.ipify.org` (600 s) |
| Weather | WebParser `https://wttr.in/#WeatherLoc#?format=%t|%C|%h|%w&m` (900 s) + RegExp Substitute |
| Ping | `Plugin=PingPlugin`, 1.1.1.1 |
| Theme | Registry `HKCU\...\Themes\Personalize\AppsUseLightTheme` |

## Gotchas learned

- **Encoding:** the .ini files must be **UTF-16 LE** (for ⚡ ° ↓ ↑ ☰). Edit with PowerShell `[IO.File]::WriteAllText(..., [Text.Encoding]::Unicode)`.
  Line endings are CRLF, so normalize to `\n` before regex edits.
- **CoreTemp plugin:** the power type is `Power`, not `CpuPower`. Valid types: Temperature, MaxTemperature, TjMax, Load, Vid,
  CpuSpeed, CoreSpeed, BusSpeed, BusMultiplier, CpuName, Power.
- **UsageMonitor:** its *string* value is the instance name ("Total", "C"). Wrap it in a Calc measure to display the number.
  The CPU alias value is already % of the total CPU, so don't divide by threads.
- **`Meter=` cannot be set in a MeterStyle.** Put it in the meter section itself.
- New config folders need `!RefreshApp` before `!ActivateConfig` works.
- `Interface=Best` avoids counting VMware/Hyper-V/Tailscale virtual adapters.
- `SwapMemory` = commit charge (RAM + pagefile), not pagefile alone.
- A self-referencing Calc running average stayed at 0. Use `AverageSize=N` on the measure instead.
- Here-strings inserted with `.Replace()` have no trailing newline, which glues the next `[Section]` onto a comment line.
  Check for `^;.*\[` after scripted edits.
- `Cores.lua` regenerates `Cores.inc` when the thread count or `VERSION` changes. Bump `VERSION` after editing the generator.
- `.rmskin` = zip (RMSKIN.ini + `Skins/...`) + 16-byte footer (int64 zip size, flags byte, `RMSKIN\0`).
- Not possible without extra software: GPU temperature (needs HWiNFO).

## User's system (reference)

AMD Ryzen 7 5700X (8C/16T), AMD Radeon RX 7600, MSI MS-7C56 desktop, Realtek GbE (wired, no Wi-Fi, no battery).
Weather location LGIR (Heraklion). Only C: drive wanted in Storage.
