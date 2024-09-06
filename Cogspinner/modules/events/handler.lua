--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Context
local addon, framework      = ...
local exception             = _G.exception
local type                  = _G.type

local beginsWith            = framework.import('string/begins') --[[@as InitialSubstring]]
local createListenerManager = framework.import('shared/listeners') --[[@as ListenerManagerConstructor]]
local createRecord          = framework.import('collection/record') --[[@as RecordConstructor]]
local mergeTables           = framework.import('table/merge') --[[@as TableMerger]]

--
-- ?
--
--- @type Frame
--
local frame                 = CreateFrame('Frame', 'CogspinnerEventHandler')

--
-- ?
--
frame:SetShown(false)

--
-- ?
--
frame:RegisterEvent('ADDON_LOADED')

--
-- ?
--
local events = createRecord()

--
-- ?
--
--- @type EventHandler
--
local handler =
{
  --
  -- ?
  --
  registerListener = function(event, listener, context)
    --~ ?

    if type(event) ~= 'string' then
      exception('?')
    end

    if type(listener) ~= 'table' then
      exception('?')
    end

    if context and type(context) ~= 'string' then
      exception('?')
    end

    --~ ?

    if not events:entryExists(event) then
      if not beginsWith(event, 'ADDON_LOADED') then
        frame:RegisterEvent(event)
      end

      events:set(event, createListenerManager())
    end

    --~ ?

    (events:get(event) --[[@as Event]]):registerListener(
      mergeTables(listener, { owner = context }) --[[@as EventListener]]
    )
  end,

  --
  -- ?
  --
  removeListener = function(event, identifier, context)
    --~ ?

    if type(event) ~= 'string' then
      exception('?')
    end

    if type(identifier) ~= 'string' then
      exception('?')
    end

    if context and type(context) ~= 'string' then
      exception('?')
    end

    --~ ?

    -- todo: verify existence and ownership of the listener before attempting to remove it.

    --~ ?

    -- todo: unregister event completely if no listeners are active.
  end,

  --
  -- ?
  --
  invokeEvent = function(event, ...)
    --~ ?

    if events:entryExists(event) then
      (events:get(event) --[[@as Event]]):invokeListeners({ ... })
    end
  end
}

--
-- ?
--
frame:SetScript('OnEvent',
  function(self, event, ...)
    --~ ?

    if event == 'ADDON_LOADED' then
      local loadedAddonName = ...
      event = 'ADDON_LOADED:' .. loadedAddonName
    end

    --~ ?

    handler.invokeEvent(event, ...)
  end
)

--
-- ?
--
framework.export('module/events', handler)
