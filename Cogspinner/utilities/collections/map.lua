--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context     = ...
--- @cast context FrameworkContext

--#region (locally scoped variables and functions)

local setmetatable   = _G.setmetatable
local throw          = _G.throw
local type           = _G.type

--#endregion

--#region [controller: map]

--
-- This controller provides the underlying implementation for map objects,
-- handling key-value storage and operations. It uses a simple table ('content')
-- for storage and maintains an 'entries' count for efficient size tracking.
--

--- @type Map
local map_controller =
{
  --
  -- The internal data structure to store the key-value pairs. We use a
  -- plain Lua table for its flexibility and performance in lookups.
  --

  content = {},

  --
  -- Keeps track of the number of key-value pairs currently stored in the map.
  -- This avoids the need to recalculate the size using `pairs` every time.
  --

  entries = 0,

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

--#region [metatable: __map]

--
-- This metatable links map instances to the `map_controller`,
-- providing them with the necessary methods for map operations.
--

local __map          = { __index = map_controller }

--#endregion

--#region [function: map constructor]

--
-- Factory function to create new map objects. It optionally applies a weak table
-- behavior to the underlying storage if specified in the options.
--

--- @type MapConstructor
local function map(initial_content, options)
  if initial_content and type(initial_content) ~= 'table' then
    throw("Error initializing map: 'initial_content' must be a table.")
  end

  --#region: Optional weak table handling
  -- Handle optional 'weak' mode, which allows garbage collection of keys and/or
  -- values that are no longer referenced elsewhere. This can be useful for preventing
  -- memory leaks in certain scenarios.
  --#endregion

  if type(options) == 'table' and options.weak then
    local weak = { key = 'k', value = 'v', both = 'kv' }

    if not weak[options.weak] then
      throw("For weak maps, the 'weak' option must be set to 'key', 'value', or 'both'.")
    end

    initial_content = setmetatable(
      initial_content or {}, { __mode = weak[options.weak] }
    )
  end

  return setmetatable(
    { entries = 0, content = initial_content or {} }, __map
  )
end

--#endregion

--
-- Export the `map` function to the framework context.
--

context:export('collection/map', map)
