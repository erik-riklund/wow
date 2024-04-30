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
local Strings = LocaleHandler.Strings
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--- Retrieves a localized translation string for a specified plugin and key.
--
-- This function handles potential fallback mechanisms when translations are unavailable, 
-- including checking for default translations and generating a "missing translation" message.
--
-- @param plugin_id string The ID of the plugin that the translation belongs to.
-- @param key string The unique identifier of the translation string within the plugin.
-- @return string The translated text, a default translation (if found), or a formatted 
--                "missing translation" message.
--

function LocaleHandler:GetString(plugin_id, key)
  --
  local plugin_id = T:Check("plugin_id", plugin_id, T:String())
  local key = T:Check("key", key, T:String())

  local locale = When(LocaleHandler.Locale == "enGB", "enUS", LocaleHandler.Locale)

  if Strings[plugin_id] and Strings[plugin_id][locale] then
    --
    local translation = Strings[plugin_id][locale](key)

    if not translation and Strings[plugin_id]["default"] then
      translation = Strings[plugin_id]["default"](key)
    end

    if translation then
      return translation -- success!
    end
  end

  return Markup:Parse(
    "[Missing localized string: $key, $locale, $plugin]",
    {
      key = key,
      locale = locale,
      plugin = plugin_id
    }
  )
end
