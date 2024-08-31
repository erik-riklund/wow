--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, FrameworkContext
local addon, context  = ...

--#region (locally scoped variables/functions)

local createFrame     = _G.CreateFrame
local select          = _G.select
local unpack          = _G.unpack

--#endregion

--#region (framework context imports)

local map             = context:import('collection/map') --[[@as MapConstructor]]
local list            = context:import('collection/list') --[[@as ListConstructor]]

--#endregion

--
-- This module centralizes frame-based updates and event handling by providing a
-- mechanism for registering functions to be called during the `OnUpdate` event
-- and in response to game events.
--

--- @type CoreFrame
local FrameController =
{
  --
  -- A map to track registered events, to avoid redundant registrations.
  --

  events = map(),

  --
  -- A list to store functions that will be called on each frame update.
  --

  updateHandlers = list(),

  --
  -- A list to store functions that will be called when game events occur.
  --

  eventHandlers = list(),

  --
  -- The underlying frame object that triggers the `OnUpdate` script. This frame is
  -- invisible and serves as the central point for managing updates.
  --

  frame = createFrame('Frame', 'CogspinnerFrame'),

  --
  -- Registers a new update handler function to be called on each frame update. We check
  -- if the handler is already registered to prevent duplicates and potential errors.
  --

  RegisterUpdateHandler = function(self, callback)
    if self.updateHandlers:Contains(callback) then
      throw('?')
    end

    self.updateHandlers:Insert(callback)
  end,

  --
  -- Registers a new event handler function to be called when a registered game event
  -- occurs. Similar to update handlers, we prevent duplicate registrations.
  --

  RegisterEventHandler = function(self, callback)
    if self.eventHandlers:Contains(callback) then
      throw('?')
    end

    self.eventHandlers:Insert(callback)
  end,

  --
  -- Registers the frame to listen for a specific game event. We track registered
  -- events to avoid unnecessary duplicate registrations.
  --

  RegisterEvent = function(self, event)
    if not self.events:Has(event) then
      self.frame:RegisterEvent(event)
      self.events:Set(event, true)
    end
  end,

  --
  -- Unregisters the frame from listening to a specific game event.
  --

  UnregisterEvent = function(self, event)
    if self.events:Has(event) then
      self.frame:UnregisterEvent(event)
      self.events:Drop(event)
    end
  end
}

--
-- ?
--

FrameController.frame:RegisterEvent('ADDON_LOADED')

--
-- Attaches an `OnUpdate` script to the frame. This script iterates
-- through the registered update handlers and attempts to execute them,
-- providing basic error handling.
--

FrameController.frame:SetScript(
  'OnUpdate', function()
    local handler_count = FrameController.updateHandlers:Length()

    for i = 1, handler_count do
      local success = pcall(FrameController.updateHandlers:Get(i))

      if not success then
        --#todo: implement error handling!
      end
    end
  end
)

--
-- Attaches an `OnEvent` script to the frame. This script is triggered when
-- any of the registered events occur. It iterates through the registered event
-- handlers and attempts to execute them, providing basic error handling.
--

FrameController.frame:SetScript(
  'OnEvent', function(...)
    local args = { ... }

    local event_name = args[2] --[[@as string]]
    local event_data = { select(3, ...) }

    local handler_count = FrameController.eventHandlers:Length()

    for i = 1, handler_count do
      local success, result = pcall(
        FrameController.eventHandlers:Get(i), event_name, unpack(event_data)
      )

      if not success then
        --#todo: implement error handling!
      end
    end
  end
)

--
-- Exports the controller object to the framework context,
-- making it accessible to other modules.
--

context:export('core/frame', FrameController)
