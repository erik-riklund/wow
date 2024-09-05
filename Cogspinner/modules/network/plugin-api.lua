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
-- ?
--
--- @type NetworkApi
--
local networkApi       =
{
  --
  -- ?
  --
  registerChannelListener = function(self, channel, listener) end,

  --
  -- ?
  --
  removeChannelListener = function(self, channel, identifier) end,

  --
  -- ?
  --
  triggerChannel = function(self, channel, arguments) end
}

--
-- ?
--
network.registerListener(
  'PLUGIN_ADDED',
  {
    --
    --- @param plugin Plugin
    --- @param options PluginOptions
    --
    callback = function(plugin, options)
      --~ ?

      plugin.registerChannelListener = networkApi.registerChannelListener
      plugin.removeChannelListener = networkApi.removeChannelListener
      plugin.triggerChannel = networkApi.triggerChannel

      --~ ?

      if options.channels and type(options.channels) == 'table' then
        -- todo: implement channel reservations.
      end
    end
  }
)
