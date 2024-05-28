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
--

--
--- ???
--
--- @param value any
--- @param options property|parameter
--
--- @return validation_result
--
function _G.validate_type(value, options)
  local result = ({ value = value or options.default } --[[@as validation_result]])
  local actual_type = examine(result.value)
  local expected_type = options.type --[[@as string]]

  if (value ~= nil or options.optional ~= true) and actual_type ~= expected_type then
    if expected_type ~= 'any' or expected_type == 'any' and actual_type == 'undefined' then
      if not ((expected_type == 'list' or expected_type == 'map') and actual_type == 'table') then
        result.error = ("Expected a value of type `%s` but recieved `%s`"):format(expected_type, actual_type)
      end
    end
  end

  return result
end
