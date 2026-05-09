--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
--   github.com/erik-riklund/wow/scavenger/core (2026)

---@class context
local x = select(2, ...)

---------------------------------------------------------------------
-- ?

local event_hooks = {}
local event_frame = CreateFrame("Frame")

event_frame:RegisterEvent("ADDON_LOADED")
event_frame:RegisterEvent("LOOT_OPENED")
event_frame:RegisterEvent("LOOT_CLOSED")
event_frame:RegisterEvent("LOOT_SLOT_CLEARED")

---------------------------------------------------------------------
-- ?

x.invoke_listeners = function(event_name, ...)
  if event_hooks[event_name] == nil then
    -- todo > print a warning
  else
    for _, callback in ipairs(event_hooks[event_name]) do
      if type(callback) == "function" then
        callback(...) -- invoke each hook in the order they were registered.
      end
    end
  end
end

---------------------------------------------------------------------
-- ?

event_frame:SetScript(
  "OnEvent", function(_, event_name, ...)
    if event_name == "ADDON_LOADED" then
      local addon_name = ...
      if addon_name ~= "Scavenger" then
        return -- ?
      end
    end

    x.invoke_listeners(event_name, ...)
  end
)

---------------------------------------------------------------------
-- ?

Scavenger.extend(
  "add_event_hook", function(event_name, callback)
    if not event_hooks[event_name] then
      event_hooks[event_name] = {}
    end
    table.insert(event_hooks[event_name], callback)

    return function()
      for index, hook in ipairs(event_hooks[event_name]) do
        if hook == callback then
          table.remove(event_hooks[event_name], index)
          break -- ?
        end
      end
    end
  end
)
