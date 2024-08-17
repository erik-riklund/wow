--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local addon, context = ...

--- @cast context framework.context

--#region [metatable: list]

--
--- ?
---
--- @type list
--
local __list =
{
  items = {},

  --
  --- ?
  --
  get = function()
    ---@diagnostic disable-next-line: missing-return
  end
}

--#endregion

--#region [function: list]

--
--- ?
--- 
--- @type framework.utilities.collections.list
--
local function list(initial_values)
  ---@diagnostic disable-next-line: missing-return
end

--#endregion

context:export('utilities.collections.list', list)
