--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string
local addon_name = ...

-- ?
cogspinner.locale(
  {
    locale = 'enUS',
    default = true,
    plugin = addon_name,
    
    content =
    {
      TEST = 'A dummy text used to demonstrate a localized string'
    }
  }
)
