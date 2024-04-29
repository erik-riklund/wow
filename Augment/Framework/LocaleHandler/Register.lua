local ADDON, CORE = ...
local T = Type

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

--

--

Locale = function(context, locale, content, default)
  --
  local context = T:Check("context", context, T:Table())
  local locale = T:Check("locale", locale, T:String())
  local content = T:Check("content", content, T:Record(T:String(), T:String()))
  local default = T:Check("default", default, T:Boolean(false))

  -- TODO > locale registration
end

--

--

DefaultLocale = function(context, locale, content)
  Locale(context, locale, content, true)
end
