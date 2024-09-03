--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local error  = _G.error
local string = _G.string

--
-- Raises a formatted error, halting execution and providing a detailed error message.
-- Useful for signaling critical issues or unexpected conditions during development or runtime.
-- Supports string formatting to include dynamic values in the error message.
--
--- @param message string The base error message, potentially containing placeholders like "%s" or "%d".
--- @param ... string | number Optional values to be inserted into the placeholders in the `message`.
--
_G.exception = function(message, ...)
  error((... and string.format(message, ...)) or message, 3)
end
