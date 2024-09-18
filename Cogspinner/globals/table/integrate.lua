--
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- Integrates the contents of one table into another,
--- optionally overwriting existing keys in the target table.
---
--- @param target     table    The table to receive the integrated elements.
--- @param source     table    The table providing the elements to be integrated.
--- @param overwrite? boolean  If true, allows overwriting existing keys in the target table. Defaults to `false`.
---
_G.integrateTable = function(target, source, overwrite)
  if type(target) ~= 'table' or type(source) ~= 'table' then
    throw('Invalid argument type, expected both "target" and "source" to be tables')
  end

  for key, value in pairs(source) do
    if overwrite ~= true and target[key] ~= nil then
      throw('Table integration failed, "target" already contains the key "%s"', key)
    end

    target[key] = value
  end

  return target
end
