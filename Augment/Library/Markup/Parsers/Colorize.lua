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
-- Adds color formatting to text strings using a simplified markup syntax.
--
-- Parameters:
--   text (string): The input text string containing color markup tags.
--
-- Returns:
--   (string): The input text with markup tags replaced by color formatting codes.
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

function Markup:Colorize(text)
  local colors = {
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
  }

  return string.gsub(
    text,
    "{@(%a+) (.-)}",
    function(a, b)
      return string.format("|cFF%s%s|r", colors[a] or a, b)
    end
  )
end
