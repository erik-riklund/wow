--
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            

---
--- Throws an error upon table traversal failure, providing a descriptive message and the traversal path.
---
--- @param message string    A message detailing the specific cause of the traversal failure.
--- @param steps   string[]  An array representing the path taken within the table before the failure.
---
---
local traverseException = function(message, steps)
  throw('Table traversal failed, ' .. message, table.concat(steps, '/'))
end

---
--- Traverses a nested table structure using a sequence of keys (steps),
--- with options to create missing steps or enforce strict traversal rules.
---
--- @param target table             The table that will be traversed.
--- @param steps  unknown[]         An array of keys defining the location to access within the table.
--- @param mode?  'build'|'strict'  (optional) `build` creates missing steps in the path if they do not exist, while `strict` throws an error if any step in the path is missing.
--- 
--- @return table?
---
_G.traverseTable = function(target, steps, mode)
  if type(target) ~= 'table' then
    throw('Invalid argument type, expected "target" to be a table')
  end

  local stepsTaken = {}
  local reference = target

  for index, key in ipairs(steps) do
    table.insert(stepsTaken, tostring(key))

    if reference[key] == nil then
      if mode ~= 'build' then
        if mode == 'strict' then
          -- in strict mode, we throw an exception!
          traverseException('missing step at "%s"', stepsTaken)
        end

        return -- cancel the process.
      end

      reference[key] = {} -- create the missing step in 'build mode'.
    end

    if type(reference[key]) ~= 'table' then
      traverseException('non-table value encountered at "%s"', stepsTaken)
    end

    reference = reference[key] --[[@as table]]
  end

  return reference
end
