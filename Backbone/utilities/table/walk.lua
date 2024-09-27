--[[~ Utility: Table Traversal ~

  Version: 1.0.0 | Updated: 2024/09/26

  This module provides a utility for traversing nested tables using a list of keys.
  It allows optional control over how missing keys are handled, including strict 
  error handling, building missing tables, or exiting when a key is not found.

]]

---
--- Traverses a table by following a list of keys (steps). The behavior of the function
--- can be adjusted through the `options` parameter, which controls how missing keys
--- are handled: strict mode throws an error, exit mode returns nil, and build mode
--- creates new tables for missing keys.
---
---@param target table "The table to traverse."
---@param steps string[] "A list of keys representing the traversal path."
---@param options? { mode: 'exit'|'build'|'strict' }
---
_G.traverseTable = function(target, steps, options)
  options = options or {}
  options.mode = options.mode or 'exit'

  if type(target) ~= 'table' then
    throw 'Target must be a table.'
  end

  local history = {}
  local reference = target
  for index, step in ipairs(steps) do
    table.insert(history, step)

    if reference[step] == nil then
      if options.mode == 'strict' then
        throw('Invalid path: %s', table.concat(history, '.'))
      end

      if options.mode == 'exit' then
        return nil
      end

      reference[step] = {}
    end

    reference = reference[step] --[[@as table]]
  end

  return reference
end
