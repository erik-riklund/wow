--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Context
local addon, framework = ...

local exception        = _G.exception
local type             = _G.type



--
-- ?
--
--- @type CallbackHandler
--
local registerCallback = function(callback, options)
  if type(callback) ~= 'function' then
    exception('?')
  end

  if options and type(options) ~= 'table' then
    exception('?')
  end


end

--
-- ?
--
framework.export('core/callback', registerCallback)
