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

Markup = {
  --
  Colors = {
    green = "BCD856",
    olive = "7D9039",
    wheat = "F5DEB3",
    white = "FFFFFF",
    yellow = "EEC400",
    burn = "AA552A",
    orange = "FF8040",
    teal = "86AFAF",
    maroon = "AA0000",
    gray = "B8B8B8",
    taupe = "A39477",
    redpink = "FF5555"
  },
  --
  Parsers = {
    --
    function(text, variables)
      return Markup:Colorize(text)
    end,
    --
    function(text, variables)
      return Markup:Format(text, variables)
    end
  }
}

--
--- Processes a markup text string, performing substitutions based on provided variables.
--
-- This function assumes the existence of a `Parsers` table containing parser functions.
-- Each parser function is applied to the text in sequence, potentially modifying it to
-- replace markup patterns with values from the `variables` table.
--
-- @param text string The markup text to process.
-- @param variables table A table containing variables to substitute into the markup text.
-- @return string The processed text with markup substitutions performed.
-- @throws error If 'text' is not a string or 'variables' is not a table.
--

function Markup:Parse(text, variables)
  --
  if type(text) ~= "string" then
    error("Expected type `string` for parameter 'text")
  end
  if type(variables) ~= "table" then
    error("Expected type `table` for parameter 'variables'")
  end

  for _, method in ipairs(self.Parsers) do
    --
    text = method(text, variables)
  end

  return text
end
