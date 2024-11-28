---@diagnostic disable: undefined-field, undefined-global

---@class Scavenger
local context = select(2, ...)

--[[~ Updated: 2024/11/28 | Author(s): Gopher ]]

---@type table
local frame_position

--- ?
context.plugin:registerEventListener(
  'LOOT_OPENED',
  {
    identifier = 'HIDE_LOOT_FRAME',

    callback = function()
      frame_position = {
        LootFrame:GetPoint(ENUM.ANCHOR_POINT.TOPLEFT)
      }

      LootFrame:ClearAllPoints()
      LootFrame:SetClampedToScreen(false)

      LootFrame:SetPoint('TOPLEFT', UIParent, 'TOPRIGHT', 20, 0)
    end
  }
)

--- ?
context.plugin:registerChannelListener(
  'LOOT_PROCESSED',
  {
    identifier = 'SHOW_LOOT_FRAME',

    callback = function()
      if backbone.hasPlugin 'Spoils' then
        --Spoils is not completed, uncomment this section when it is.
        --context.plugin:removeChannelListener('LOOT_PROCESSED', 'SHOW_LOOT_FRAME')
      end

      LootFrame:ClearAllPoints()
      LootFrame:SetPoint(unpack(frame_position))
    end
  }
)
