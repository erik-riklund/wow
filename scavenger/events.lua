--                                  |___/
--   github.com/erik-riklund/wow/scavenger

local _, context = ...

local event_handler = {
  hooks = {},
  frame = CreateFrame("Frame"),
  game_events = {
    "LOOT_OPENED",
    "LOOT_CLOSED",
    "LOOT_SLOT_CLEARED",
  }
}

for _, event_name in ipairs(event_handler.game_events) do
  event_handler.frame:RegisterEvent(event_name)
end

context.invoke_listeners = function (event_name, ...)
  if type(event_handler.hooks[event_name]) == "table" then
    for index, callback in ipairs(event_handler.hooks[event_name]) do
      if type(callback) == "function" then
        local success, result = pcall(callback, ...)
        if not success then
          print(event_name .. ": Callback failed at index " .. index)
          print(result)
        end
      end
    end
  end
end

context.add_event_hook = function (event_name, callback)
  if not event_handler.hooks[event_name] then
    event_handler.hooks[event_name] = {}
  end
  table.insert(event_handler.hooks[event_name], callback)

  return function()
    for index, hook in ipairs(event_handler.hooks[event_name]) do
      if hook == callback then
        table.remove(event_handler.hooks[event_name], index)
        return -- stops execution once the listener is found.
      end
    end
  end
end

event_handler.frame:SetScript(
  "OnEvent", function(_, event_name, ...)
    context.invoke_listeners(event_name, ...)
  end
)
