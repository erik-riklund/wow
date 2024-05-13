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
local Type = Import({"TypeHandler"})
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ Map ]
--
-- ???
--
local Map = function(key_type, value_type, initial_content)
  local key_type, value_type = Type:Is("string", key_type), Type:Is("string", value_type)

  local object = {
    --
    --[ _entries ]
    --
    -- ???
    --
    _entries = 0,
    --
    --[ _content ]
    --
    -- ???
    --
    _content = {},
    --
    --[ Set ]
    --
    -- ???
    --
    Set = function(self, key, value)
      self._content[Type:Is(key_type, key)] = Type:Is(value_type, value)
      self._entries = self._entries + 1
    end,
    --
    --[ Get ]
    --
    -- ???
    --
    Get = function(self, key)
      return self._content[key]
    end,
    --
    --[ Size ]
    --
    -- ???
    --
    Size = function(self)
      return self._entries
    end,
    --
    --[ GetType ]
    --
    -- ???
    --
    GetType = function(self)
      return ("map(%s, %s)"):format(key_type, value_type)
    end
  }

  if type(initial_content) == "table" then
    for key, value in pairs(initial_content) do
      object:Set(key, value)
    end
  end

  return object
end

--
Export("Collections.Map", Map)
