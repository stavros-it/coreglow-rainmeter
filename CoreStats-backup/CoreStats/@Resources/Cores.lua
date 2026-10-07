-- Generates per-thread load bars (Cores.inc) for any CPU.
-- Runs on skin load; rewrites the include and refreshes only if the thread count
-- or the generator version changed.

local VERSION = 2

function Initialize()
  local n = tonumber(os.getenv('NUMBER_OF_PROCESSORS')) or 1
  local current = tonumber(SKIN:GetVariable('CoreCount', '0')) or 0
  local ver = tonumber(SKIN:GetVariable('CoresVer', '0')) or 0
  if n == current and ver == VERSION then return end

  local area = tonumber(SKIN:GetVariable('PW', '320')) - 40
  local step = area / n
  local w = math.max(step - 2, 1)
  local out = { '[Variables]', 'CoreCount=' .. n, 'CoresVer=' .. VERSION, '' }

  -- bar color by load: accent < 50% <= amber < 80% <= red
  for i = 1, n do
    out[#out + 1] = string.format(
      '[MeasureCore%d]\nMeasure=CPU\nProcessor=%d\n' ..
      'IfCondition=MeasureCore%d < 50\nIfTrueAction=[!SetOption MeterCore%d BarColor "#Accent1#"]\n' ..
      'IfCondition2=(MeasureCore%d >= 50) && (MeasureCore%d < 80)\nIfTrueAction2=[!SetOption MeterCore%d BarColor "#TempWarnColor#"]\n' ..
      'IfCondition3=MeasureCore%d >= 80\nIfTrueAction3=[!SetOption MeterCore%d BarColor "#TempHotColor#"]\n',
      i, i, i, i, i, i, i, i, i)
  end
  for i = 1, n do
    out[#out + 1] = string.format(
      '[MeterCore%d]\nMeter=Bar\nMeterStyle=StyleCore\nMeasureName=MeasureCore%d\nX=%.2f\nW=%.2f\nToolTipText=Thread %d: [MeasureCore%d:0]%%\nDynamicVariables=1\n',
      i, i, 20 + (i - 1) * step, w, i, i)
  end

  local f = io.open(SKIN:MakePathAbsolute(SKIN:GetVariable('@') .. 'Cores.inc'), 'w')
  if not f then return end
  f:write(table.concat(out, '\n'))
  f:close()
  SKIN:Bang('!Refresh')
end
