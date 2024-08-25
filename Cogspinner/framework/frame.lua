--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ...
--- @cast context core.context

local create_frame, select, unpack = CreateFrame, select, unpack

--#region (context imports)

--- @type utility.collection.map
local map = context:import('utility/collection/map')

--- @type utility.collection.list
local list = context:import('utility/collection/list')

--#endregion

--
-- This module centralizes frame-based updates and event handling by providing a
-- mechanism for registering functions to be called during the `OnUpdate` event
-- and in response to game events.
--

--- @type framework.frame
local controller =
{
  --
  -- A map to track registered events, to avoid redundant registrations.
  --

  events = map(),

  --
  -- A list to store functions that will be called on each frame update.
  --

  update_handlers = list(),

  --
  -- A list to store functions that will be called when game events occur.
  --

  event_handlers = list(),

  --
  -- The underlying frame object that triggers the `OnUpdate` script. This frame is
  -- invisible and serves as the central point for managing updates.
  --

  frame = create_frame('Frame', 'CogspinnerFrame'),

  --
  -- Registers a new update handler function to be called on each frame update. We check
  -- if the handler is already registered to prevent duplicates and potential errors.
  --

  register_update_handler = function(self, callback)
    if self.update_handlers:contains(callback) then
      throw('?')
    end

    self.update_handlers:insert(callback)
  end,

  --
  -- Registers a new event handler function to be called when a registered game event
  -- occurs. Similar to update handlers, we prevent duplicate registrations.
  --

  register_event_handler = function(self, callback)
    if self.event_handlers:contains(callback) then
      throw('?')
    end

    self.event_handlers:insert(callback)
  end,

  --
  -- Registers the frame to listen for a specific game event. We track registered
  -- events to avoid unnecessary duplicate registrations.
  --

  register_event = function(self, event_name)
    if not self.events:has(event_name) then
      self.frame:RegisterEvent(event_name)
      self.events:set(event_name, true)
    end
  end,

  --
  -- Unregisters the frame from listening to a specific game event.
  --

  unregister_event = function(self, event_name)
    if self.events:has(event_name) then
      self.frame:UnregisterEvent(event_name)
      self.events:drop(event_name)
    end
  end
}

--
-- ?
--

controller.frame:RegisterEvent('ADDON_LOADED')

--
-- Attaches an `OnUpdate` script to the frame. This script iterates
-- through the registered update handlers and attempts to execute them,
-- providing basic error handling.
--

controller.frame:SetScript(
  'OnUpdate', function()
    local handler_count = controller.update_handlers:length()

    for i = 1, handler_count do
      local success = pcall(controller.update_handlers:get(i))

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

controller.frame:SetScript(
  'OnEvent', function(...)
    local args = { ... }

    local event_name = args[2] --[[@as string]]
    local event_data = { select(3, ...) }

    local handler_count = controller.event_handlers:length()

    for i = 1, handler_count do
      local success, result = pcall(
        controller.event_handlers:get(i), event_name, unpack(event_data)
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

context:export('frame', controller)
