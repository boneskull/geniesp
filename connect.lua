return function(config, callback)

  file.close()

  wifi.setmode(wifi.STATION)
  wifi.sta.config(config.wifi.ssid, config.wifi.password)

  local function keepAlive()
    tmr.alarm(6, 5000, 1, function()
      if (wifi.sta.status() == nil) then
        connect()
      end
    end)
  end

  local function connect()
    wifi.sta.connect()
    tmr.alarm(6, 500, 1, function()
      if (wifi.sta.status() == 5) then
        tmr.stop(6)
        print('Connected to ' .. config.wifi.ssid)
        print('IPv4: ' .. wifi.sta.getip())

        callback()
        keepAlive()
      end
    end)
  end

  connect()
end
