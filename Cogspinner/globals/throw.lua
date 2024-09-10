--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- Raise an exception with a detailed error message.
--- 
--- @param message string The core error message, potentially including placeholders.
--- @param ... string | number Optional values to substitute into the message for enhanced clarity.
---
_G.throw = function(message, ...)
  error((... and string.format(message, ...)) or message, 3)
end
