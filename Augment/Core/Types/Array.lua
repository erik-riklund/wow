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
local Type, Object = Import({"Core.TypeHandler","Core.Object"})
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ Array ]
--
-- A dynamic ordered collection of values adhering to a specific type.
--
local Array =
  Object(
  {
    --
    --[ _types ]
    --
    -- Stores the valid type for values within the array.
    --
    _types = nil,
    --
    --[ _values ]
    --
    -- Private field used to store the actual values of the array.
    --
    _values = {},
    --
    --[ Constructor ]
    --
    -- Creates a new Array instance, specifying the expected type for its values.
    --
    Constructor = function(self, value_type)
      self._types = Type:Is("string", value_type)
      self:SetType(("array(%s)"):format(value_type))
    end,
    --
    --[ Push ]
    --
    -- Appends a new value to the end of the array, ensuring the value matches the defined type.
    --
    Push = function(self, value)
      table.insert(self._values, Type:Is(self._types, value))
    end,
    --
    --[ Length ]
    --
    -- Returns the number of elements currently stored in the array.
    --
    Length = function(self)
      return #self._values
    end,
    --
    --[ Values ]
    --
    -- Returns an iterator function that can be used to iterate over the values in the array.
    --
    Values = function(self)
      return ipairs(self._values)
    end,
    --
    --[ Contains ]
    --
    -- ???
    --
    Contains = function(self, search_value)
      local search_value = Type:Is(self._types, search_value)

      for index = 1, #self._values do
        if self._values[index] == search_value then
          return true, index
        end
      end

      return false, -1
    end
  }
)

--
-- ???
--
Export("Core.Types.Array", Array)
