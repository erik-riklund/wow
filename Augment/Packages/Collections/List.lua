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
-- A collection of methods for manipulating and accessing lists.
--
local list_methods = {
  --
  --[ push ]
  --
  -- Adds a new element to the end of the list.
  --
  push = function(self, value)
    print("push - not implemented")
  end,
  --
  --[ contains ]
  --
  -- Checks if the list contains a specific value.
  -- Returns the index if the value is found, otherwise -1.
  --
  contains = function(self, search_value)
    if #self._values > 0 then
      for index = 1, #self._values do
        if self._values[index] == search_value then
          return index
        end
      end
    end

    return -1
  end,
  --
  --[ get_type ]
  --
  -- Returns a string representation of the list's type, including the element type.
  --
  get_type = function(self)
    return ("list(%s)"):format(self._type)
  end
}

--
--[ list ]
--
-- A constructor function for creating a new list with a
-- specified element type and optional initial values.
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
      -- The expected type of elements within the list.
      --
      _type = value_type,
      --
      --[ _values ]
      --
      -- The internal array storing the list's elements.
      --
      _values = {}
    },
    --
    --[ __index ]
    --
    -- Metatable field that allows accessing list methods through the list object.
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

-- module exports:
export("collections.list", list)
