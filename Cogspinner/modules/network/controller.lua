--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, core.context
local addon, framework = ...

--- @type listenerManager.constructor
local createListenerManager = framework.import('shared/listeners')

---
--- ?
---
--- @type table<string, network.channel>
---
local channels = {}

--
-- ?
--

--- @type network.reserveChannel
local reserveChannel = function(name, options) end

--
-- Expose the functions to the framework context.
--
framework.export('channel/reserve', reserveChannel)
