--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Context
local addon, framework = ...
local type             = _G.type

local network          = framework.import('module/network') --[[@as Network]]

--
-- Provides a simplified interface for plugin interaction with the network communication system
-- by encapsulating the plugin's context for easier channel management and message transmission.
--
--- @type NetworkApi
--
local networkApi       =
{
  --
  -- Registers a listener function to the specified channel for the plugin,
  -- allowing it to receive messages broadcast on that channel.
  --
  registerChannelListener = function(self, channel, listener)
    network.registerListener(channel, listener, self.name)
  end,

  --
  -- Unregisters a listener from a specific channel using its unique identifier.
  --
  removeChannelListener = function(self, channel, identifier)
    network.removeListener(channel, identifier, self.name)
  end,

  --
  -- Broadcasts a message on the specified channel, invoking all registered
  -- listeners with the provided arguments.
  --
  triggerChannel = function(self, channel, arguments)
    network.triggerChannel(channel, arguments, self.name)
  end
}

--
-- Registers a listener within the framework to handle the 'PLUGIN_ADDED' event.
-- When a new plugin is created, this listener sets up its network API and reserves
-- any channels specified in the plugin's options.
--
network.registerListener(
  'PLUGIN_ADDED',
  {
    --
    --- @param plugin Plugin
    --- @param options PluginOptions
    --
    callback = function(plugin, options)
      --~ Integrate the network API into the new plugin's context.

      plugin.triggerChannel = networkApi.triggerChannel
      plugin.registerChannelListener = networkApi.registerChannelListener
      plugin.removeChannelListener = networkApi.removeChannelListener

      --~ If the plugin has defined channels in its options, reserve them.

      if options.channels and type(options.channels) == 'table' then
        for index, channel in ipairs(options.channels) do
          if type(channel) == 'table' then
            network.reserveChannel(
              channel.name, { async = channel.async, internal = channel.internal }, plugin.name
            )
          end
        end
      end
    end
  }
)
