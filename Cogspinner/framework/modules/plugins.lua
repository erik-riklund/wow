--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ...
--- @cast context core.context

local string, throw = string, throw

--#region (framework context imports)

--- @type plugin.base_context
local framework = context:import('plugin')

--- @type module.network
local network = context:import('module/network')

--- @type utility.collection.map
local map = context:import('utility/collection/map')

--#endregion

--
-- Reserves the 'PLUGIN_ADDED' channel for internal framework communication.
-- This ensures that only the framework itself can transmit on this channel,
-- preventing potential conflicts or misuse by plugins.
--

network:reserve(
  framework, {
    { name = 'PLUGIN_ADDED', internal = true }
  }
)

--
-- This module manages the registration and initialization of plugins within the framework.
--

--- @type module.plugins
local plugin_manager =
{
  --
  -- A map to keep track of registered plugin IDs. Using a map allows for efficient
  -- existence checks and avoids potential duplicates.
  --

  plugins = map(),

  --
  -- Creates a new plugin context, registers it, and broadcasts its creation to other modules.
  --

  create_plugin = function(self, id, options)
    local normalized_id = self.normalize_id(id)

    if self.plugins:has(normalized_id) then
      throw('?')
    end

    --- @type plugin.base_context
    local plugin = { id = normalized_id }

    self.plugins:set(normalized_id, true)
    self.broadcast_new_plugin(plugin, options)

    return plugin --[[@as plugin.API]]
  end,

  --
  -- Broadcasts the creation of a new plugin to other modules via the 'PLUGIN_ADDED' channel.
  -- This allows other modules to react to the new plugin and potentially initialize resources
  -- or establish dependencies.
  --

  broadcast_new_plugin = function(plugin, options)
    network:transmit(framework, 'PLUGIN_ADDED',
      { plugin = plugin, options = options }
    )
  end,

  --
  -- Normalizes the plugin ID by converting it to lowercase. This ensures consistent
  -- handling of plugin IDs regardless of the original casing.
  --

  normalize_id = function(id)
    return string.lower(id)
  end
}

--
-- Exports the plugin_manager module, making it accessible to other parts of the framework.
--

context:export('module/plugins', plugin_manager)
