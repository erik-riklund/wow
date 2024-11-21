---@class Scavenger
local context = select(2, ...)

--[[~ Loot frame integration (module) ~
  Updated: 2024/11/21 | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
--- 
---@type table
---
local frame_position

---
--- ?
---
context.plugin:registerEventListener(
  'LOOT_OPENED',
  {
    persistent = false,
    identifier = 'LOOT_FRAME_POSITION',
    
    callback = function()
      frame_position = { LootFrame:GetPoint(E_ANCHOR_POINT.TOPLEFT) }
    end
  }
)

---
--- ?
---
context.plugin:registerEventListener(
  'LOOT_OPENED',
  {
    identifier = 'HIDE_LOOT_FRAME',

    callback = function()
      LootFrame:ClearAllPoints()
      LootFrame:SetClampedToScreen(false)

      LootFrame:SetPoint('TOPLEFT', UIParent, 'TOPRIGHT', 20, 0)
    end
  }
)

---
--- ?
---
context.plugin:registerChannelListener(
  'LOOT_PROCESSED',
  {
    identifier = 'SHOW_LOOT_FRAME',

    ---@param remaining_slots Vector
    callback = function(remaining_slots)
      LootFrame:SetPoint(unpack(frame_position))

      print 'scavenger: updating the loot frame visually (not implemented)'
      -- self:SetHeight(self:CalculateElementsHeight());
    end
  }
)
