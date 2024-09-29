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
  ['ash-gray'] = 'B8B8B8', -- Light gray
  ['blue-dianne'] = '2E4553', -- Dark blue-green
  ['brown-rust'] = 'AA552A', -- Reddish-brown
  ['cocoa'] = '826342', -- Dark brown
  ['dark-coral'] = 'C65555', -- Dark red-pink
  ['glacier'] = '86AFAF', -- Light blue-green
  ['golden'] = 'EEC400', -- Bright yellow
  ['heavy-metal'] = '292828', -- Very dark gray
  ['jasper'] = 'DC3545', -- Deep red
  ['lion'] = 'C39563', -- Light brown
  ['milk-white'] = 'FBFBFC', -- Very pale white
  ['mountain-mist'] = '959595', -- Medium gray
  ['olivine'] = 'A9B665', -- Olive green
  ['pale-red'] = 'DE4B37', -- Pale red
  ['peach-puff'] = 'F5DEB3', -- Light peach
  ['river-bed'] = '3E4E5E', -- Dark blue-gray
  ['tiger-eye'] = 'D88F42', -- Golden orange
  ['watermelon'] = 'FF5555', -- Bright red
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
  xtype.validate {
    { 'target:string', target },
    { 'variables:table?', variables },
  }

  -- Run the target string through each parser to apply transformations such as color codes. 
  -- After all parsers have been applied, process the variables if a table of variables is provided.

  for index, parser in ipairs(parsers) do
    target = parser(target) --[[@as string]]
  end

  if variables ~= nil then target = processVariables(target, variables) end

  return target
end
