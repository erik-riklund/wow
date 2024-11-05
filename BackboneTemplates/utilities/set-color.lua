--[[~ Module: Widgets / Utilities ~
  Updated: 2024/11/05 | Author(s): Erik Riklund (Gopher)
]]

---
--- Sets the text color of the provided object.
---
---@param object FontString
---@param colorKey string
---
backbone.widgets.setFontColor = function(object, colorKey)
  object:SetTextColor(backbone.getColor(colorKey)) --
end

---
--- Sets the color of the provided texture object.
---
---@param object Texture
---@param colorKey string
---
backbone.widgets.setTextureColor = function(object, colorKey)
  object:SetColorTexture(backbone.getColor(colorKey)) --
end
