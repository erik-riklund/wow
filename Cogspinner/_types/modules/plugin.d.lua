--- @meta
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- ?
--- 
--- @class plugin : network.pluginApi
--- @field identifier string The unique identifier for the plugin.
---

---
--- Creates and registers new plugin instances, returning their contexts wrapped
--- in immutable proxies to prevent accidental modifications.
--- 
--- @alias plugins.createPlugin fun(identifier: string, options?: plugins.createPlugin.options): plugin
---

---
--- @class plugins.createPlugin.options
--- @field channels? { name: string, internal?: boolean, async?: boolean }[]
---

---
--- ?
---
--- @alias plugins.retrievePluginContext fun(identifier: string): plugin
---
