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
local type = import({"type.inspect"})
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ validate ]
--
-- ???
--
local validate = function(value, expected_type)
  local actual_type = type(value)

  return switch(
    type(expected_type),
    {
      string = function()
        if actual_type ~= expected_type then
          return nil, {actual_type = actual_type, expected_type = expected_type}
        end

        return value -- type validation passed!
      end,
      --
      table = function()
        if #expected_type > 0 then
          -- ???
        else
          -- ???
        end
      end
    }
  )
end

export("type.validate", validate)
