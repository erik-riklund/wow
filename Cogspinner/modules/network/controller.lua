--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework.context
local addon, framework = ...

-- #region << imports >>
--- @type listenerManager.constructor
local createListenerManager = framework.import('shared/listeners')
-- #endregion

---
--- The central repository for registered channels and their associated
--- options (owner, execution type, and accessibility level).
---
--- @type table<string, network.channel>
---
local channels = {}

---
--- The network controller provides methods to interact with the network.
--- These methods allow for channel reservation, listener registration and
--- removal. Additionally, they enable channel transmissions, which can
--- optionally include payloads.
---
--- @type network.controller
---
local controller = {
  --
  -- This method reserves channels, ensuring their uniqueness. It is primarily invoked
  -- during plugin registration if the plugin has specified channels in its options.
  --
  reserveChannel = function(name, options)
    if channels[name] ~= nil then
      throw('Channel registration failed, "%s" already exists', name)
    end

    channels[name] = mergeTables(createListenerManager(), options or {})
  end,

  --
  -- Handles listener registration. It verifies channel existence and protection level
  -- before registering the listener. If an identifier and plugin context are provided,
  -- the identifier is modified to include the plugin's name for uniqueness.
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
      listener.identifier =
       string.format('%s:%s', context.identifier, listener.identifier)
    end

    channels[channel]:registerListener(listener)
  end,

  --
  -- Removes listeners after verifying channel existence and, if a plugin context is provided,
  -- modifying the given identifier by including the name of the plugin.
  --
  removeListener = function(channel, identifier, context)
    if channels[channel] == nil then
      throw('Listener removal failed, unknown channel "%s"', channel)
    end

    if context then identifier = string.format('%s:%s', context.identifier, identifier) end

    channels[channel]:removeListener(identifier)
  end,

  --
  -- Invokes the listeners of a specified channel, provided it exists and is owned by
  -- the calling context. An optional payload may be included in the transmission.
  --
  invokeChannel = function(name, payload, context)
    if channels[name] == nil then
      throw('Transmission failed, unknown channel "%s"', name)
    end

    if channels[name].owner ~= ((context and context.identifier) or nil) then
      throw('Transmission failed, the calling context (%s) does not own channel "%s"',
            context.identifier, name)
    end

    channels[name]:invokeListeners(payload, channels[name].async)
  end
}

-- #region << exports >>
framework.export('network/controller', controller)
-- #endregion
