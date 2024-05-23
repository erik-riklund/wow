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

local type = _G.type

--
--- This function acts as a decision-maker, choosing a specific outcome from a set
--- of possibilities based on the value it receives. It resembles a flowchart, guiding
--- the program down different paths depending on the input.
--
--- @param cases table
--- @return any
--
_G.switch = function(value, cases)
  if type(cases) ~= "table" then
    error("Expected type `table` for parameter 'cases'")
  end

  local match = cases[value] or cases.default
  return (type(match) == "function" and match()) or match
end
