--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, context
local addon, framework = ...

-- #region << imports >>
--- @type listenerManager.constructor
local createListenerManager = framework.import('shared/listeners')
-- #endregion

---
--- ?
---
--- @type table<string, network.channel>
---
local channels = {}

---
--- ?
---
--- @type network.controller
---
local controller = {
  --
  -- ?
  --

  reserveChannel = function(name, options)
    if channels[name] ~= nil then
      throw('Channel registration failed, "%s" already exists', name)
    end

    channels[name] = mergeTables(createListenerManager(), options or {})
  end,

  --
  -- ?
  --

  registerListener = function(channel, listener, context)
    if channels[channel] == nil then
      throw('Listener registration failed, unknown channel "%s"', channel)
    end

    if channels[channel].internal then
      if channels[channel].owner ~= ((context and context.identifier) or nil) then
        throw('Listener registration failed, channel "%s" is protected', channel)
      end
    end

    if context and listener.identifier then
      listener.identifier = string.format('%s:%s', context.identifier,
                                          listener.identifier)
    end

    channels[channel]:registerListener(listener.callback, listener.identifier)
  end,

  --
  -- ?
  --

  removeListener = function(channel, identifier, context)
    if channels[channel] == nil then
      throw('Listener removal failed, unknown channel "%s"', channel)
    end

    if context then
      identifier = string.format('%s:%s', context.identifier, identifier)
    end

    channels[channel]:removeListener(identifier)
  end,

  --
  -- ?
  --

  invokeChannel = function(name, payload, context)
    if channels[name] == nil then
      throw('Transmission failed, unknown channel "%s"', name)
    end

    if channels[name].owner ~= context.identifier then
      throw('Transmission failed, the calling context (%s) '
             .. 'does not own channel "%s"', context.identifier, name)
    end

    channels[name]:invokeListeners(payload, channels[name].async)
  end
}

--
-- Reserve the channels used by the framework.
--
controller.reserveChannel('PLUGIN_ADDED', { async = false, internal = true })

-- #region << exports >>
framework.export('network/controller', controller)
-- #endregion
