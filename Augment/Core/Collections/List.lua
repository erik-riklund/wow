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
--[ List ]
--
-- A dynamic ordered collection of values adhering to a specific type.
--
local List = function(value_type, initial_values)
  local value_type = Type:Is("string", value_type)

  local object = {
    --
    --[ _values ]
    --
    -- Private field used to store the actual values of the list.
    --
    _values = {},
    --
    --[ Push ]
    --
    -- Appends a new value to the end of the list, ensuring the value matches the defined type.
    --
    Push = function(self, value)
      table.insert(self._values, Type:Is(value_type, value))
    end,
    --
    --[ Values ]
    --
    -- Returns an iterator function that can be used to iterate over the values in the list.
    --
    Values = function(self)
      return ipairs(self._values)
    end,
    --
    --[ Count ]
    --
    -- Returns the number of elements currently stored in the list.
    --
    Count = function(self)
      return #self._values
    end,
    --
    --[ Contains ]
    --
    -- Checks if the list contains a given search value. Returns true and the index if found, otherwise false and -1.
    --
    Contains = function(self, search_value)
      if self:Count() > 0 then
        for index, value in self:Values() do
          if value == search_value then
            return true, index
          end
        end
      end

      return false, -1
    end,
    --
    --[ GetType ]
    --
    -- Returns a string representation of the list's type, including the element type.
    --
    GetType = function(self)
      return ("list(%s)"):format(value_type)
    end
  }

  if type(initial_values) == "table" then
    for i = 1, #initial_values do
      object:Push(initial_values[i])
    end
  end

  return object
end

--
Export("Collections.List", List)
