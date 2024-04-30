local ADDON, CORE = ...
local T = Type

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
local EventHandler = CORE.EventHandler
local Events = EventHandler.Events
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--

--

EventHandler.Reciever:SetScript(
  "OnEvent",
  --
  function(self, event, ...)
    --
    local args = ...

    Switch(
      event,
      {
        ADDON_LOADED = function()
          EventHandler:OnLoad(args)
        end,
        --
        default = function()
          EventHandler:Dispatch(event, args)
        end
      }
    )
  end
)

--

--

Listen(
  "PLUGIN_ADDED",
  --
  function(plugin)
    --
    function plugin:ReserveEvent(event)
      --
      local events = T:Check("events", events, T:String())
      EventHandler:ReserveEvent(self, event)
    end

    function plugin:ReserveEvents(events)
      --
      local events = T:Check("events", events, T:Array(Type:String()))

      for _, event in ipairs(events) do
        EventHandler:ReserveEvent(self, event)
      end
    end

    function plugin:Dispatch(event, ...)
      Dispatch(self, event, ...)
    end
  end
)

--
--- Checks if a specific plugin is authorized to trigger a particular event.
--
-- This function enforces rules within the event handling system to ensure that only 
-- authorized plugins can trigger specific events.
--
-- @param plugin table The plugin context object.
-- @param event string The name of the event.
-- @return boolean True if the plugin is allowed to invoke the event, false otherwise.
-- @throws error If the plugin is not authorized to trigger the event. The error message 
--               includes the event name and the plugin ID.
--

function EventHandler:IsInvokable(plugin, event)
  --
  if Events.Plugins[event] ~= plugin.id then
    --
    Throw(
      "Cannot invoke event '$event' from $plugin",
      {
        event = event,
        plugin = plugin.id
      }
    )
  end

  return true
end

--
--- Reserves an event for exclusive use by a specified plugin.
--
-- This function is intended to enforce ownership within the event handling system. It prevents
-- conflicts by ensuring an event can only be associated with a single plugin at a time.
--
-- @param plugin table A plugin context object.
-- @param event string The name of the event to reserve.
-- @throws error If the event is a standard game event or if the event is already reserved
--               by another plugin. The error message includes the event name and the ID
--               of the plugin (if applicable).
--

function EventHandler:ReserveEvent(plugin, event)
  --
  local plugin = T:Check("plugin", plugin, T:Table())
  local event = T:Check("event", event, T:String())

  if self:IsGameEvent(event) then
    --
    Throw(
      "Unable to reserve game event '$event' for plugin $plugin",
      {
        event = event,
        plugin = plugin.id
      }
    )
  end

  if Table:HasKey(Events.Plugins, event) then
    --
    Throw(
      "Unable to reserve event '$event', already in use by plugin $plugin",
      {
        event = event,
        plugin = Events.Plugins[event]
      }
    )
  end

  Events.Plugins[event] = plugin.id
end
