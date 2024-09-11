--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, context
local addon, framework = ...

-- #region << imports >>
--- @type events.handler
local events = framework.import('events/handler')
--- @type network.controller
local network = framework.import('network/controller')
-- #endregion

---
--- ?
---
--- @type events.api
---
local api = {
  --
  -- ?
  --
  onInitialize = function(self, callback)
    events.registerListener('ADDON_LOADED:' .. self.identifier, { callback = callback })
  end,

  --
  -- ?
  --
  registerEventListener = function(self, event, listener)
    if event == 'ADDON_LOADED' then
      throw('Use `onInitialize` to register listeners for "ADDON_LOADED"')
    end

    events.registerListener(event, listener, self)
  end,

  --
  -- ?
  --
  removeEventListener = function(self, event, identifier)
    if event == 'ADDON_LOADED' then
      throw('Unable to remove listeners for "ADDON_LOADED"')
    end

    events.removeListener(event, identifier, self)
  end
}

--
-- ?
--
network.registerListener('PLUGIN_ADDED', {
  --- @param plugin plugin
  callback = function(plugin)
    -- todo: integration of the events API.
  end
})
