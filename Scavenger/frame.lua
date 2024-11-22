---@diagnostic disable: undefined-field, undefined-global

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
    identifier = 'HIDE_LOOT_FRAME',

    callback = function()
      frame_position = {
        LootFrame:GetPoint(E_ANCHOR_POINT.TOPLEFT)
      }

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

    callback = function()
      if backbone.hasPlugin 'Slate_LootFrame' then
        -- the following line should be enabled once Slate_LootFrame is working properly.
        -- return context.plugin:removeChannelListener('LOOT_PROCESSED', 'SHOW_LOOT_FRAME')
      end

      LootFrame:ClearAllPoints()
      LootFrame:SetPoint(unpack(frame_position))
    end
  }
)
