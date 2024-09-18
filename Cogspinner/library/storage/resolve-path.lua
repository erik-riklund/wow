--
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework
local addon, framework = ...

---
--- Facilitates navigation within nested data structures by parsing a path string
--- into its constituent parts: parent steps and final variable name.
--- 
--- @type library.resolveVariablePath
---
local resolveVariablePath = function(path)
  local steps = splitString(path, '/')
  local variable = (#steps > 1 and table.remove(steps, #steps)) or path

  return ((variable ~= path and steps) or nil), variable --[[@as string]]
end

--
framework.export('library/resolve-path', resolveVariablePath)
