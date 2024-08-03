--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

-- This is an example addon which utilize every aspect of the Cogspinner framework.
-- It's used for testing during development and to provide a demonstration of how you
-- can use the various modules for your own projects.

-- ?
local plugin = cogspinner.plugin('DevAddon', {
  -- ?
  storage = { account = true, character = true }
})

-- ?
plugin:onload(
  function()
    error('Hello world from the development plugin!')
  end
)
