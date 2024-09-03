--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Context
local addonId, context = ...

local immutable = context:import('table/immutable') --[[@as ImmutableTable]]

--
-- ?
--
--- @type API
--
_G.cogspinner = immutable(
  {
    --
    -- ?
    --

    createPlugin = function()
      ---@diagnostic disable-next-line: missing-return
    end,

    --
    -- ?
    --
    utility =
    {
      --
      -- ?
      --
      table = { immutable = immutable }
    }

  } --[[@as API]]
)
