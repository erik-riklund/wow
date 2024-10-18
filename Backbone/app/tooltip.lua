--[[~ Widget: Tooltip Frame ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: 2024/10/17

]]

local self = _G.BackboneTooltipFrame --[[@as TooltipFrame]]
local makeNumberEven = backbone.utilities.makeNumberEven

---@type { [string]: TooltipFrameAnchorPoint }
local anchorPoints = {
  UP = { point = 'BOTTOM', relativePoint = 'TOP', offsetX = 0, offsetY = 5 },
  DOWN = { point = 'TOP', relativePoint = 'BOTTOM', offsetX = 0, offsetY = -5 },
  RIGHT = { point = 'LEFT', relativePoint = 'RIGHT', offsetX = 5, offsetY = 0 },
  LEFT = { point = 'RIGHT', relativePoint = 'LEFT', offsetX = -5, offsetY = 0 },
}

---@type { [string]: TooltipFrameArrowTextures }
local arrowOptions = {
  UP = {
    point = 'TOP',
    relativePoint = 'BOTTOM',

    arrowBase = {
      width = 6,
      height = 1,
      offsetX = 0,
      offsetY = -1,
    },
    arrowCenter = {
      width = 4,
      height = 1,
      offsetX = 0,
      offsetY = -2,
    },
    arrowTip = {
      width = 2,
      height = 1,
      offsetX = 0,
      offsetY = -3,
    },
  },

  DOWN = {
    point = 'BOTTOM',
    relativePoint = 'TOP',

    arrowBase = {
      width = 6,
      height = 1,
      offsetX = 0,
      offsetY = 1,
    },

    arrowCenter = {
      width = 4,
      height = 1,
      offsetX = 0,
      offsetY = 2,
    },

    arrowTip = {
      width = 2,
      height = 1,
      offsetX = 0,
      offsetY = 3,
    },
  },

  RIGHT = {
    point = 'RIGHT',
    relativePoint = 'LEFT',

    arrowBase = {
      width = 1,
      height = 6,
      offsetX = -1,
      offsetY = 0,
    },

    arrowCenter = {
      width = 1,
      height = 4,
      offsetX = -2,
      offsetY = 0,
    },

    arrowTip = {
      width = 0,
      height = 2,
      offsetX = -3,
      offsetY = 0,
    },
  },

  LEFT = {
    point = 'LEFT',
    relativePoint = 'RIGHT',

    arrowBase = {
      width = 1,
      height = 6,
      offsetX = 1,
      offsetY = 0,
    },

    arrowCenter = {
      width = 1,
      height = 4,
      offsetX = 2,
      offsetY = 0,
    },

    arrowTip = {
      width = 0,
      height = 2,
      offsetX = 3,
      offsetY = 0,
    },
  },
}

---
--- Initializes the tooltip frame, registering border colors and themeable textures.
---

backbone.widgetConstructors.borderedFrame(self, {
  topBorder = 'tooltipFrameBorderColor',
  rightBorder = 'tooltipFrameBorderColor',
  bottomBorder = 'tooltipFrameBorderColor',
  leftBorder = 'tooltipFrameBorderColor',
}) -- parent constructor.

backbone.registerThemeableTextures {
  {
    object = self.arrowBase,
    colorKey = 'tooltipFrameArrowColor',
  },
  {
    object = self.arrowCenter,
    colorKey = 'tooltipFrameArrowColor',
  },
  {
    object = self.arrowTip,
    colorKey = 'tooltipFrameArrowColor',
  },
  {
    object = self.backgroundColor,
    colorKey = 'tooltipFrameBackgroundColor',
  },
}
backbone.registerThemeableLabels {
  { object = self.textLabel, colorKey = 'tooltipFrameContentColor' },
}

---
--- Positions and sizes the tooltip's arrow based on the parent widget's tooltip anchor point.
---
---@param parent WidgetWithTooltip
local renderTooltipArrow = function(parent)
  local arrow = arrowOptions[string.upper(parent.tooltipAnchorPoint:GetText())]

  for _, key in ipairs { 'arrowBase', 'arrowCenter', 'arrowTip' } do
    local texture = self[key] --[[@as Texture]]
    local segment = arrow[key] --[[@as TooltipFrameArrowSegment]]

    texture:SetPoint(arrow.point, self, arrow.relativePoint, segment.offsetX, segment.offsetY)
    texture:SetSize(segment.width, segment.height)
  end
end

---
--- Sets the anchor point of the tooltip based on the parent widget's tooltip anchor.
---
---@param parent WidgetWithTooltip
local setTooltipAnchorPoint = function(parent)
  self:SetPoint('CENTER', parent)

  local anchor = anchorPoints[string.upper(parent.tooltipAnchorPoint:GetText())]
  self:SetPoint(anchor.point, parent, anchor.relativePoint, anchor.offsetX, anchor.offsetY)
end

---
--- Updates the size of the tooltip frame based on its content dimensions.
---
local updateTooltipSize = function()
  local contentWidth = makeNumberEven(math.ceil(self.textLabel:GetStringWidth()))
  local contentHeight = makeNumberEven(math.ceil(self.textLabel:GetStringHeight()))

  self:SetSize(contentWidth + 24, contentHeight + 16)
end

---
--- Renders the tooltip for the given widget by setting its content,
--- anchor point, and size, and then displaying it.
---
---@param parent WidgetWithTooltip
backbone.widgetControllers.renderTooltip = function(parent)
  self.textLabel:SetText(parent.tooltipContent:GetText())

  setTooltipAnchorPoint(parent)
  renderTooltipArrow(parent)
  updateTooltipSize()

  self:SetShown(true)
end

---
--- Hides the tooltip frame.
---
backbone.widgetControllers.hideTooltip = function()
  self:SetShown(false)
  self:ClearAllPoints()

  self.arrowBase:ClearAllPoints()
  self.arrowCenter:ClearAllPoints()
  self.arrowTip:ClearAllPoints()
end
