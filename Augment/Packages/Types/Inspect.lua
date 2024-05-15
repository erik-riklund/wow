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
--[ Inspect ]
--
-- ???
--
local Inspect = function(value)
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
end

--
Export("Types.Inspect", Inspect)
