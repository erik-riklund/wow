--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/ui (2026)

--- @class context
local x = select(2, ...)

--
-- # Default UI override
--
-- Unregisters all events from the default loot frame to disable it.
--

local target_frame = LootFrame
target_frame:UnregisterAllEvents() -- disable during development.

--
-- # Processing pipeline
--
-- An ordered list of functions executed sequentially when the LOOT_SORTED event occurs.
-- Each function takes the current loot slots and a shared context table,
-- allowing operations like filtering, sorting, or injecting data to be chained.
--

x.process = {}

--
-- # Slot-specific handlers
--
-- Registry for different types of loot slots (e.g., items, currencies, junk).
-- These handlers define how a specific type of slot behaves, how its recycled
-- button is configured, and how its visuals are updated.
--

x.slot_handlers = {}

--
-- # ?
--
-- ...
--

x.localizations = {}

--
-- # Loot sorted event hook
--
-- Listens for the "LOOT_SORTED" event, which fires after the core module
-- finishes auto-looting and has sorted the remaining items.
--
-- It creates a temporary, shared context table and runs the entire
-- pipeline step-by-step. This shared table allows earlier steps to pass
-- calculated data or flags down to later steps in the process.
--

Scavenger.add_event_hook(
  "LOOT_SORTED", function(slots)
    local context = {
      slot_count = #slots
    }

    for _, operation in ipairs(x.process) do
      operation(slots, context)
    end
  end
)
