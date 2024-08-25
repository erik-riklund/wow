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
-- ?
--

network:reserve(
  framework, {
    { name = 'PLUGIN_ADDED', internal = true }
  }
)

--
-- ?
--

--- @type module.plugins
local plugin_manager =
{
  --
  -- ?
  --

  plugins = map(),

  --
  -- ?
  --

  create_plugin = function(self, id, options)
    local normalized_id = self.normalize_id(id)

    if self.plugins:has(normalized_id) then
      throw('?')
    end

    local plugin = { id = normalized_id }

    self.plugins:set(normalized_id, true)
    self.broadcast_new_plugin(plugin, options)

    return plugin
  end,

  --
  -- ?
  --

  broadcast_new_plugin = function(plugin, options)
    network:transmit(framework, 'PLUGIN_ADDED',
      { plugin = plugin, options = options }
    )
  end,

  --
  -- ?
  --

  normalize_id = function(id)
    return string.lower(id)
  end
}

--
-- ?
--

context:export('module/plugins', plugin_manager)
