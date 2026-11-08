# Coreglow – Roadmap

## ✅ Done (v1.0 – 2026-10-07)

- [x] Classic skin: CPU, RAM, SWAP, Core Temp (max temp, power, clock), external IP, network speed + graph, uptime
- [x] Modern design: Shape meters, rings, gradient bars, Segoe UI Variable, variables in `Variables.inc`
- [x] Pro variant: GPU + VRAM, per-thread bars, CPU name, clock/date, top process, C: drive + R/W, LAN IP,
      adapter, ping, total traffic, click actions, hover glow, collapse, auto light/dark theme
- [x] Weather line in both variants (now Open-Meteo)
- [x] Per-thread bars adapt to any CPU (Cores.lua)
- [x] Fixes: CoreTemp `Power` type, UsageMonitor string values, top-process %
- [x] Backup folder + INSTALL.md

## ✅ Done (v1.1 – polish – 2026-10-07)

- [x] Weather icon from the weather code, plus feels-like temperature in the tooltip
- [x] Remember the collapsed state across refreshes (`Collapsed` in ThemeState.inc)
- [x] Colored per-thread bars (accent < 50% ≤ amber < 80% ≤ red), with a per-thread % tooltip
- [x] Ring tooltips for CPU and temp: min/max since load, average over the last hour (`AverageSize=3600`)
- [x] Rainmeter logging/debug turned off
- [x] `.rmskin` installer: `tools\build-rmskin.ps1` → `dist\Coreglow_1.1.rmskin`
- [x] Local git repo + `tools\sync.ps1`
- [x] Classic variant removed; only Pro remains
- [x] Renamed CoreStats → **Coreglow** (`Skins\Coreglow\Coreglow.ini`)
- [x] "VRAM" label on the GPU memory value

## ✅ Done (v1.2 – 2026-10-08)

- [x] Alerts: temp ring blinks above `TempHot`; CPU ring + label turn red ("⚠ CPU") when CPU ≥ `LoadAlert`% for `LoadAlertSecs` s

## ✅ Done (v1.3 – 2026-10-09)

- [x] Weather auto-detects the location from the public IP (empty `WeatherLoc`) and uses regional units (`WeatherUnits`: auto / m / u / M); location shown in the tooltip (superseded in v2.1)
- [x] Location name on its own line above the weather (layout shifted down 18 px, `FullH` 664 / `MiniH` 304)

## ✅ Done (v1.4 – 2026-10-21)

- [x] Wi-Fi row in Network (only while connected): signal bars, SSID, ≈dBm; tooltip with %, PHY, auth, link speed; click → Wi-Fi settings

## ✅ Done (v1.5 – 2026-10-21)

- [x] Battery row (only when a battery is present, via PowerPlugin `Status > 0`): battery icon with charge fill, %, On battery / On AC power; charge colors (accent > 30%, amber 11–30%, red ≤ 10%); click → Power settings
- [x] Accent presets in the skin context menu (Coreglow default, Emerald, Sunset, Rose, Mono), written back to `Variables.inc` so the choice survives refreshes
- [x] Row layout is now combination-safe: panel height = 691 + 23×(Wi-Fi connected) + 23×(battery present), reapplied by both row measures on every update

## ✅ Done (v2.1 / v2.1.1 – 2026-11-03: Coreglow1 1.9.1, Coreglow2 1.1.1)

- [x] Weather moved from wttr.in (outage) to Open-Meteo, no API key; `@Resources\Weather.inc` shared by both skins
- [x] Location from the Windows Location Service (`GetLocation.ps1`, run hidden, read once at load and every 6 h, saved position reused), or a place name in `WeatherLoc` (Open-Meteo geocoding); no IP lookup; tooltip shows place name and coordinates (bigdatacloud reverse geocoding)
- [x] `WeatherUnits`: m (default) / u (°F, mph) / ms (wind in m/s)
- [x] Weather line: short condition names, drop icon + humidity, wind symbol + direction arrow + Beaufort force; description, humidity, wind and their icons colored green / yellow / orange / red by severity (`Alert*` variables)
- [x] Click CPU % / top process, GPU % or RAM to open Task Manager sorted by CPU / GPU / Memory (edits Task Manager's `settings.json`, no admin rights)
- [x] Themed hover cards (`Tip.lua`, `TipBg`, accent border) replace the native tooltips and follow the light/dark theme and accent presets
- [x] Per-skin releases, `.rmskin` packages and GitHub releases v2.1 / v2.1.1

## ✅ Done (v2.2 – 2026-11-08: Coreglow1 1.10, Coreglow2 1.2)

- [x] External IP from api.country.is (IP + country code, free, no key) instead of ipify, still one request per 600 updates
- [x] Country flag next to the external IP (flagcdn.com, lowercase code, saved to the skin's `DownloadFile\`, git-ignored); hover shows the country code
- [x] GitHub release v2.2 with both `.rmskin` packages

## 📋 Backlog (v1.2 – features, not started)

- [ ] GPU temperature / hotspot / fan via the HWiNFO plugin (optional; hide the section if HWiNFO isn't running)
- [ ] Weather forecast tooltip or popup for the next 3 days (Open-Meteo `daily` data + Lua parsing)
- [ ] Click the temp ring to show the Core Temp window (blocked: Core Temp runs elevated, needs admin rights)
- [ ] Settings panel skin: accent color picker, scale, choice of sections, weather location
- [ ] Scale variable (100% / 125% / 150%) for high-DPI screens
- [ ] Media "now playing" row (NowPlaying / WebNowPlaying plugin)
- [ ] Top-3 process lists (CPU and RAM) via UsageMonitor, replacing the single top-process row
- [ ] Sunrise/sunset line (Open-Meteo `daily=sunrise,sunset`, reuses the forecast parser)

## 💡 Ideas / maybe

- [ ] Compact horizontal "taskbar strip" variant
- [ ] Latency history graph for ping
- [ ] Publish on DeviantArt / Rainmeter forums

## Known limitations

- CPU fan RPM requires HWiNFO or LibreHardwareMonitor (Core Temp and Windows don't expose it).
- GPU temperature requires HWiNFO (Windows exposes no counter for it).
- SWAP shows commit charge, not pagefile usage.
- Open-Meteo can be unreachable. The weather then shows "Weather unavailable" until the next refresh.
- Task Manager opens sorted by the clicked column only when it is not already running (it reads its sort at start-up; an open window keeps its sort).
- Windows shows its location icon briefly whenever the skin reads the location (at load and every 6 hours). Set `WeatherLoc` to a place name to avoid it.
- The flag needs both api.country.is and flagcdn.com. If either is down, the flag stays blank (or keeps the last one) until the next refresh; with a VPN it shows the exit country.
