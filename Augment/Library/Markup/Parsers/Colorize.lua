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

--
--- Adds color formatting codes to text based on a markup pattern.
--
-- This function assumes a specific markup format where color names are enclosed within 
-- `{@ ... }` tags. For example: `{@red This text is red}`.
--
-- @param text string The text containing color markup tags.
-- @return string The text with color markup replaced by color formatting codes.
--

function Markup:Colorize(text)
  --
  return string.gsub(
    text,
    "{@(%a+) (.-)}",
    function(a, b)
      return string.format("|cFF%s%s|r", self.Colors[a] or a, b)
    end
  )
end
