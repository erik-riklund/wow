--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local addon, context = ...

--- @cast context framework.context

local ipairs, table, throw, type =
    ipairs, table, throw, type

--#region [function: walk]

--
--- Traverses a nested table (like a directory structure) using a list of keys,
--- returning a reference to the target table if the path is complete or `build_mode`
--- is enabled (which will create missing intermediate tables), otherwise `nil`.
--
--- @type framework.utilities.table.walk
--
local function walk(target, keys, options)
  if type(target) ~= 'table' or type(keys) ~= 'table' then
    throw("Expected tables for both 'target' and 'keys'")
  end

  local reference = target
  options = options or { build_mode = false }

  --#region: Obtain the reference for the given 'path'
  -- Iterates over the segments of the given `path`, using each segment to navigate
  -- deeper into the `target` table. If a segment is missing in the table and `build_mode`
  -- is true, an empty table is created at that position to continue the traversal.
  --
  -- If `build_mode` is false, the process is aborted when a missing segment is encountered.
  --#endregion

  for i, ancestor in ipairs(keys) do
    if not reference[ancestor] then
      if not options.build_mode then
        return nil -- note: cancel the process when not in build mode.
      end

      reference[ancestor] = {}
    end

    if type(reference[ancestor]) ~= 'table' then
      local path = table.concat(keys, '.', 1, i)
      throw('Unexpected non-table value encountered at `%s`', path)
    end

    reference = reference[ancestor] --[[@as table]]
  end

  return reference
end

--#endregion

context:export('utilities.table.walk', walk)
