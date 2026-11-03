-- Builds the Open-Meteo URL from the current coordinates and starts the fetch.
function Fetch()
    local lat = SKIN:ReplaceVariables('[MeasureLat]')
    local lon = SKIN:ReplaceVariables('[MeasureLon]')
    local q = SKIN:ReplaceVariables('[MeasureWUnitQuery]')
    local url = 'https://api.open-meteo.com/v1/forecast?latitude=' .. lat .. '&longitude=' .. lon ..
        '&current=temperature_2m,apparent_temperature,relative_humidity_2m,weather_code,wind_speed_10m,wind_direction_10m&timezone=auto' .. q
    SKIN:Bang('!SetOption', 'MeasureWeather', 'URL', url)
    SKIN:Bang('!EnableMeasure', 'MeasureWeather')
    SKIN:Bang('!CommandMeasure', 'MeasureWeather', 'Update')
end