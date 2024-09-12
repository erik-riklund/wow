--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework.context
local addon, framework = ...

-- #region << imports >>
--- @type Frame
local frame = framework.import('core/frame')
--- @type events.handler
local eventHandler = framework.import('events/handler')
-- #endregion

--
-- Registers the 'ADDON_LOADED' event to the frame, as it requires separate handling.
--
frame:RegisterEvent('ADDON_LOADED')

--
-- Attaches a script to the frame's 'OnEvent' event, triggering it whenever a registered
-- event occurs. This script processes the event and its arguments, delegating further
-- handling to the event handler.
--
frame:SetScript('OnEvent', function(self, event, ...)
  local arguments = { ... }

  if event == 'ADDON_LOADED' then
    -- Modifies the 'ADDON_LOADED' event to include the addon name, as this
    -- aligns with our internal listener organization for this event.

    event = 'ADDON_LOADED:' .. arguments[1]
    table.remove(arguments, 1)
  end

  eventHandler.invokeEvent(event, arguments)
end)
