--[[~ Module: Markup Processor ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/30

  This module processes markup in strings, converting tags such as color codes and variables
  into their respective in-game format. It allows dynamic string rendering with customizable
  variables and colored text.

  Features:

  - Parse and apply color tags to strings.
  - Replace variable placeholders with actual values.

]]

local colors = {
  -- Grays
  ['cloudy-sky'] = 'B0C4DE', -- Soft blue-gray
  ['dark-cloudy-sky'] = '6E8196', -- Dark blue-gray
  ['dark-lavender-gray'] = '8A8A99', -- Dark lavender-gray
  ['dark-pearl-gray'] = 'A8A8A8', -- Dark pearly gray
  ['lavender-gray'] = 'C4C3D0', -- Soft gray with lavender undertones
  ['misty-gray'] = 'C1C1C1', -- Light gray
  ['pearl-gray'] = 'E8E8E8', -- Light pearly gray

  -- Greens
  ['celery-green'] = 'D1E231', -- Light pastel green
  ['dark-celery-green'] = '9DB400', -- Dark pastel green
  ['dark-dreamy-mint'] = '6DC69B', -- Dark mint green
  ['dark-pistachio'] = '85B34F', -- Dark pistachio green
  ['dreamy-mint'] = 'AAF0D1', -- Soft pastel mint green
  ['light-pistachio'] = 'BEF574', -- Soft pastel green
  ['seafoam'] = '93E9BE', -- Soft pastel green

  -- Blues
  ['baby-blue'] = 'A1CAF1', -- Soft pastel blue
  ['dark-baby-blue'] = '6A94BA', -- Dark pastel blue
  ['dark-pale-blue'] = '8AA1B9', -- Dark pastel blue
  ['dark-turquoise'] = '5FCFCF', -- Dark turquoise
  ['pale-blue'] = 'D6E6F2', -- Very light pastel blue
  ['pastel-turquoise'] = '99FFFF', -- Soft pastel turquoise
  ['periwinkle'] = 'C5D0E6', -- Soft pastel blue-purple

  -- Reds
  ['blush-pink'] = 'F4C2C2', -- Light pastel pink
  ['blush-red'] = 'FF6F61', -- Warm blush pastel red
  ['dark-blush-pink'] = 'C48A8A', -- Dark blush pink
  ['dark-blush-red'] = 'C13E38', -- Dark blush red
  ['dark-pastel-red'] = 'BF4040', -- Dark pastel red
  ['pastel-red'] = 'FF6961', -- Soft pastel red
  ['pastel-rose'] = 'FFC1C1', -- Light pastel rose-red

  -- Yellows
  ['buttercream'] = 'FFF1B6', -- Soft pastel yellow
  ['dark-buttercream'] = 'D1C487', -- Dark buttercream
  ['dark-mellow-yellow'] = 'C2B450', -- Dark mellow yellow
  ['dark-soft-sand'] = 'C5B6A1', -- Dark pastel beige
  ['mellow-yellow'] = 'F8DE7E', -- Light pastel yellow
  ['soft-sand'] = 'F4E7D6', -- Pale pastel beige
  ['sunset-peach'] = 'FFDAB9', -- Soft pastel peach

  -- Purples
  ['dark-delicate-lavender'] = 'B0B0C8', -- Dark delicate lavender
  ['dark-frosted-lilac'] = '9A8AC1', -- Dark frosted lilac
  ['dark-lilac'] = '986898', -- Dark lilac
  ['delicate-lavender'] = 'E6E6FA', -- Pale pastel purple
  ['frosted-lilac'] = 'DCD0FF', -- Light pastel purple
  ['lilac'] = 'C8A2C8', -- Soft pastel purple
  ['pastel-lavender'] = 'ECDDF9', -- Light pastel lavender

  -- Pinks
  ['cherry-blossom'] = 'FFB7C5', -- Light pastel pink
  ['cotton-candy'] = 'FFBCD9', -- Pastel pink
  ['dark-cherry-blossom'] = 'C9879A', -- Dark cherry blossom
  ['dark-cotton-candy'] = 'C98BA2', -- Dark cotton candy
  ['dark-light-rose'] = 'C8B1B7', -- Dark pastel pink
  ['light-rose'] = 'FDEEF4', -- Very pale pastel pink
  ['pearl-blush'] = 'FDD7E4', -- Pale pastel pink

  -- Browns
  ['almond'] = 'EED9C4', -- Light pastel brown
  ['beige'] = 'F5F5DC', -- Soft pastel beige
  ['caramel'] = 'F3B798', -- Light pastel caramel
  ['dark-almond'] = 'BFA889', -- Dark pastel almond
  ['dark-beige'] = 'D9D1A9', -- Dark beige
  ['dark-caramel'] = 'B3866C', -- Dark caramel
  ['taupe'] = 'D3B5A0', -- Soft taupe brown

  -- Oranges
  ['apricot'] = 'FFDAB1', -- Light pastel apricot
  ['burnt-peach'] = 'FFB385', -- Soft pastel orange-peach
  ['cantaloupe'] = 'FFCBA4', -- Light pastel cantaloupe
  ['dark-apricot'] = 'FFB278', -- Dark pastel apricot
  ['dark-papaya'] = 'FFA766', -- Dark pastel papaya orange
  ['melon'] = 'FFB891', -- Soft pastel melon orange
  ['tangerine'] = 'FFA07A', -- Soft pastel tangerine
}

---
--- Stores a list of parsers that process different types of markup in strings. Each parser function
--- applies transformations, such as converting color tags into their respective in-game color codes.
---
local parsers = {}

---
--- Converts color markup in the format `<color=color-name>` into in-game color codes. The color is
--- replaced by its corresponding hex code from the `colors` table. The closing tag `</color>` is replaced
--- with the in-game reset color code `|r`.
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
--- Processes variables in the string, replacing placeholders in the format `$variable-name`
--- with their corresponding values from the `variables` table. If a variable is not found in
--- the table, it is replaced with an empty string.
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
--- Processes a string to apply markup such as color codes and variables. It runs the string through
--- all registered parsers, applying transformations like color changes, and then replaces variable
--- placeholders if a variables table is provided.
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
