--[[~ Utility: Table Traversal ~

  Version: 1.0.0 | Updated: 2024/09/30

  This utility provides functionality to traverse nested tables based on a series of keys. It 
  supports different traversal modes such as exiting early, strictly validating paths, or 
  automatically building missing table structures during traversal.

  Features:

  - Traverse tables using a list of keys.
  - Support different modes: exit early, build missing structures, or strictly validate.
  - Return the final table reference based on the traversal path.

]]

---
--- Traverses a nested table based on a list of keys (`steps`). The function can operate in
--- different modes based on the `options` provided: 'exit' mode returns `nil` if the path is
--- not found, 'strict' mode throws an error if the path is invalid, and 'build' mode automatically
--- creates missing tables along the path.
---
---@param target table "The table to traverse."
---@param steps string[] "A list of keys representing the traversal path."
---@param options? { mode: 'exit'|'build'|'strict' } "Optional traversal mode: 'exit', 'build', or 'strict'."
---
---@return table? "The final table reference based on the traversal path, or `nil` in 'exit' mode."
---
_G.traverseTable = function(target, steps, options)
  options = options or {}
  options.mode = options.mode or 'exit'

  if type(target) ~= 'table' then
    throw 'Target must be a table.'
  end

  -- Initialize the `history` to keep track of the current path during traversal. `reference`
  -- is used to hold the current table as the function progresses through the steps.

  local history = {}
  local reference = target

  for index, step in ipairs(steps) do
    table.insert(history, step)

    if type(reference[step]) ~= 'table' then
      throw(
        'Table traversal failed, encountered non-table value at "%s"',
        table.concat(history, '/')
      )
    end

    -- If the current key (`step`) does not exist in the table, handle it based on the selected
    -- traversal mode. In 'strict' mode, an error is thrown with the current path. In 'exit' mode,
    -- the function returns `nil`. In 'build' mode, a new table is created at the missing key.

    if reference[step] == nil then
      if options.mode == 'strict' then
        throw('Table traversal failed, invalid path: "%s".', table.concat(history, '/'))
      end

      if options.mode == 'exit' then
        return nil -- Return `nil` in 'exit' mode.
      end

      reference[step] = {} -- Automatically create a new table in 'build' mode.
    end

    reference = reference[step] -- Move to the next level of the table structure.
  end

  return reference -- Return the final table reference after successful traversal.
end
