--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local error = error
local string = string

--
-- This function provides a convenient way to raise errors with formatted messages.
-- It allows for optional string formatting using the provided arguments, enhancing 
-- the clarity of error messages. The error is raised from the caller's context,
-- aiding in debugging by pointing to the relevant code location.
--

--- @type Throw
_G.throw = function(exception, ...)
  error((... and string.format(exception, ...)) or exception, 3)
end
