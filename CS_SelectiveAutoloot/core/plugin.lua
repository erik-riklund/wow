--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, context
local addon, context = ...

---
--- ?
--- 
--- @type plugins.createPlugin.options
---
local options = { variables = { account = 'CS_SelectiveAutoloot_Account' } }

---
--- ?
---
context:export('plugin', cogspinner.createPlugin(addon, options));
