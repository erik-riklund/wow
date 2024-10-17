--[[~ Widget: Tooltip Frame ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: ?

]]

---@type TooltipFrame
local tooltipFrame
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
---@param self TooltipFrame
backbone.widgetConstructors.tooltip = function(self)
  tooltipFrame = self -- store the reference locally for easy access.

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
end

---
--- Renders the tooltip for the given widget by setting its content,
--- anchor point, and size, and then displaying it.
---
---@param parent WidgetWithTooltip
backbone.widgetControllers.renderTooltip = function(parent)
  tooltipFrame.textLabel:SetText(parent.tooltipContent:GetText())
  backbone.widgetControllers.setTooltipAnchorPoint(parent)
  backbone.widgetControllers.renderTooltipArrow(parent)
  backbone.widgetControllers.updateTooltipSize()

  tooltipFrame:SetShown(true)
end

---
--- Positions and sizes the tooltip's arrow based on the parent widget's tooltip anchor point.
---
---@param parent WidgetWithTooltip
backbone.widgetControllers.renderTooltipArrow = function(parent)
  local arrow = arrowOptions[string.upper(parent.tooltipAnchorPoint:GetText())]

  for _, key in ipairs { 'arrowBase', 'arrowCenter', 'arrowTip' } do
    local texture = tooltipFrame[key] --[[@as Texture]]
    local segment = arrow[key] --[[@as TooltipFrameArrowSegment]]

    texture:SetPoint(
      arrow.point,
      tooltipFrame,
      arrow.relativePoint,
      segment.offsetX,
      segment.offsetY
    )

    texture:SetSize(segment.width, segment.height)
  end
end

---
--- Sets the anchor point of the tooltip based on the parent widget's tooltip anchor.
---
---@param parent WidgetWithTooltip
backbone.widgetControllers.setTooltipAnchorPoint = function(parent)
  tooltipFrame:SetPoint('CENTER', parent)

  local anchor = anchorPoints[string.upper(parent.tooltipAnchorPoint:GetText())]
  tooltipFrame:SetPoint(anchor.point, parent, anchor.relativePoint, anchor.offsetX, anchor.offsetY)
end

---
--- Updates the size of the tooltip frame based on its content dimensions.
---
backbone.widgetControllers.updateTooltipSize = function()
  local contentWidth = makeNumberEven(math.ceil(tooltipFrame.textLabel:GetStringWidth()))
  local contentHeight = makeNumberEven(math.ceil(tooltipFrame.textLabel:GetStringHeight()))

  tooltipFrame:SetSize(contentWidth + 24, contentHeight + 16)
end

---
--- Hides the tooltip frame.
---
backbone.widgetControllers.hideTooltip = function()
  tooltipFrame:SetShown(false)
  
  tooltipFrame:ClearAllPoints()
  tooltipFrame.arrowBase:ClearAllPoints()
  tooltipFrame.arrowCenter:ClearAllPoints()
  tooltipFrame.arrowTip:ClearAllPoints()
end
