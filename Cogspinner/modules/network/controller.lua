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

--- @type table.mergeTables
local mergeTables = framework.import('table/merge')

---
--- Maintains a collection of all registered channels, each uniquely identified.
---
--- @type table<string, network.channel>
---
local channels = {}

---
--- Registers a new channel, enforcing name uniqueness.
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
--- Registers a listener to the specified channel, verifying channel
--- existence and, if protected, caller authorization.
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
    listener.identifier = string.format(
                           '%s:%s', context.identifier, listener.identifier
                          )
  end

  channels[channel]:registerListener(listener.callback, listener.identifier)
end

---
--- Using its unique identifier, remove a listener from the specified channel.
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
--- Invokes the specified channel, triggering its listeners and optionally
--- passing a payload. The caller's context is verified to ensure only the
--- owning context can invoke the channel.
---
--- @type network.invokeChannel
---
local invokeChannel = function(name, payload, context)
  if channels[name] == nil then
    throw('Transmission failed, unknown channel "%s"', name)
  end

  if channels[name].owner ~= context then
    throw(
     'Transmission failed, the calling context (%s) ' ..
      'does not own channel "%s"', context.identifier, name
    )
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
