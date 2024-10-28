---@class Scavenger
local context = select(2, ...)

--[[~ Module: ? ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

backbone.registerCommandHandler {
  command = 'scavenger',
  identifier = 'ScavengerCustomFilters',
  --
  callback = function(message)
    local action, item = string.split(' ', message, 2)
    local filters = context.config:getVariable 'FILTERS'

    action = string.upper(action)
    if action ~= 'LOOT' and action ~= 'IGNORE' then
      print 'Expected syntax: /scavenger [LOOT \124 IGNORE] <ITEM>'
      return -- cancel the execution.
    end

    local itemId = backbone.getItemId(item)
    filters[action][itemId] = (filters[action][itemId] == nil) or nil
  end,
}
