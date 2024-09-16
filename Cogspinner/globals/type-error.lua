--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- ?
--- 
--- @param label    string    A descriptive string used to identify the invalid value.
--- @param expected lua.types A string representation of the expected Lua type.
--- @param recieved lua.types A string representation of the recieved Lua type.
---
_G.throwTypeError = function(label, expected, recieved)
  throw('Invalid argument type (%s), expected `%s` (recieved `%s`)', label, expected, recieved)
end
