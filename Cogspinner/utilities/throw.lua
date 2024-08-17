--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region: locally scoped variables
local error, string = error, string
--#endregion

--#region [function: throw]

--
--- Raises a formatted error message, optionally using provided values to fill in placeholders
--- within the message string. The error is raised from the caller's context.
---
--- @param exception string The error message template.
--- @param ... string | number (optional) Placeholder values to insert into the message.
--
_G.throw = function(exception, ...)
  error((... and string.format(exception, ...)) or exception, 3)
end

--#endregion
