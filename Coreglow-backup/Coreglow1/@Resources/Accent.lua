-- Accent presets: SetAccent(i) applies one, CycleAccent() moves to the next.
-- The choice is written to Variables.inc so it survives refreshes.

local PRESETS = {
  -- Accent1,          Accent2,          DownColor,        UpColor
  { '0,200,255,255',   '150,90,255,255', '0,200,255,255',   '190,110,255,255' }, -- Coreglow
  { '52,211,153,255',  '13,148,136,255', '52,211,153,255',  '45,212,191,255' },  -- Emerald
  { '251,146,60,255',  '239,68,68,255',  '251,146,60,255',  '248,113,113,255' }, -- Sunset
  { '244,114,182,255', '168,85,247,255', '244,114,182,255', '192,132,252,255' }, -- Rose
  { '226,232,240,255', '148,163,184,255', '226,232,240,255', '148,163,184,255' }, -- Mono
}

function Initialize() end

function SetAccent(i)
  local p = PRESETS[i]
  if not p then return end
  local file = SKIN:GetVariable('@') .. 'Variables.inc'
  local keys = { 'Accent1', 'Accent2', 'DownColor', 'UpColor' }
  for k = 1, 4 do
    SKIN:Bang('!WriteKeyValue', 'Variables', keys[k], p[k], file)
  end
  SKIN:Bang('!WriteKeyValue', 'Variables', 'AccentIdx', i, file)
  SKIN:Bang('!Refresh')
end

function CycleAccent()
  local i = tonumber(SKIN:GetVariable('AccentIdx', '1')) or 1
  SetAccent(i % #PRESETS + 1)
end
