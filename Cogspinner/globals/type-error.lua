--
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- Specialized error handling function tailored for type errors. It throws an error with
--- a formatted message by clearly indicating the label of the value with the type mismatch,
--- the expected type(s), and the actual type received, aiding in debugging type-related issues.
--- 
--- @param label    string
--- @param expected string
--- @param recieved string
---
_G.throwTypeError = function(label, expected, recieved)
  throw('Invalid argument type (%s), expected `%s` (recieved `%s`)', label, expected, recieved)
end
