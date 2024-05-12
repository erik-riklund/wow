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
local Type, Object = Import({"Core.TypeHandler", "Core.Object"})
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ Map ]
--
-- A dynamic key-value store, where keys and values adhere to specific types.
--
local Map =
  Object(
  "Map",
  {
    --
    --[ _types ]
    --
    -- Private field used to store the valid types for keys and values.
    --
    _types = {},
    --
    --[ _entries ]
    --
    -- Private field used to store the content of the map.
    --
    _entries = {},
    --
    --[ _count ]
    --
    -- Private field used to track the current number of key-value pairs stored in the map.
    --
    _count = 0,
    --
    --[ Constructor ]
    --
    -- Creates a new Map instance, specifying the expected types for keys and values.
    --
    Constructor = function(self, key_type, value_type)
      self._types = {key = Type:Is("string", key_type), value = Type:Is("string", value_type)}
      self:SetType(("map(%s, %s)"):format(key_type, value_type))
    end,
    --
    --[ Get ]
    --
    -- Retrieves the value associated with the given key, or `nil` if not found.
    --
    Get = function(self, key)
      return self._entries[key]
    end,
    --
    --[ Set ]
    --
    -- Assigns a value to the given key, ensuring both key and value match the defined types.
    --
    Set = function(self, key, value)
      local key, value = Type:Is(self._types["key"], key), Type:Is(self._types["value"], value)

      self._entries[key] = value
      self._count = self._count + 1
    end,
    --
    --[ Drop ]
    --
    -- Removes the entry associated with the given key from the map, if it exists.
    --
    Drop = function(self, key)
      local key = Type:Is(self._types["key"], key)

      if self._entries[key] ~= nil then
        self._entries[key] = nil
        self._count = self._count - 1
      end
    end,
    --
    --[ Entries ]
    --
    -- Return an iterator that can be used to traverse the content of the map.
    --
    Entries = function(self)
      return pairs(self._entries)
    end,
    --
    --[ Count ]
    --
    -- Returns the number of key-value pairs currently stored in the map.
    --
    Count = function(self)
      return self._count
    end,
    --
    --[ Has ]
    --
    -- ???
    --
    Has = function(self, key)
      local key = Type:Is(self._types["key"], key)
      return (self._entries[key] ~= nil)
    end
  }
)

--
-- ???
--
Export("Core.Types.Map", Map)
