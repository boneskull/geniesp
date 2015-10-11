local garage = {}

function send(data)
  local sock = net.createConnection(net.TCP, garage.config.garage.secure)
  sock:connect(garage.config.garage.port, garage.config.garage.host)
  sock:on('connection', function()
    sock:send(data)
  end)
  sock:on('sent', function()
    print('Transmission complete')
    sock:close()
  end)
end

function garage.sendOpened()
  
    garage.opened = true
    print('garage:opened')
    send('garage:opened')
  
end

function garage.sendClosed()
  print('garage:closed')
  send('garage:closed')
end

function garage.init(config)
  garage.config = config

  gpio.mode(config.garage.switchPin, gpio.INT)
  gpio.trig(config.garage.switchPin, 'down', sendOpened)
  gpio.trig(config.garage.switchPin, 'up', sendClosed)

  print('Garage ready')
end

return garage
