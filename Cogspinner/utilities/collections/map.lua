--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local setmetatable = setmetatable
local _, context = ... ---@cast context core.context

--#region [metatable: __map]

--
-- This metatable provides the underlying implementation for map objects,
-- handling key-value storage and operations.
--

---@type map
local __map =
{
  entries = 0,
  content = {},

  --
  -- Retrieves the value associated with a given key from the map.
  --

  get = function(self, key) return self.content[key] end,

  --
  -- Sets or updates the value associated with a key in the map.
  -- If the value is `nil`, the key-value pair is removed instead.
  -- We maintain an 'entries' count for quick size checks.
  --

  set = function(self, key, value)
    if value == nil then
      self:drop(key)
      return
    end

    if self.content[key] == nil then
      self.entries = self.entries + 1
    end

    self.content[key] = value
  end,

  --
  -- Removes a key-value pair from the map based on the given key.
  -- We also decrement the 'entries' count to reflect the removal.
  --

  drop = function(self, key)
    if self.content[key] ~= nil then
      self.content[key] = nil
      self.entries = self.entries - 1
    end
  end,

  --
  -- Checks if a key exists within the map.
  --

  has = function(self, key)
    return self.content[key] ~= nil
  end,

  --
  -- Returns the number of key-value pairs (entries) in the map.
  -- We use the cached 'entries' count for efficiency.
  --

  size = function(self) return self.entries end
}

--#endregion

--#region [function: map]

--
-- Factory function to create new map objects, using the
-- `__map` metatable to provide the map behavior.
--

---@type utilities.collections.map
local function map(initial_content)
  local object = {

  }

  return setmetatable(object, { __index = __map })
end

--#endregion

--
-- Export the `map` function to the framework context.
--

context:export('utilities.collections.map', map)
