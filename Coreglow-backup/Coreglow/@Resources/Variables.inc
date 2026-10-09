[Variables]
; ===== Layout =====
; Skin width in pixels
W=300
; Width of RAM/SWAP bars
BarW=200
; Corner radius of the background panel
Radius=16

; ===== Font =====
Font=Segoe UI Variable Display
FontLight=Segoe UI Variable Display Light

; ===== Colors (R,G,B,Alpha) =====
BgColor=18,20,28,205
BorderColor=255,255,255,28
TextColor=235,238,245,255
LabelColor=150,158,175,255
TrackColor=255,255,255,22
DividerColor=255,255,255,20
; Accent gradient (start -> end)
Accent1=0,200,255,255
Accent2=150,90,255,255
; Network graph colors
DownColor=0,200,255,255
UpColor=190,110,255,255

; ===== Temperature thresholds (°C) =====
TempWarn=60
TempHot=80
TempOk=60,220,140,255
TempWarnColor=255,180,50,255
TempHotColor=255,70,80,255
TempHotDim=255,70,80,90

; ===== Alerts =====
; CPU ring + label turn red when CPU % >= LoadAlert for LoadAlertSecs seconds
LoadAlert=90
LoadAlertSecs=30

; ===== Weather (wttr.in) =====
; Location: city, airport code or lat,lon. Leave empty to auto-detect from your public IP.
WeatherLoc=
; Units: empty = automatic for the region (US -> imperial, elsewhere metric), m = metric, u = imperial (°F, mph), M = metric with wind in m/s
WeatherUnits=
