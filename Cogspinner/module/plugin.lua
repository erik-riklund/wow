--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Context
local addonId, context = ...

local record           = context:import('collection/record') --[[@as RecordConstructor]]

--
-- ?
--

--- @type PluginManager
local manager          =
{
  --
  -- ?
  --

  plugins = record(),

  --
  -- ?
  --

  createPlugin = function(self)
    ---@diagnostic disable-next-line: missing-return
  end
}

--
-- ?
--

context:export('module/plugin', manager)
