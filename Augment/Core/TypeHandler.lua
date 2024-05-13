local error = error
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
--[ TypeHandler ]
--
-- A utility module for handling runtime type checking.
--
local TypeHandler = {
  --
  --[ Inspect ]
  --
  -- Inspects the given value and returns a string representation of its type.
  --
  Inspect = function(self, value)
    local actual_type = type(value)

    return switch(
      actual_type,
      {
        default = actual_type,
        ["nil"] = "undefined",
        ["table"] = function()
          return (value.GetType and value:GetType()) or "table"
        end
      }
    )
  end,
  --
  --[ Is ]
  --
  -- Perform a strict type check of the provided value, throwing
  -- an error if the type doesn't match the expected type.
  --
  Is = function(self, expected_type, value)
    local actual_type = self:Inspect(value)

    if actual_type ~= expected_type and not (expected_type == "any" and actual_type ~= "undefined") then
      error(("Expected type `%s`, recieved `%s`"):format(expected_type, actual_type))
    end

    return value
  end
}

--
Export("TypeHandler", TypeHandler)
