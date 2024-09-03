--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local exception                          = _G.exception
local setmetatable                       = _G.setmetatable
local table                              = _G.table
local type                               = _G.type

--
-- This metatable provides the underlying behavior for list objects.
--
local list                               =
{
  __index =
  {
    --
    -- This table holds the actual values of the list. Using a plain table allows for
    -- efficient indexing and iteration, essential for list operations.
    --
    values = {},

    --
    -- Retrieves an element from the list by its index.
    --
    getElementAt = function(self, index)
      if index > #self.values then
        exception('Index out of range, verify the list size.')
      end

      return self.values[index]
    end,

    --
    -- Inserts a value into the list at the specified position, or at the end if no position
    -- is provided.  We validate the position to ensure it's within the valid range of the list,
    -- preventing potential errors.
    --
    insert = function(self, value, position)
      if position and type(position) ~= 'number' then
        exception('Invalid position for insertion (expected a number).')
      end

      local lastElementIndex = #self.values
      position = position or (lastElementIndex + 1)

      if position > (lastElementIndex + 1) then
        exception('Invalid position for insertion (the position is beyond the end of the list).')
      end

      table.insert(self.values, position, value)
    end,

    --
    -- Removes and returns the value at the specified position, or the last value if no position is
    -- provided. An error is thrown if the position is invalid.
    --
    removeElementAt = function(self, position)
      if position and not self.values[position] then
        exception('List index out of bounds. Cannot remove a non-existent element.') 
      end

      return table.remove(self.values, position or #self.values)
    end,

    --
    -- Searches the list for the given value and returns its index if found. We prevent searching
    -- for `nil` values to avoid ambiguity and potential errors.
    --
    find = function(self, searchValue)
      if type(searchValue) == 'nil' then
        exception('Cannot search for a nil value in the list.') 
      end

      local valueCount = #self.values
      for i = 1, valueCount do
        if self.values[i] == searchValue then return i end
      end

      return -1
    end,

    --
    -- Returns the number of elements in the list. The # operator is used for efficiency.
    --
    size = function(self) return #self.values end

  } --[[@as List]]
}

--
-- This is a factory function for creating new list objects, an ordered collection of elements,
-- with optional initial values and support for 'weak' table behavior.
--
--- @param values? unknown[] (optional) An array of initial values to populate the list.
--- @param options? { weak: WeakTableOptions } (optional) Specifies whether the list's internal table should have weak keys ('k'), weak values ('v'), or both ('kv').
---
--- @return List "The newly created list object."
--
_G.cogspinner.utilities.collections.list = function(values, options)
  if values and type(values) ~= 'table' then
    exception('Invalid argument type for "values". Expected an array (table) or nil.')
  end

  if options and options.weak then
    --| Enables "weak mode" for the list's internal table. In weak mode, certain entries
    --| in the table can be automatically removed by the garbage collector if they are no
    --| longer referenced elsewhere. This helps prevent memory leaks, especially when storing
    --| objects or tables as values within the list. The 'options.weak' value determines
    --| whether keys, values, or both are considered weak.

    local weakMode =
        (options.weak == 'key' and 'k')
        or (options.weak == 'value' and 'v')
        or (options.weak == 'both' and 'kv')
        or exception('Invalid value for "options.weak". Allowed values are "key", "value", or "both".')

    values = setmetatable(values or {}, { __mode = weakMode })
  end

  return setmetatable({ values = values or {} }, list)
end
