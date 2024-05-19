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
-- ???
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

export("type.inspect", inspect)
