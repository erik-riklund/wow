--
--      #
--     # #   #    #  ####  #    # ###### #    # #####
--    #   #  #    # #    # ##  ## #      ##   #   #
--   #     # #    # #      # ## # #####  # #  #   #
--   ####### #    # #  ### #    # #      #  # #   #
--   #     # #    # #    # #    # #      #   ##   #
--   #     #  ####   ####  #    # ###### #    #   #
--
-- World of Warcraft addon ecosystem, created by Erik Riklund (2024)
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ map_methods ]
--
-- A collection of methods for manipulating and accessing map data structures.
--
local map_methods = {
  --
  --[ get ]
  --
  -- Retrieves the value associated with a given key.
  --
  get = function(self, key)
    key = check(self._type["key"], key)
    return self._content[key]
  end,
  --
  --[ set ]
  --
  -- Sets a value for a given key, ensuring both key and value types match the expected types.
  --
  set = function(self, key, value)
    key = check(self._type["key"], key)
    value = check(self._type["value"], value)

    if not self._content[key] then
      self._entries = self._entries + 1
    end

    self._content[key] = value
  end,
  --
  --[ get_type ]
  --
  -- Returns a string representation of the map's type, including its key and value types.
  --
  get_type = function(self)
    return ("map(%s, %s)"):format(self._type["key"], self._type["value"])
  end
}

--
--[ map ]
--
-- A constructor function to create a new map with specified
-- key and value types, and optional initial content.
--
local map = function(key_type, value_type --[[optional]], initial_content)
  key_type = check("string", key_type)
  value_type = check("string", value_type)
  initial_content = check("table", initial_content or {})

  local instance =
    setmetatable(
    {
      --
      --[ _type ]
      --
      -- Stores the expected data types for keys and values in the map.
      --
      _type = {key = key_type, value = value_type},
      --
      --[ _entries ]
      --
      -- Tracks the number of key-value pairs in the map.
      --
      _entries = 0,
      --
      --[ _content ]
      --
      -- The internal table that stores the map's key-value pairs.
      --
      _content = {}
    },
    --
    --[ __index ]
    --
    -- Metatable field that provides access to map methods when called on a map object.
    --
    {
      __index = map_methods
    }
  )

  if next(initial_content) ~= nil then
    for key, value in pairs(initial_content) do
      instance:set(key, value)
    end
  end

  return instance
end

--
export("collections.map", map)
