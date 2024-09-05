--- @meta
--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--
--- @class Plugin : NetworkApi
--- 
--- @field name string
--

--
--- @class PluginOptions
--- 
--- @field channels? ChannelReservation[]
--

--
--- Factory function that creates and registers new plugin contexts within the framework.
--- 
--- @alias PluginConstructor fun(name: string, options?: PluginOptions): Plugin
--
