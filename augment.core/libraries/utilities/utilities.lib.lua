local ADDON, CORE = ...
--
--      #
--     # #   #    #  ####  #    # ###### #    # #####
--    #   #  #    # #    # ##  ## #      ##   #   #
--   #     # #    # #      # ## # #####  # #  #   #
--   ####### #    # #  ### #    # #      #  # #   #
--   #     # #    # #    # #    # #      #   ##   #
--   #     #  ####   ####  #    # ###### #    #   #
--
-- World of Warcraft addon framework, created by Erik Riklund (2024)
--

--- @cast CORE framework
local self = CORE.libs.utilities

--#region [method: when]

--- ???
--
self.when = function(value, cases, ...)
  if type(cases) ~= 'table' then
    error("Expected type `table` for 'cases'")
  end

  local matched_case = cases[value] or cases.default
  return type(matched_case) == 'function' and matched_case(...) or matched_case
end

--#endregion
