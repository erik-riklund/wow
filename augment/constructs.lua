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
--[ destructure ]
--
-- Extracts specific values from a table based on a list of keys.
--
destructure = function(table, keys)
  if type(table) ~= "table" then
    throw("Expected type `table` for parameter 'table'")
  end
  if type(keys) ~= "table" then
    throw("Expected type `table` for parameter 'keys'")
  end

  local values = {}
  for _, key in ipairs(keys) do
    table.insert(values, table[key])
  end

  return table.unpack(values)
end

--
--[ switch ]
--
-- Provides a switch-like control flow mechanism using a lookup table.
--
switch = function(value, cases)
  if type(cases) ~= "table" then
    error("Expected type `table` for parameter 'cases'")
  end

  local match = cases[value] or cases["default"]
  return (type(match) == "function" and match()) or match
end
