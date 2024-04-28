local ADDON, CORE = ...
local Type = Type
Markup = {}

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

local Parsers = {
  --
  function(text, variables)
    return Markup:Colorize(text)
  end,
  --
  function(text, variables)
    return Markup:Format(text, variables)
  end
}

--
-- Applies a series of parsing methods to transform a text string, potentially
-- adding formatting or other structural changes. It also supports additional
-- arguments to be passed to the final string.format() transformation.
--
-- Parameters:
--   text (string): The input text string to be processed.
--   ... : (variable arguments): Additional arguments to be passed to string.format().
--
-- Returns:
--   (string): The final text string after all parsing methods have been applied.
--

function Markup:Parse(text, variables)
  --
  if type(text) ~= "string" then
    Throw("Expected type `string` for parameter 'text")
  end
  if type(variables) ~= "table" then
    Throw("Expected type `table` for parameter 'variables'")
  end

  for _, method in ipairs(Parsers) do
    local success, result = pcall(method, text, variables)

    if success then
      text = result
    end
  end

  return text
end
