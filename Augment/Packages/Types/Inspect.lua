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
--[ inspect ]
--
-- Inspects the given value and returns a string representation of its type.
-- Special handling is provided for nil values (returns "undefined") and tables
-- (attempts to use the object's `get_type` method, if available).
--
local inspect = function(value)
  local actual_type = type(value)

  return switch(
    actual_type,
    {
      default = actual_type,
      ["nil"] = "undefined",
      ["table"] = function()
        return (value.get_type and value:get_type()) or "table"
      end
    }
  )
end

--
export("types.inspect", inspect)
