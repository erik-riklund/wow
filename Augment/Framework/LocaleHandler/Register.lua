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
local Locale = LocaleHandler.Locale
local Strings = LocaleHandler.Strings
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--- Registers a set of translation strings for a specific plugin and locale.
--
-- This function stores translations organized by plugin ID and locale. It expects translations
-- to be provided as a record (key-value table) where both keys and values are strings.
--
-- @param plugin_id string The ID of the plugin.
-- @param locale string The locale code (e.g., "enUS", "deDE") for the translations.
-- @param content table A record where keys represent translation keys and values are the 
--                       corresponding translated strings.
-- @param default boolean (Optional) Indicates if this locale should be the default for the plugin.
-- @throws error If the plugin object is missing an 'id' field or if a locale already exists 
--               for the specified plugin.
--

function LocaleHandler:RegisterLocale(plugin_id, locale, content, default)
  --
  local plugin_id = T:Check("plugin", plugin_id, T:String())
  local locale = T:Check("locale", locale, T:String())
  local content = T:Check("content", content, T:Record(T:String(), T:String()))
  local default = T:Check("default", default, T:Boolean(false))

  if Strings[plugin_id] and Strings[plugin_id][locale] then
    Throw(
      "The locale `$locale` already exists for plugin $plugin",
      {
        locale = locale,
        plugin = plugin_id
      }
    )
  end

  Strings[plugin_id] = Strings[plugin_id] or {}

  Strings[plugin_id][locale] = function(key)
    return content[key]
  end
end
