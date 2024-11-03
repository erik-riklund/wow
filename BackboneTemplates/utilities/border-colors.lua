--[[~ Module: Utilities ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

local borders = {
  'topBorder',
  'bottomBorder',
  'leftBorder',
  'rightBorder',
}

---
--- ?
---
---@param object BackboneBorders
---@param colors? BackboneBorderColors
---
backbone.widgets.setBorderColors = function(object, colors)
  colors = colors or {}

  for _, suffix in ipairs { '', 'Shader' } do
    for _, side in ipairs(borders) do
      local border = side .. suffix

      print (border)

      if object[border] then
        (object[border] --[[@as Texture]]):SetColorTexture( --
          backbone.getColor(colors['border' .. suffix] or ('border' .. suffix .. 'Color'))
        )
      end
    end
  end
end
