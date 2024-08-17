--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ... ---@cast context core.context

--#region: locally scoped variables

local setmetatable, table, throw, type =
    setmetatable, table, throw, type

--#endregion

--#region [metatable: __list]

---@type list
local __list =
{
  values = {},

  --
  get = function(self, index) return self.values[index] end,

  --
  insert = function(self, value, position)
    table.insert(self.values, position or (#self.values + 1), value)
  end,

  --
  remove = function(self, index)
    return table.remove(self.values, index or #self.values)
  end,

  --
  replace = function(self, index, value)
    if not self.values[index] then
      throw('Unable to replace non-existing index (%d)', index)
    end

    self.values[index] = value
  end,

  --
  length = function(self) return #self.values end
}

--#endregion

--#region [function: list]

--- @type utilities.collections.list
local function list(initial_values)
  if initial_values and type(initial_values) ~= 'table' then
    throw('Expected an array of initial values, got `%s`', type(initial_values))
  end

  return setmetatable({ values = initial_values or {} }, { __index = __list })
end

--#endregion

context:export('utilities.collections.list', list)
