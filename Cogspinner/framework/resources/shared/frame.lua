--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ... --- @cast context core.context

--#region (context imports)

--- @type utility.collection.list
local list = context:import('utility/collection/list')

--#endregion

--#region (locally scoped variables)

local create_frame = CreateFrame

--#endregion

--
-- This module manages a shared frame and provides a mechanism for registering
-- functions to be called during the `OnUpdate` event. This centralizes frame-based
-- updates and promotes code organization.
--

--- @type resource.shared.frame
local controller =
{
  --
  -- A list to store functions (update handlers)
  -- that will be called on each frame update.
  --

  update_handlers = list(),

  --
  -- The underlying frame object that triggers the `OnUpdate` script. This frame is
  -- invisible and serves as the central point for managing updates.
  --

  frame = create_frame('Frame', 'CogspinnerFrame'),

  --
  -- Registers a new update handler function to be called on each frame update.
  --

  register = function(self, update_handler)
    self.update_handlers:insert(update_handler)
  end
}

--
-- Attaches an `OnUpdate` script to the frame. This script iterates
-- through the registered update handlers and attempts to execute them,
-- providing basic error handling.
--

controller.frame:SetScript(
  'OnUpdate', function()
    local handlers = controller.update_handlers:length()

    for i = 1, handlers do
      local success = pcall(controller.update_handlers:get(i))

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

context:export('resources/shared/frame', controller)
