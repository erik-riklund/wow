
--[[~ Updated: 2024/11/30 | Author(s): Gopher ]]

--- @param target table The base table to traverse.
--- @param steps Vector A `Vector` of keys indicating the traversal path.
--- @param mode? 'exit'|'build' Determines the behavior during traversal.
--- @return table? reference 
---?
_G.traverseTable = function (target, steps, mode)
  if type (target) ~= 'table' then
    error ('Expected the target to be a table.', 3)
  end

  local reference = target
  for index, key in steps:getIterator() do
    ---@cast key string

    if type (reference[key]) ~= 'table' then
      if reference[key] ~= nil then
        return nil -- non-table value encountered, returning `nil`.
      end

      if mode ~= 'build' then return nil end  -- cancel the process in `exit` mode.
      reference[key] = {} -- create missing steps in `build` mode.
    end

    reference = reference[key] --[[@as table]]
  end

  return reference
end
