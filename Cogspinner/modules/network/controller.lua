--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, core.context
local addon, framework = ...

--- @type listenerManager.constructor
local createListenerManager = framework.import('shared/listeners')

--- @type library.table.mergeTables
local mergeTables = framework.import('table/merge')

---
--- ?
---
--- @type table<string, network.channel>
---
local channels = {}

---
--- ?
---
--- @type network.reserveChannel
---
local reserveChannel = function(name, options)
  if channels[name] ~= nil then
    throw('Channel registration failed, "%s" already exists', name)
  end

  channels[name] = mergeTables(createListenerManager(), options or {})
end

---
--- ?
---
--- @type network.registerListener
---
local registerListener = function(channel, listener, context)
  if channels[channel] == nil then
    throw('Listener registration failed, unknown channel "%s"', channel)
  end

  if channels[channel].internal then
    if channels[channel].owner ~= context then
      throw('Listener registration failed, channel "%s" is protected', channel)
    end
  end

  if context and listener.identifier then
    listener.identifier = string.format('%s:%s', context.identifier,
                            listener.identifier)
  end

  channels[channel]:registerListener(listener.callback, listener.identifier)
end

---
--- ?
---
--- @type network.removeListener
---
local removeListener = function(channel, identifier, context)
  if channels[channel] == nil then
    throw('Listener removal failed, unknown channel "%s"', channel)
  end

  if context then
    identifier = string.format('%s:%s', context.identifier, identifier)
  end

  channels[channel]:removeListener(identifier)
end

---
--- ?
---
--- @type network.invokeChannel
---
local invokeChannel = function(name, payload, context)
  if channels[name] == nil then
    throw('Transmission failed, unknown channel "%s"', name)
  end

  if channels[name].owner ~= context then
    throw(
      'Transmission failed, the calling context (%s) does not own channel "%s"',
      context.identifier, name)
  end

  channels[name]:invokeListeners(payload, channels[name].async)
end

--
-- Expose the functions to the framework context.
--

framework.export('channel/reserve', reserveChannel)
framework.export('channel/register-listener', registerListener)
framework.export('channel/remove-listener', removeListener)
framework.export('channel/invoke', invokeChannel)

--
-- Reserve the channels used by the framework.
--

reserveChannel('PLUGIN_ADDED', { async = false, internal = true })
