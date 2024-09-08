--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|
--
--- @type string, Context
local addon, framework = ...

local exception = _G.exception
local string = _G.string
local type = _G.type

--
-- Checks if a given string starts with a specific substring.
--
--- @type InitialSubstring
--
local beginsWith = function(target, match)
  if type(target) ~= 'string' or type(match) ~= 'string' then
    exception('Invalid argument types. Expected both "target" and "match" to be strings.')
  end

  return (string.sub(target, 1, string.len(match)) == match)
end

--
-- Expose the function to the framework context.
--
framework.export('string/begins', beginsWith)
