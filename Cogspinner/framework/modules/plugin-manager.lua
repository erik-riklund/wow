--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local addon, context = ... --- @cast context core.context

--#region (context imports)

--- @type utilities.collections.list
local list = context:import('utilities/collections/list')

--#endregion

--
-- ?
--

--- @type plugin.manager
local plugin_manager =
{
  --
  -- ?
  --

  plugins = list(),

  --
  -- ?
  --

  create_context = function(self, id, options)
    ---@diagnostic disable-next-line: missing-return
  end
}

--
-- ?
--

context:export('modules/plugin-manager', plugin_manager)
