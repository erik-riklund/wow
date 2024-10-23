--[[~ Utility: Table Traversal ~
  Updated: 2024/10/23 | Author(s): Erik Riklund (Gopher)
]]

---
--- Navigates through a nested table using a series of steps, returning the final 
--- table reference. Depending on the options, it can create missing steps or 
--- cancel the process if a link is missing.
---
---@param target table
---@param steps string[]
---@param options? { mode: 'exit'|'build'|'strict' }
---
---@return table?
---
backbone.utilities.traverseTable = function(target, steps, options)
  local reference = target

  local stepsTaken = {}
  for _, step in ipairs(steps) do
    if type(reference[step]) ~= 'table' then
      if options and options.mode == 'strict' then
        backbone.throwException(
          'Table traversal failed, missing link @ %s/%s',
          table.concat(stepsTaken, '/'),
          step
        )
      elseif options and options.mode == 'build' then
        reference[step] = {} -- missing steps are created in build mode.
      else
        return nil -- in exit mode the process is cancelled.
      end
    end

    reference = reference[step] --[[@as table]]
    stepsTaken[#stepsTaken + 1] = step
  end

  return reference
end
