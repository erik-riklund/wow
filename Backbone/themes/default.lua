--[[~ Module: Theme / Backbone ~
  Updated: 2024/11/10 | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
local palette = {
  BLACK = { 0, 0, 0, 1 }, -- Pure black.
  NIGHT_FOG = { 0.08, 0.09, 0.12, 1 }, -- Dark, muted, with a slight foggy feel, like a misty night.
  DEEP_OIL = { 0.12, 0.12, 0.12, 1 }, -- Slightly lighter than pure black, like crude oil.
  SHADOW_ONYX = { 0.06, 0.07, 0.09, 1 }, -- Very dark with a hint of blue, like onyx in shadow.
  CHARRED_COAL = { 0.17, 0.17, 0.17 }, -- Dark gray, reminiscent of charcoal.
  PARCHMENT = { 0.96, 0.87, 0.70, 1 }, -- Warm, light tan, like aged parchment.
  SUNBURST = { 1.0, 0.78, 0, 1 }, -- Bright golden-yellow, reminiscent of sunlight.
  WHITE = { 1, 1, 1, 1 }, -- Pure white.
}

---
--- ?
---
backbone.registerColorTheme('Backbone', {
  borderColor = palette.BLACK,
  borderShaderColor = backbone.setColorAlpha(palette.WHITE, 0.05),
  backgroundColor = palette.NIGHT_FOG
})
