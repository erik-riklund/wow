--- @meta
--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--
--- @class Plugin : Context
--- 
--- @field name string
--

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

--
--- @class PluginManager
--- 
--- @field plugins Record
--- @field createPlugin fun(self: PluginManager, options: PluginCreationOptions): Plugin
--- @field setupPluginContext fun(self: PluginManager, context: table): Plugin
--

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

--
--- @class PluginCreationOptions
--- 
--- @field name string
--- @field context? table
--
