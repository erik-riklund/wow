--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- Checks if a given value is a non-empty string.
--- 
--- @param target string The value to check.
--- 
_G.notEmptyString = function(target)
  if target and type(target) ~= 'string' then
    throw('Invalid argument type, expected "target" to be a string')
  end

  return (target ~= nil and string.len(target) > 0)
end
