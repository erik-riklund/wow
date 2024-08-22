--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ... --- @cast context core.context

--#region (context imports)

--- @type module.network
local network = context:import('module/network')

--- @type utility.collection.map
local map = context:import('utility/collection/map')

--- @type plugin.context
local framework = context:import('resource/internal/plugin')

--#endregion

--
-- Reserves the 'PLUGIN_ADDED' channel for internal use by the framework.
-- This channel is used to notify other system modules about new plugin creations.
--

network:reserve(
  framework, {
    { name = 'PLUGIN_ADDED', internal = true }
  }
)

--
-- This module manages the lifecycle of plugins,
-- including their registration and initialization.
--

--- @type module.plugin
local plugin_manager =
{
  --
  -- A map to track registered plugins, using their identifiers as keys.
  -- The 'cogspinner' plugin is marked as already registered.
  --

  plugins = map({ cogspinner = true }),

  --
  -- Creates a new plugin context and broadcasts its creation to other modules.
  --

  create_context = function(self, id, options)
    --#region: Input validation and normalization
    -- We normalize the ID to lowercase for consistency and perform validation
    -- to ensure uniqueness and prevent naming conflicts.
    --#endregion

    id = string.lower(id)

    if self.plugins:has(id) then
      throw('Plugin registration failed: A plugin with the ID "%s" already exists.', id)
    end

    local plugin = { id = id }
    self.plugins:set(id, plugin)

    --#region: Plugin initialization and notification
    -- Broadcast the 'PLUGIN_ADDED' event, notifying other modules about the
    -- new plugin's creation and providing its context and options for potential
    -- initialization or extension.
    --#endregion

    network:transmit(framework, 'PLUGIN_ADDED',
      { plugin = plugin, options = options }
    )

    return plugin
  end
}

--
-- Exports the plugin manager, making it accessible to other framework modules.
--

context:export('module/plugins', plugin_manager)
