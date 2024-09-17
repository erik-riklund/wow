--
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- Streamlines error handling and debugging by facilitating
--- the construction of clear, informative error messages.
--- 
--- @param message string         The core error message, potentially including placeholders.
--- @param ...     string|number  (optional) Values to substitute into the message for enhanced clarity.
---
_G.throw = function(message, ...)
  error((... and string.format(message, ...)) or message, 3)
end
