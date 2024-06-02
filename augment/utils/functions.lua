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

--#region [function: switch]

--
--- Acts as a conditional selector, choosing a value or executing a function based on
--- whether the input value matches any of the specified cases.
--
--- If a match is found and it is a function, it is executed with optional arguments.
--- Otherwise, the matched value is returned directly. If no match is found, the default
--- case (if provided) is handled in the same manner.
--
--- @param cases table
--- @return any
--
function _G.switch(value, cases, ...)
  local case = (cases[value] or cases.default) --[[@as any]]
  local executable_case = type(case) == 'function'

  return executable_case and case(...) or case
end

--#endregion
