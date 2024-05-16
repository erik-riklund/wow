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
--[ validate ]
--
-- ???
--
local validate = function(schema, target)
  schema = check("table", schema)
  target = check("table", target)

  for key, _ in pairs(target) do
    if not schema[key] then
      throw("The property '%s' does not exist in the specified schema", key)
    end
  end

  for key, expected_type in pairs(schema) do
    
  end
end

--
export("types.validate", validate)
