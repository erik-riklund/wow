local Markup = Markup

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
--- Performs simple variable substitution within a text string.
--
-- This function assumes a markup format where variables are denoted by a dollar sign ($) 
-- followed by the variable name (e.g., $variableName). It replaces these placeholders with 
-- corresponding values from the provided `variables` table.
--
-- @param text string The text containing variable placeholders.
-- @param variables table A table (dictionary) where keys represent variable names and 
--                        values are the replacement strings. 
-- @return string The formatted text with variables substituted.
--

function Markup:Format(text, variables)
  --
  local keys = Table:GetKeys(variables)
  table.sort(keys, function (a,b) return #a > #b end)

  for _, k in ipairs(keys) do
    text = string.gsub(text, ("$%s"):format(k), variables[k])
  end

  return text
end
