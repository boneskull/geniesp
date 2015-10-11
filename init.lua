connect = require('connect')
garage = require('garage')

function init()

  if (not file.open('config.json', 'r')) then
    print('No config.json present; cannot initialize')
    return
  end

  local config = cjson.decode(file.read())
  connect(config, function(err)
    if (err ~= nil) then
      return print(err)
    end

    garage.init(config)
  end)
end

init()