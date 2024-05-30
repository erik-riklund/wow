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

_G.exception = {}

--#region [method: throw]

--
--- ???
--
--- @param message string
--- @param ... string|number
--
function _G.exception.throw(message, ...)
  error(... and message:format(...) or message)
end

--#endregion
--#region [method: type_error]

--
--- ???
--
--- @param expected_type string
--- @param actual_type string
--
--- @return string
--
function _G.exception.type_error(expected_type, actual_type)
  return ("Expected a value of type `%s` but recieved `%s`"):format(expected_type, actual_type)
end

--#endregion
