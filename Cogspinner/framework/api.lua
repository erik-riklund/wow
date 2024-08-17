--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ... ---@cast context core.context

--#region: locally scoped variables
--#endregion

_G.cogspinner =
{
  utilities = {
    collections = {
      ---@type utilities.collection.list
      list = context:import('utilities.collections.list')
    }
  }
}
