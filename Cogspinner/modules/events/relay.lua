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
--- @type Frame
local frame = framework.import('core/frame')
--- @type events.handler
local eventHandler = framework.import('events/handler')
-- #endregion

--
-- ?
--
frame:RegisterEvent('ADDON_LOADED')

--
-- ?
--
frame:SetScript('OnEvent', function(self, event, ...)
  local arguments = { ... }

  if event == 'ADDON_LOADED' then
    -- ?
    event = 'ADDON_LOADED:' .. arguments[1]
    table.remove(arguments, 1)
  end

  eventHandler.invokeEvent(event, arguments)
end)
