--[[~ Module: Color Themes ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
local palette = {
  ['midnight-black'] = { 0, 0, 0, 1 }, -- Pure black.
  ['deep-oil'] = { 0.12, 0.12, 0.12, 1 }, -- Slightly lighter than pure black, like crude oil.
  ['shadow-onyx'] = { 0.06, 0.07, 0.09, 1 }, -- Very dark with a hint of blue, like onyx in shadow.
  ['charred-coal'] = { 0.17, 0.17, 0.17 }, -- Dark gray, reminiscent of charcoal.
  ['parchment'] = { 0.96, 0.87, 0.70, 1 }, -- Warm, light tan, like aged parchment.
  ['sunburst'] = { 1.0, 0.78, 0, 1 }, -- Bright golden-yellow, reminiscent of sunlight.
  ['pure-white'] = { 1, 1, 1, 1 }, -- Pure white.
}

---
--- ?
---
backbone.registerColorTheme('backbone', {
  ---
  --- Standard border and background colors used for frames, buttons and tooltips.
  ---
  
  borderColor = palette['shadow-onyx'],
  borderShaderColor = backbone.setColorAlpha(palette['pure-white'], 0.1),
  backgroundColor = backbone.setColorAlpha(palette['deep-oil'], 0.975),

  ---
  --- The normal and highlight colors for button labels.
  ---
  
  buttonTextColor = palette['parchment'],
  buttonTextHighlightColor = palette['sunburst'],
  buttonBackgroundColor = palette['charred-coal'],

  ---
  --- ?
  ---

  poorQualityColor = palette['pure-white'],
  commonQualityColor = palette['pure-white'],
  uncommonQualityColor = palette['pure-white'],
  rareQualityColor = palette['pure-white'],
  epicQualityColor = palette['pure-white'],

  ---
  --- ?
  ---
  
  tooltipArrowColor = palette['sunburst'],
  tooltipBackgroundColor = palette['charred-coal']
})
