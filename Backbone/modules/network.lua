---@type string, Repository
local addon, repository = ...

--[[~ Module: Network ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/07

  Provides a network system for communication between plugins, supporting both 
  internal and external channels. The module allows registering, invoking, and 
  removing listeners for specific channels with options for asynchronous execution 
  and ownership control.

]]

---@type hashmap<string, Channel>
local channels = {}

---
--- Creates a new network channel with a unique name.
---
---@param name string
---@param options { internal?: boolean, async?: boolean }
---@param owner? Plugin
---
local createChannel = function(name, options, owner)
  if channels[name] ~= nil then
    backbone.throwError('Failed to create channel "%s" (non-unique name).', name) --
  end

  if type(options) ~= 'table' then options = {} end

  local channel = backbone.createListenableComponent() --[[@as Channel]]
  channel.async = (options.async ~= false and true) or false
  channel.internal = (options.internal == true)
  channel.owner = owner

  channels[name] = channel
end

---
--- Invokes the registered listeners for the specified channel.
---
---@param channel string
---@param arguments? unknown[]
---@param caller? Plugin
---
local invokeListeners = function(channel, arguments, caller)
  if type(arguments) ~= 'table' then arguments = {} end

  -- In development mode, missing channels trigger an exception.
  if backbone.getEnvironment() == 'development' and channels[channel] == nil then
    backbone.throwError('Listener invocation failed, unknown channel "%s".', channel)
  end

  if channels[channel] ~= nil then
    -- [explain this section]

    if channels[channel].internal then
      if channels[channel].owner ~= caller then
        if backbone.getEnvironment() == 'development' then
          backbone.throwError('Attempt to invoke internal channel "%s" (%s)', channel, caller --[[@as Plugin]].name)
        end

        return -- exit the process early in production mode.
      end
    end

    channels[channel]:invokeListeners(arguments, channels[channel].async)
  end
end

---
--- Registers a new listener to the specified channel.
---
---@param channel string
---@param identifier string
---@param callback function
---@param options? { owner?: Plugin, persistent?: boolean }
---
local registerListener = function(channel, identifier, callback, options)
  if type(options) ~= 'table' then options = {} end

  -- In development mode, missing channels trigger an exception.
  if backbone.getEnvironment() == 'development' and channels[channel] == nil then
    backbone.throwError('Listener registration failed, unknown channel "%s".', channel)
  end

  if channels[channel] ~= nil then
    if options.owner then identifier = string.format('%s.%s', options.owner.name, identifier) end
    channels[channel]:registerListener(identifier, callback, options.persistent)
  end
end

---
--- Removes a listener from the specified channel using its unique identifier.
---
local removeListener = function(channel, identifier, owner)
  if owner then identifier = string.format('%s.%s', owner.name, identifier) end

  -- In development mode, missing channels trigger an exception.
  if backbone.getEnvironment() == 'development' and channels[channel] == nil then
    backbone.throwError('Listener removal failed, unknown channel "%s".', channel)
  end

  if channels[channel] ~= nil then channels[channel]:removeListener(identifier) end
end

-- Implementations of the network plugin API methods.

---@type NetworkApi
local api = {
  createChannel = function(self, name, options)
    createChannel(name, options, self or {}) --
  end,
  invokeChannelListeners = function(self, channel, arguments)
    invokeListeners(channel, arguments, self or {}) --
  end,
  registerChannelListener = function(self, channel, identifier, callback, persistent)
    registerListener(channel, identifier, callback, { owner = self or {}, persistent = persistent })
  end,
  removeChannelListener = function(self, channel, identifier)
    removeListener(channel, identifier, self or {}) --
  end,
}

-- Create the internal `PLUGIN_ADDED` channel, allowing modules to integrate
-- their plugin API methods into newly registered plugin contexts.

createChannel('PLUGIN_ADDED', { internal = true, async = false })

-- Registers the listener responsible for integrating the network API
-- into newly registered plugin contexts.

registerListener(
  'PLUGIN_ADDED',
  'NETWORK_API_INTEGRATION',
  ---@param plugin Plugin
  function(plugin) utilities.integrateTable(plugin, api) end
)

-- Expose the invocation method internally, allowing other modules to utilize it.
repository.invokeChannelListeners = invokeListeners
