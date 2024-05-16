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
-- ???
--
local map_methods = {
  --
  --[ get ]
  --
  -- ???
  --
  get = function(self, key)
    key = check(self._type["key"], key)
    return self._content[key]
  end,
  --
  --[ set ]
  --
  -- ???
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
  -- ???
  --
  get_type = function(self)
    return ("map(%s, %s)"):format(self._type["key"], self._type["value"])
  end
}

--
--[ map ]
--
-- ???
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
      -- ???
      --
      _type = {key = key_type, value = value_type},
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
      _content = {}
    },
    --
    --[ __index ]
    --
    -- ???
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
