--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ...
--- @cast context core.context

local setmetatable, throw, type =
    setmetatable, throw, type

--
-- This module provides a function to create immutable (read-only) proxies for tables,
-- preventing accidental modification of their contents or nested tables.
--

--- @type utility.table.immutable
local immutable

immutable = function(target)
  if type(target) ~= 'table' then
    throw('Invalid argument type for "immutable". Expected a table.')
  end

  --- @type utility.table.immutable.proxy
  local proxy =
  {
    --
    -- This metatable method is triggered when attempting to assign a new value to an
    -- index in the proxy table. We throw an error to enforce immutability.
    --

    __newindex = function()
      throw('Attempt to modify a read-only table.')
    end,

    --
    -- This metatable method is triggered when accessing an index in the proxy table.
    -- It retrieves the value from the original table and, if it's a table itself, recursively
    -- applies immutability to it to ensure nested tables are also read-only.
    --

    __index = function(self, key)
      local value = target[key]

      return (type(value) == 'table' and immutable(value)) or value
    end
  }

  return setmetatable({}, proxy)
end

--
-- Exports the `immutable` function to the framework context,
-- making it available to other modules.
--

context:export('utility/table/immutable', immutable)
