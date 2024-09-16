--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- Splits a string into an array of substrings using a specified separator.
--- 
--- @param target    string The string to be split.
--- @param separator string The character or string used to delimit the substrings.
--- 
--- @return string[] "An array containing the substrings resulting from the split operation."
---
_G.splitString = function(target, separator)
  return { string.split(separator, target) }
end
