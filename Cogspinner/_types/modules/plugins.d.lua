--- @meta
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- @class plugin : events.api, network.api, storage.api
--- @field identifier string
---

---
--- Creates a new plugin context to facilitate interaction with the framework's modules and services.
--- @alias plugins.createPlugin fun(identifier: string, options?: plugins.createPlugin.options): plugin
---

---
--- @class plugins.createPlugin.options
--- 
--- @field channels? { name: string, internal?: boolean, async?: boolean }[]
--- @field variables? { account?: string, character?: string }
---
