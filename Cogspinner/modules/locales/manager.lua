--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework.context
local addon, framework = ...

---
--- Serves as the central repository for storing and managing localized
--- strings for different plugins and locales.
---
--- @type table<string, locales.content>
---
local locales = {}

---
--- Generates a unique locale identifier based on the plugin's identifier and the locale code.
---
--- @param context plugin
--- @param locale  string
---
local createLocaleIdentifier = function(context, locale)
  return string.format('%s:%s', context.identifier, locale)
end

---
--- The core manager handles localized strings, including retrieving strings
--- based on context and locale, and registering new locale data.
---
--- @type locales.manager
---
local manager = {
  --
  -- Retrieves a localized string for a given plugin and key,
  -- using a default locale if the requested one is unavailable.
  --
  getLocalizedString = function(context, key)
    local locale = GetLocale()
    local identifier = createLocaleIdentifier(context, locale)

    if not locales[identifier] then
      identifier = createLocaleIdentifier(context, 'fallback')

      if not locales[identifier] then
        throw('The requested locale "%s" is missing, and no fallback locale '
               .. 'has been registered for plugin "%s"', locale, context.identifier)
      end
    end

    return locales[identifier][key]
            or string.format('[(%s) Missing localized string "%s" for locale `%s`]',
                             context.identifier, key, locale)
  end,

  --
  -- Registers locale data for a plugin, associating it with a specific locale
  -- and allowing it to be optionally set as the fallback locale.
  --
  registerLocale = function(context, locale, content, fallback)
    ensureType('locale', locale, 'string')
    ensureType('content', content, 'table')

    local identifier = createLocaleIdentifier(context, locale)

    if locales[identifier] then
      throw('The locale "%s" is already registered for plugin "%s"', locale, context.identifier)
    end

    locales[identifier] = content

    if fallback == true then
      locales[createLocaleIdentifier(context, 'fallback')] = content
    end
  end
}

-- #region << exports >>
framework.export('locales/manager', manager)
-- #endregion
