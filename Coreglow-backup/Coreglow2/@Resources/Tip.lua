-- Themed hover tooltip: shows the TipText of the hovered meter in a card drawn by the skin.
function Show(name)
    local m = SKIN:GetMeter(name)
    if not m then return end
    local text = SKIN:ReplaceVariables(m:GetOption('TipText', ''))
    SKIN:Bang('!SetVariable', 'TipY', tostring(m:GetY() + m:GetH() + 6))
    SKIN:Bang('!SetOption', 'MeterTipText', 'Text', text)
    SKIN:Bang('!ShowMeterGroup', 'Tip')
    SKIN:Bang('!UpdateMeter', 'MeterTipText')
    SKIN:Bang('!UpdateMeasure', 'MeasureTipTop')
    SKIN:Bang('!UpdateMeter', 'MeterTipBg')
    SKIN:Bang('!UpdateMeter', 'MeterTipText')
    SKIN:Bang('!Redraw')
end

function Hide()
    SKIN:Bang('!HideMeterGroup', 'Tip')
    SKIN:Bang('!Redraw')
end