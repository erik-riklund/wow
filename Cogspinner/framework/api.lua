--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ... --- @cast context core.context

--#region (context imports)

--- @type plugin.manager
local plugin_manager = context:import('modules/plugin-manager')

--#endregion

--
-- ?
--
_G.cogspinner =
{
  --
  --- ?
  ---
  --- @param id string
  --- @param options plugin.options
  --
  plugin = function(id, options)
    return plugin_manager:create_context(id, options)
  end,

  --
  -- ?
  --
  utilities =
  {
    --
    -- ?
    --
    collections =
    {
      --- @type utilities.collections.list
      list = context:import('utilities/collections/list'),

      --- @type utilities.collections.map
      map = context:import('utilities/collections/map')
    }
  }
}
