# Coreglow – Rainmeter skin

Modern Windows 11 system monitor: weather, CPU usage, RAM, SWAP, CPU max temperature,
CPU power (W), CPU clock (MHz), external IP, download/upload speed, Windows uptime.

## 1. What to install

| Software | Why | Where |
|---|---|---|
| **Rainmeter** 4.5.6 or newer | Runs the skin | https://www.rainmeter.net |
| **Core Temp** | Provides CPU temperature, power, clock and CPU name | https://www.alcpu.com/CoreTemp/ |
| **Core Temp Rainmeter plugin** (`CoreTemp.dll`) | Lets Rainmeter read Core Temp's data | Core Temp website → *Add-ons* → *Rainmeter plugin* |

Installing the plugin: download the plugin archive and copy the 64-bit `CoreTemp.dll` to
`C:\Program Files\Rainmeter\Plugins\` (or `%APPDATA%\Rainmeter\Plugins\`). Restart Rainmeter.

**Core Temp must be running** for temperature, power and clock to show values.
Tip: in Core Temp → Options → Settings → General, enable *Start Core Temp with Windows*.

Nothing else is needed. The other plugins used (UsageMonitor, PingPlugin, WebParser) come with Rainmeter.

## 2. Install the skin

**Easiest:** double-click `Coreglow1_x.y.rmskin` or `Coreglow2_x.y.rmskin` (from the Releases page or `dist\`) and click **Install**. Rainmeter copies that skin into its own folder and loads it.
Your `Variables.inc` settings are kept when you upgrade.

**Manually:**

1. Copy the `Coreglow1` and/or `Coreglow2` folder (each contains its `.ini` and its own `@Resources`) to:
   `%USERPROFILE%\Documents\Rainmeter\Skins\`
2. Right-click the Rainmeter tray icon → **Refresh all**.
3. Right-click the tray icon → **Manage** → select **Coreglow1 → Coreglow1.ini** (or **Coreglow2 → Coreglow2.ini**) → **Load**.
4. Drag the skin wherever you like on the desktop. It may open at the top edge of the screen,
   behind windows. Press **Win + D** to show the desktop.

## 3. Features

| Skin (Manage → …) | Contents |
|---|---|
| `Coreglow1\Coreglow1.ini` (Coreglow2 shows the same data in a large-type card layout) | Weather, CPU, max temp, power, clock, RAM, SWAP, external IP, network speed and graph, uptime, GPU usage + VRAM, per-thread load bars, CPU name, clock/date, top process, C: drive usage + read/write, LAN IP + adapter, ping (1.1.1.1), total traffic, battery row (devices with a battery), accent presets, click actions, hover glow, collapse button (☰), automatic light/dark theme |

### Weather
- Shown under the header as `🌤️ 17°C  Partly cloudy  💧65%  ≋↑3` (wind arrow = where it blows towards, number = Beaufort force), from [Open-Meteo](https://open-meteo.com) (no API key).
- Refreshes every 15 minutes. Click it to open the location on windy.com.
- Location: `WeatherLoc=` in `@Resources\Variables.inc`. Empty (the default) uses the Windows Location Service
  (Settings > Privacy & security > Location must be on; Windows shows its location icon briefly when the skin reads it,
  at load and every 6 hours). Or pin a place name (`Athens`, `New York`), which skips Windows location entirely.
- Units: `WeatherUnits=` `m` (default: °C, km/h), `u` (°F, mph) or `ms` (°C, wind in m/s).
- Shows "Weather unavailable" if Open-Meteo can't be reached and "Location not found" if `WeatherLoc` can't be resolved.
- Starts with a weather icon (🌤️). Description, humidity and wind are colored by severity: green / yellow / orange / red (description by condition, humidity by comfort range 30-60 % green, wind by Beaufort force 0-3 / 4-5 / 6-7 / 8+). Colors are `AlertGreen/Yellow/Orange/Red` in `Variables.inc`. Hover over the line to see the place, feels-like temperature and wind (with unit and Beaufort force).

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
- **Wi-Fi row** (Network section) appears only while Wi-Fi is connected: signal bars, SSID and signal in dBm.
  The dBm value is estimated from the Windows signal quality (0% = -100 dBm, 100% = -50 dBm or better).
  On Windows 11 24H2+ turn on *Settings → Privacy & security → Location → Let desktop apps access your location*,
  otherwise Windows hides Wi-Fi details from Rainmeter and the row stays hidden. With several wireless adapters,
  change `WiFiIntf=` in `@Resources\Variables.inc`.
- **Battery row** (Network section) appears only on devices with a battery: charge icon, percentage and
  On battery / On AC power. It turns amber below 30% and red below 10%. Click it for Power settings.
  Desktop PCs have no battery, so there the row is never shown.
- Network speed uses only the main internet adapter (`Interface=Best`), so VMware, Hyper-V and Tailscale
  traffic isn't counted twice.
- Click actions: the CPU % and the top process open Task Manager sorted by CPU, the GPU % opens it sorted by GPU, and the RAM line opens it sorted by Memory (if Task Manager is already open it only comes to the front and keeps its sort), C: opens Explorer, NETWORK opens Network settings,
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
- Ping target: `PingHost=` in the `[Variables]` section of `Coreglow1.ini` / `Coreglow2.ini`.

**Important:** `Coreglow1.ini` and `Coreglow2.ini` are saved as **UTF-16 LE** so the symbols (⚡ ° ↓ ↑ ☰) display correctly.
Keep that encoding when you edit them (Notepad: *Save As* → Encoding *UTF-16 LE*).

**Accent presets:** right-click the skin → **Accent: …** (Coreglow, Emerald, Sunset, Rose, Mono).
These overwrite `Accent1`/`Accent2` in `@Resources\Variables.inc`.

## 5. Files

```
Coreglow1\                 (Coreglow2\ has the same layout, plus @Resources\Coreglow2\ for its theme and collapse state)
├── Coreglow1.ini          the skin
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
- **Weather unavailable:** Open-Meteo is unreachable. It retries on the next 15-minute refresh.
- **Ping shows -1:** the ping target timed out. Change `PingHost`.
- **Skin doesn't appear:** press Win + D, or Manage → select the skin → Load. Still missing?
  Manage → Settings → enable **Logging**, then check About → Log.
- **"SWAP" is higher than expected:** Rainmeter's swap reading is Windows' total committed memory
  (RAM + page file) against its limit, not page-file use alone.
