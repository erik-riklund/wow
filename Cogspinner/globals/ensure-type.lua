--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- Verifies that a given value matches the expected Lua type(s), throwing an error
--- if there's a type mismatch. This function helps ensure type safety and provides
--- clear error messages during development.
--- 
--- @param label    string    A descriptive string identifying the value being checked, providing context in error messages.
--- @param value    unknown   The value whose type is to be verified.
--- @param expected lua.types A string representation of the expected Lua type for the value.
---
_G.ensureType = function(label, value, expected)
  local actual = type(value)

  if actual ~= expected then
    throw('Invalid argument type (%s), expected `%s` (recieved `%s`)', label, expected, actual)
  end
end
