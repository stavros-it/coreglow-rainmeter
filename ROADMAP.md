# Coreglow – Roadmap

## ✅ Done (v1.0 – 2026-10-07)

- [x] Classic skin: CPU, RAM, SWAP, Core Temp (max temp, power, clock), external IP, network speed + graph, uptime
- [x] Modern design: Shape meters, rings, gradient bars, Segoe UI Variable, variables in `Variables.inc`
- [x] Pro variant: GPU + VRAM, per-thread bars, CPU name, clock/date, top process, C: drive + R/W, LAN IP,
      adapter, ping, total traffic, click actions, hover glow, collapse, auto light/dark theme
- [x] Weather line (wttr.in, LGIR) in both variants
- [x] Per-thread bars adapt to any CPU (Cores.lua)
- [x] Fixes: CoreTemp `Power` type, UsageMonitor string values, top-process %
- [x] Backup folder + INSTALL.md

## ✅ Done (v1.1 – polish – 2026-10-07)

- [x] Weather icon from wttr.in `%c`, plus feels-like temperature in the tooltip
- [x] Remember the collapsed state across refreshes (`Collapsed` in ThemeState.inc)
- [x] Colored per-thread bars (accent < 50% ≤ amber < 80% ≤ red), with a per-thread % tooltip
- [x] Ring tooltips for CPU and temp: min/max since load, average over the last hour (`AverageSize=3600`)
- [x] Rainmeter logging/debug turned off
- [x] `.rmskin` installer: `tools\build-rmskin.ps1` → `dist\Coreglow_1.1.rmskin`
- [x] Local git repo + `tools\sync.ps1`
- [x] Classic variant removed; only Pro remains
- [x] Renamed CoreStats → **Coreglow** (`Skins\Coreglow\Coreglow.ini`)
- [x] "VRAM" label on the GPU memory value

## 📋 Backlog (v1.2 – features, not started)

- [ ] GPU temperature / hotspot / fan via the HWiNFO plugin (optional; hide the section if HWiNFO isn't running)
- [ ] Weather forecast tooltip or popup for the next 3 days (wttr.in `format=j1` + Lua parsing)
- [ ] Settings panel skin: accent color picker, scale, choice of sections, weather location
- [ ] Scale variable (100% / 125% / 150%) for high-DPI screens
- [ ] Media "now playing" row (NowPlaying / WebNowPlaying plugin)
- [ ] Alerts: flash the temperature ring above TempHot, or a toast when CPU > 90% for 30 s

## 💡 Ideas / maybe

- [ ] Compact horizontal "taskbar strip" variant
- [ ] Per-process top-3 list (CPU and RAM)
- [ ] Latency history graph for ping
- [ ] Publish on DeviantArt / Rainmeter forums

## Known limitations

- GPU temperature requires HWiNFO (Windows exposes no counter for it).
- SWAP shows commit charge, not pagefile usage.
- wttr.in can rate-limit. The weather then shows "Weather unavailable" until the next refresh.
