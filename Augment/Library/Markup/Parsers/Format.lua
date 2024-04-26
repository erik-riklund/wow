local ADDON, CORE = ...
local Markup = Markup
local Type = Type

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

--

function Markup:Format(text, variables)
  local keys = Table:GetKeys(variables)
  table.sort(keys, function (a,b) return #a > #b end)

  for _, k in ipairs(keys) do
    text = string.gsub(text, "$" .. k, variables[k])
  end

  return text
end
