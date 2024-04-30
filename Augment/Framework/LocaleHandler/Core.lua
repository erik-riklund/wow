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
local LocaleHandler = CORE.LocaleHandler
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

Listen(
  "PLUGIN_ADDED",
  --
  function(plugin)
    --
    function plugin:L(key, plugin_id)
      return LocaleHandler:GetString(plugin_id or plugin.id, key)
    end
  end
)

--
--- Registers a default translation record within the localization system.
--
-- @param plugin table  The plugin context object.
-- @param locale string The locale code (e.g., "enUS", "deDE") for the translation.
-- @param content record A record containing the localized strings, where the keys
--                       are identifiers and the values are the translated strings.
--

DefaultLocale = function(plugin, locale, content)
  LocaleHandler:RegisterLocale(plugin, locale, content, true)
end

--
--- Registers a translation record within the localization system.
--
-- @param plugin table  The plugin context object.
-- @param locale string The locale code (e.g., "enUS", "deDE") for the translation.
-- @param content record A record containing the localized strings, where the keys
--                       are identifiers and the values are the translated strings.
--

Locale = function(plugin, locale, content)
  LocaleHandler:RegisterLocale(plugin, locale, content)
end
