--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- Merge multiple tables into a single table, appending the elements
--- of each table in the order they are provided.
--- 
--- @param first table
--- @param second table
--- @param ... table
---
_G.mergeTables = function(first, second, ...)
  local mergedTable = {}

  for index, target in ipairs({ first, second, ... }) do
    for key, value in pairs(target) do mergedTable[key] = value end
  end

  return mergedTable
end