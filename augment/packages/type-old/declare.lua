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
local type, validate = import({"type.inspect","type.validate"})
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ declare ]
--
-- ???
--
local declare = function(args, params)
  if type(args) ~= "table" then
    throw("Expected type `table` for 'args'")
  end
  if type(params) ~= "table" then
    throw("Expected type `table` for 'params'")
  end

  -- ???
end

export("type.declare", declare)
