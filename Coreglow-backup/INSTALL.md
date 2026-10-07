# Coreglow – Rainmeter skin

Modern Windows 11 system monitor: weather, CPU usage, RAM, SWAP, CPU max temperature,
CPU power (W), CPU clock (MHz), external IP, download/upload speed, Windows uptime.

## 1. What to install

| Software | Why | Where |
|---|---|---|
| **Rainmeter** 4.5 or newer | Runs the skin | https://www.rainmeter.net |
| **Core Temp** | Provides CPU temperature, power, clock and CPU name | https://www.alcpu.com/CoreTemp/ |
| **Core Temp Rainmeter plugin** (`CoreTemp.dll`) | Lets Rainmeter read Core Temp's data | Core Temp website → *Add-ons* → *Rainmeter plugin* |

Installing the plugin: download the plugin archive and copy the 64-bit `CoreTemp.dll` to
`C:\Program Files\Rainmeter\Plugins\` (or `%APPDATA%\Rainmeter\Plugins\`). Restart Rainmeter.

**Core Temp must be running** for temperature, power and clock to show values.
Tip: in Core Temp → Options → Settings → General, enable *Start Core Temp with Windows*.

Nothing else is needed. The other plugins used (UsageMonitor, PingPlugin, WebParser) come with Rainmeter.

## 2. Install the skin

**Easiest:** double-click `dist\Coreglow_1.1.rmskin` and click **Install**. Rainmeter copies the skin and loads it.
Your `Variables.inc` settings are kept when you upgrade.

**Manually:**

1. Copy the `Coreglow` folder (the one containing `Coreglow.ini` and `@Resources`) to:
   `%USERPROFILE%\Documents\Rainmeter\Skins\`
2. Right-click the Rainmeter tray icon → **Refresh all**.
3. Right-click the tray icon → **Manage** → select **Coreglow → Coreglow.ini** → **Load**.
4. Drag the skin wherever you like on the desktop. It may open at the top edge of the screen,
   behind windows. Press **Win + D** to show the desktop.

## 3. Features

| Skin (Manage → …) | Contents |
|---|---|
| `Coreglow\Coreglow.ini` | Weather, CPU, max temp, power, clock, RAM, SWAP, external IP, network speed and graph, uptime, GPU usage + VRAM, per-thread load bars, CPU name, clock/date, top process, C: drive usage + read/write, LAN IP + adapter, ping (1.1.1.1), total traffic, click actions, hover glow, collapse button (☰), automatic light/dark theme |

### Weather
- Shown under the header as `T: 17°C | Partly Cloudy | H: 65% | W: 5 km/h`, from https://wttr.in.
- Refreshes every 15 minutes. Click it to open the full forecast in your browser.
- Location: `WeatherLoc=LGIR` in `@Resources\Variables.inc`. Use a city (`Athens`), an airport code (`LGIR`)
  or `lat,lon`.
- Shows "Weather unavailable" if wttr.in can't be reached.
- Starts with a weather icon (🌤️). Hover over the line to see the feels-like temperature.

### Tooltips
- Hover over the **CPU** or **Max Temp** ring to see the min and max since the skin loaded, and the average over the last hour.

### Notes
- GPU usage and VRAM come from Windows performance counters, so no extra software is needed.
  GPU temperature is **not** included because it would need HWiNFO.
- Top process shows the app using the most CPU and its share of the total CPU, e.g. `Top: chrome 3.4%`.
- Per-thread load bars adapt to **any CPU** automatically. On load, `@Resources\Cores.lua` reads the
  logical processor count from Windows and writes `@Resources\Cores.inc` with one bar per thread, sized to fill the row.
  If the count changes (new PC or CPU), it rewrites the file and refreshes the skin once. You don't need to edit anything.
- Only the **C:** drive is shown.
- Network speed uses only the main internet adapter (`Interface=Best`), so VMware, Hyper-V and Tailscale
  traffic isn't counted twice.
- Click actions: the CPU ring and top process open Task Manager, C: opens Explorer, NETWORK opens Network settings,
  and the weather line opens the forecast.
- Thread bars turn amber at 50% load and red at 80%. Hover over a bar to see its exact %.
- ☰ (top-right) folds away the Memory, Storage and Network sections. The skin remembers this after refreshes and reboots.
- The theme follows Windows *Settings → Personalization → Colors → App mode* (checked every 5 s).
  Light colors are in `@Resources\Theme1.inc` and dark colors in `Theme0.inc`.
- Total traffic counts up across sessions. To reset it, right-click the Rainmeter tray icon → Manage → **Settings** → *Reset statistics*.

## 4. Customize

Right-click the skin → **Custom skin actions** → **Edit variables** (or open
`@Resources\Variables.inc`). You can change the colors, font, width, weather location and the temperature
thresholds (`TempWarn`, `TempHot`). Right-click → **Refresh skin** after saving.

- Font sizes: the `FontSize=` lines in the `Style...` sections of each `.ini`.
- Ping target: `PingHost=` in the `[Variables]` section of `Coreglow.ini`.

**Important:** `Coreglow.ini` is saved as **UTF-16 LE** so the symbols (⚡ ° ↓ ↑ ☰) display correctly.
Keep that encoding when you edit them (Notepad: *Save As* → Encoding *UTF-16 LE*).

## 5. Files

```
Coreglow\
├── Coreglow.ini           the skin
└── @Resources\
    ├── Variables.inc      colors, font, thresholds, weather location (shared)
    ├── Cores.lua          builds the per-thread bars for the current CPU
    ├── Cores.inc          generated by Cores.lua, don't edit
    ├── ThemeState.inc     current theme (written automatically)
    ├── Theme0.inc         dark theme colors
    └── Theme1.inc         light theme colors
```

## 6. Troubleshooting

- **Temperature, power or clock shows 0:** Core Temp isn't running, or the plugin is missing.
  The power type is `CoreTempType=Power`. Older guides use `CpuPower`, which this plugin rejects.
- **External IP shows "offline":** no internet access, or api.ipify.org is blocked. The IP refreshes every 10 minutes.
- **Weather unavailable:** wttr.in is down or rate-limited. It retries on the next 15-minute refresh.
- **Ping shows -1:** the ping target timed out. Change `PingHost`.
- **Skin doesn't appear:** press Win + D, or Manage → select the skin → Load. Still missing?
  Manage → Settings → enable **Logging**, then check About → Log.
- **"SWAP" is higher than expected:** Rainmeter's swap reading is Windows' total committed memory
  (RAM + page file) against its limit, not page-file use alone.
