--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|
--
--- @type string, Context
local addon, framework = ...

--
--
-- Merges multiple tables into a single table, prioritizing values from later tables
-- in case of key conflicts. This provides a simple way to combine configurations or
-- data structures from different sources.
--
--
--- @type TableMerger
--
local mergeTables = function(base, extension, ...)
  local mergedTable = {}
  local targetTables = { base, extension, ... }

  for index, target in ipairs(targetTables) do
    for key, value in pairs(target) do
      mergedTable[key] = value
    end
  end

  return mergedTable
end

--
-- Expose the `mergeTables` function to the framework context.
--
framework.export('table/merge', mergeTables)
