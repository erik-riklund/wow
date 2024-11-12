--[[~ Border Templates ~
  Updated: 2024/11/10 | Author(s): Erik Riklund (Gopher)
]]

---
--- Sets the color for each side of the border (top, bottom, left, right) for the provided object.
--- If no color key is provided, it defaults to `borderColor`.
---
---@param object BackboneBorders
---@param colorKey? string
---
BackboneBorderTemplate_SetBorderColors = function(object, colorKey)
  for _, border in ipairs { 'top', 'bottom', 'right', 'left' } do
    local key = border .. 'Border'
    if object[key] ~= nil then
      (object[key]--[[@as Texture]]):SetColorTexture( --
        backbone.getColor(colorKey or 'borderColor')
      )
    end
  end
end

---
--- Sets the shader color for each side of the border (top, bottom, left, right) for the provided object.
--- If no color key is provided, it defaults to `borderShaderColor`.
---
---@param object BackboneBorders
---@param colorKey? string
---
BackboneBorderTemplate_SetBorderShaderColors = function(object, colorKey)
  for _, border in ipairs { 'top', 'bottom', 'right', 'left' } do
    local key = border .. 'BorderShader'
    if object[key] ~= nil then
      (object[key]--[[@as Texture]]):SetColorTexture( --
        backbone.getColor(colorKey or 'borderShaderColor')
      )
    end
  end
end
