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
local check = import({"types.check"})
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ list_methods ]
--
-- ???
--
local list_methods = {
  --
  --[ push ]
  --
  -- ???
  --
  push = function(self, value)
    print("push - not implemented")
  end,
  --
  --[ contains ]
  --
  -- ???
  --
  contains = function(self, search_value)
    if #self._values > 0 then
      for index = 1, #self._values do
        if self._values[index] == search_value then
          return true, index
        end
      end
    end

    return false, -1
  end,
  --
  --[ get_type ]
  --
  -- ???
  --
  get_type = function(self)
    return ("list(%s)"):format(self._type)
  end
}

--
--[ list ]
--
-- ???
--
local list = function(value_type, initial_values)
  value_type = check("string", value_type)
  initial_values = check("table", initial_values or {})

  local instance =
    setmetatable(
    {
      --
      --[ _type ]
      --
      -- ???
      --
      _type = value_type,
      --
      --[ _values ]
      --
      -- ???
      --
      _values = {}
    },
    --
    --[ __index ]
    --
    -- ???
    --
    {
      __index = list_methods
    }
  )

  if #initial_values > 0 then
    for i = 1, #initial_values do
      instance:push(initial_values[i])
    end
  end

  return instance
end

--
export("collections.list", list)
