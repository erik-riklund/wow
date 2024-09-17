--
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework.context
local addon, framework = ...

--- @type locales.manager
local locales = framework.import('locales/manager')

--- @type network.controller
local network = framework.import('network/controller')

---
--- The API prototype object provides methods for plugins to interact with localization
--- functionality, enabling them to retrieve localized strings and register locale data.
--- 
--- @type locales.api
---
local api = {
  --
  getLocalizedString = function(self, key)
    return locales.getLocalizedString(self, key)
  end,

  --
  registerLocale = function(self, options)
    if type(options) ~= 'table' then
      throwTypeError('options', 'table', type(options))
    end

    locales.registerLocale(self, options.locale, options.content, options.fallback)
  end
}

---
--- A listener triggered when a new plugin is added to the system. It extends the plugin's
--- capabilities by integrating localization API methods. Additionally, it registers locales
--- specified in the plugin's options.
---
network.registerListener('PLUGIN_ADDED', {
  --- @param plugin plugin
  --- @param options plugins.createPlugin.options
  callback = function(plugin, options)
    integrateTable(plugin, api) -- Inherits the API methods.

    if type(options) == 'table' and type(options.locales) == 'table' then
      for index, locale in ipairs(options.locales) do
        plugin:registerLocale(locale)
      end
    end
  end
})
