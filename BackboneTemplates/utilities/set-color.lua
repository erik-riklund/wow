--[[~ Module: ? ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@param object FontString
---@param colorKey string
---
backbone.widgets.setFontColor = function(object, colorKey)
  object:SetTextColor(backbone.getColor(colorKey)) --
end

---
--- ?
---
---@param object Texture
---@param colorKey string
---
backbone.widgets.setTextureColor = function(object, colorKey)
  object:SetColorTexture(backbone.getColor(colorKey)) --
end
