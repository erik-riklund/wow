--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|
--
--- @type string, table
local addon, context = ...

local plugin = cogspinner.createPlugin(addon)

plugin:onInitialize(function() print('Hello world') end)

plugin:registerEventListener('LOOT_READY', {
  callback = function() print('Hello Looter') end,
  recurring = false
})
