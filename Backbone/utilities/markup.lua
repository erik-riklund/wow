--[[~ Module: Markup Processor ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/29

  This module processes markup in strings, converting tags such as color codes and variables
  into their respective in-game format. It allows dynamic string rendering with customizable
  variables and colored text.

  Features:

  - Parse and apply color tags to strings.
  - Replace variable placeholders with actual values.

]]

local colors = {
  ['alabaster'] = 'F7F7F7', -- Off-white
  ['ash-gray'] = 'B8B8B8', -- Light gray
  ['berry'] = '800080', -- Purple
  ['blue-dianne'] = '2E4553', -- Dark blue-green
  ['brown-rust'] = 'AA552A', -- Reddish-brown
  ['cadet-blue'] = '5F9EA0', -- Muted blue-green
  ['charcoal'] = '36454F', -- Dark charcoal gray
  ['chartreuse'] = '7FFF00', -- Bright green-yellow
  ['cloudy-gray'] = 'B4B4B4', -- Soft cloudy gray
  ['cocoa'] = '826342', -- Dark brown
  ['davy-grey'] = '555555', -- Dark steel gray
  ['deep-saffron'] = 'FF9933', -- Saffron orange
  ['dim-gray'] = '696969', -- Dark gray
  ['electric-lime'] = 'CCFF00', -- Neon green-yellow
  ['fire-opal'] = 'E95C4B', -- Bright orange-red
  ['french-rose'] = 'F64A8A', -- Vivid pink
  ['gainsboro'] = 'DCDCDC', -- Very light gray
  ['glacier'] = '86AFAF', -- Light blue-green
  ['ghost-white'] = 'F8F8FF', -- Nearly white with a hint of gray
  ['golden'] = 'EEC400', -- Bright yellow
  ['granite-gray'] = '676767', -- Mid-tone gray
  ['heavy-metal'] = '292828', -- Very dark gray
  ['jasper'] = 'DC3545', -- Deep red
  ['jet-gray'] = '343434', -- Deep black-gray
  ['jungle-green'] = '29AB87', -- Dark green
  ['lemon-yellow'] = 'FFF700', -- Bright yellow
  ['lion'] = 'C39563', -- Light brown
  ['light-mustard'] = 'FCD462', -- ?
  ['light-slate-gray'] = '778899', -- Muted bluish-gray
  ['magenta'] = 'FF00FF', -- Bright pink
  ['milk-white'] = 'FBFBFC', -- Very pale white
  ['mountain-mist'] = '959595', -- Medium gray
  ['navy-blue'] = '000080', -- Dark blue
  ['nickel'] = '727472', -- Gray with a hint of green
  ['olivine'] = 'A9B665', -- Olive green
  ['orchid'] = 'DA70D6', -- Light purple
  ['pale-red'] = 'DE4B37', -- Pale red
  ['peach-puff'] = 'F5DEB3', -- Light peach
  ['pearl-gray'] = 'CECECE', -- Light pearly gray
  ['persian-blue'] = '1C39BB', -- Deep blue
  ['river-bed'] = '3E4E5E', -- Dark blue-gray
  ['rose-quartz'] = 'AA98A9', -- Pale pink-lavender
  ['sea-green'] = '2E8B57', -- Green-blue
  ['silver'] = 'C0C0C0', -- Light silver gray
  ['sky-blue'] = '87CEEB', -- Light blue
  ['slate-gray'] = '708090', -- Dark bluish-gray
  ['smoke'] = '848484', -- Smoky medium gray
  ['tiger-eye'] = 'D88F42', -- Golden orange
  ['turquoise'] = '40E0D0', -- Bright greenish-blue
  ['vivid-orange'] = 'FF5F00', -- Bright orange
  ['watermelon'] = 'FF5555', -- Bright red
  ['wheat'] = 'F3EDCF' -- ?
}

---
--- Stores a list of parsers that process different types of markup in strings. Each parser function
--- applies transformations, such as converting color tags into their respective in-game color codes.
---
local parsers = {}

---
--- This parser function converts color markup in the format `<color=color-name>` into in-game color
--- codes. The color is replaced by its corresponding hex code from the `colors` table. The closing
--- tag `</color>` is replaced with the in-game reset color code `|r`.
---
table.insert(
  parsers,
  ---@param target string
  function(target)
    target = string.gsub(
      target,
      '<color=([a-z][a-z-]+)>',
      function(color) return '|cFF' .. (colors[color] or 'FFFFFF') end
    )

    return string.gsub(target, '</color>', '|r')
  end
)

---
--- processVariables()
---
--- This function processes variables in the string, replacing placeholders in the format `$variable-name`
--- with their corresponding values from the `variables` table. If a variable is not found in the table,
--- it is replaced with an empty string.
---
---@param target    string "The string containing variable placeholders."
---@param variables table<string, string|number> "A table of variable values."
---
local processVariables = function(target, variables)
  return string.gsub(
    target,
    '[$]([a-z][a-z0-9-]*)',
    function(variable) return variables[variable] or '' end
  )
end

---
--- processMarkup()
---
--- This function processes a string to apply markup such as color codes and variables. It runs the
--- string through all registered parsers, applying transformations like color changes, and then
--- replaces variable placeholders if a variables table is provided.
---
---@param target     string "The string to process with markup."
---@param variables? table<string, string|number> "Optional table of variables for replacement."
---
_G.processMarkup = function(target, variables)
  if type(target) ~= 'string' then error('?', 3) end

  if variables and type(variables) ~= 'table' then error('?', 3) end

  -- Run the target string through each parser to apply transformations such as color codes.
  -- After all parsers have been applied, process the variables if a table of variables is provided.

  for index, parser in ipairs(parsers) do
    target = parser(target) --[[@as string]]
  end

  if variables ~= nil then target = processVariables(target, variables) end

  return target
end
