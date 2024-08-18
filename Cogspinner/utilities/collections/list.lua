--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ... --- @cast context core.context
local setmetatable, table, throw, type = setmetatable, table, throw, type

--#region [controller: list]

--
-- This controller provides the underlying implementation for list objects,
-- handling element storage and common list operations like insertion, removal, etc.
--

--- @type list
local list_controller =
{
  --
  -- The internal array to store the list's values. We are
  -- using a plain table for efficient indexing and iteration.
  --

  values = {},

  --
  -- Retrieves the value at the specified index in the list.
  --

  get = function(self, index) return self.values[index] end,

  --
  -- Inserts a value into the list at the specified position,
  -- or at the end if no position is provided.
  --
  -- We use `table.insert` to handle array shifting automatically.
  --

  insert = function(self, value, position)
    table.insert(self.values, position or (#self.values + 1), value)
  end,

  --
  -- Removes and returns the value at the specified index,
  -- or the last value if no index is provided.
  --
  -- Again, `table.remove` handles array shifting for us.
  --

  remove = function(self, index)
    return table.remove(self.values, index or #self.values)
  end,

  --
  -- Replaces the value at the specified index with the new value.
  --
  -- We throw an error if trying to replace a non-existent index
  -- to avoid unexpected behavior.
  --

  replace = function(self, index, value)
    if not self.values[index] then
      throw('List index out of bounds. Cannot replace a non-existent element.')
    end

    self.values[index] = value
  end,

  --
  -- Returns the number of elements (length) in the list.
  -- The # operator is used for efficiency.
  --

  length = function(self) return #self.values end
}

--#endregion

--#region [metatable: __list]

--
-- This metatable associates list instances with the `list_controller`,
-- giving them the behavior defined in the controller.
--

local __list = { __index = list_controller }

--#endregion

--#region [function: list]

--
-- Factory function to create new list objects. Optionally allows for
-- weak table behavior to manage memory and prevent potential leaks.
--

--- @type utilities.collections.list
local function list(initial_values, options)
  if initial_values and type(initial_values) ~= 'table' then
    throw('Invalid initial values for the list. Expected a table (or nil).')
  end

  --#region: Optional weak table handling
  -- Handle optional 'weak' mode, which allows garbage collection of keys/values
  -- that are no longer referenced elsewhere. This can be useful for preventing
  -- memory leaks in certain scenarios.
  --#endregion

  if type(options) == 'table' and options.weak then
    local weak = { key = 'k', value = 'v', both = 'kv' }

    if not weak[options.weak] then
      throw("Invalid weak mode option for list. Please specify 'key', 'value', or 'both'.")
    end

    initial_values = setmetatable(
      initial_values or {}, { __mode = weak[options.weak] }
    )
  end

  return setmetatable({ values = initial_values or {} }, __list)
end

--#endregion

--
-- Export the `list` function to the framework context.
--

context:export('utilities.collections.list', list)
