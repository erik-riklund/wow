local ADDON, Framework = ...

--
--      #
--     # #   #    #  ####  #    # ###### #    # #####
--    #   #  #    # #    # ##  ## #      ##   #   #
--   #     # #    # #      # ## # #####  # #  #   #
--   ####### #    # #  ### #    # #      #  # #   #
--   #     # #    # #    # #    # #      #   ##   #
--   #     #  ####   ####  #    # ###### #    #   #
--
-- World of Warcraft addon ecosystem, created by Erik Riklund (2024)
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--
local Type, Task, Map, Array =
  Import(
  {
    "Core.TypeHandler",
    "Core.Task",
    "Core.Types.Map",
    "Core.Types.Array"
  }
)
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ EventHandler ]
--
-- ???
--
local EventHandler = {
  --
  --[ _frame ]
  --
  -- ???
  --
  _frame = nil,
  --
  --[ _subscriptions ]
  --
  -- ???
  --
  _subscriptions = Map:Create("string", "boolean"),
  --
  --[  ]
  --
  -- ???
  --
  _listeners = Map:Create("string", "array(function)"),
  --
  --[ Listen ]
  --
  -- ???
  --
  Listen = function(self, event, callback)
    local event, callback = Type:Is("string", event), Type:Is("function", callback)

    if not self._subscriptions:Has(event) then
      self:_subscribe(event)
    end

    -- ???
  end,
  --
  --[ Dispatch ]
  --
  -- ???
  --
  Dispatch = function(self, event, ...)
    local event = Type:Is("string", event)

    -- ???
  end,
  --
  --[ OnLoad ]
  --
  -- ???
  --
  OnLoad = function(self, addon, callback)
    local addon, callback = Type:Is("string", addon), Type:Is("function", callback)

    -- ???
  end,
  --
  --[ _subscribe ]
  --
  -- ???
  --
  _subscribe = function(self, event)
    if not self._frame then
      self._frame = CreateFrame("Frame")
      self._frame:SetScript("OnEvent", self.Dispatch)
    end

    pcall(function() self._frame:RegisterEvent(event) end)
    self._subscriptions:Set(event, true)
  end
}

--
--[ OnLoad ]
--
-- ???
--
OnLoad = function(addon, callback)
  EventHandler:OnLoad(addon, callback)
end

--
-- ???
--
EventHandler:Listen(
  "PLUGIN_ADDED",
  function(plugin)
    print("New plugin added.")
  end
)

--
-- We maintain an internal reference to be able to dispatch events from within the framework.
-- While the event API exposed to plugins is limited to events reserved upon plugin initialization,
-- using the event dispatcher directly allow us to trigger any event required using this reference.
--
Framework.EventHandler = EventHandler
