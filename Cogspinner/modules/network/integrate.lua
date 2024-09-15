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
--- @type network.controller
local network = framework.import('network/controller')
-- #endregion

---
--- The API object providing methods for plugins to interact
--- with communication channels within the framework.
---
--- @type network.api
---
local api = {
  invokeChannel = function(self, name, payload)
    network.invokeChannel(name, payload, self)
  end,

  registerChannelListener = function(self, channel, listener)
    network.registerListener(channel, listener, self)
  end,

  removeChannelListener = function(self, channel, identifier)
    network.removeListener(channel, identifier, self)
  end
}

--
-- A listener triggered when a new plugin is added to the system. It extends the
-- plugin's capabilities by adding methods for interacting with channels.
--
-- Additionally, it reserves channels specified in the plugin's options.
--
network.registerListener('PLUGIN_ADDED', {
  --- @param plugin plugin
  --- @param options plugins.createPlugin.options
  callback = function(plugin, options)
    -- Inherit the methods from the network API prototype.
    integrateTable(plugin, api)

    -- Reserve the channels specified in the provided options,
    -- ensuring they are available for use by the plugin.
    
    if type(options.channels) == 'table' then
      for index, channel in ipairs(options.channels) do
        network.reserveChannel(channel.name, {
          async = channel.async,
          internal = channel.internal,
          owner = plugin.identifier
        })
      end
    end
  end
})
