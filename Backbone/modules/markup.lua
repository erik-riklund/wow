--[[~ Module: Markup ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  Provides a utility function for processing markup strings,
  including color tag replacements and variable substitution.

]]

local palette = {
  ['albescent-white'] = 'F3EDCF',
  ['black'] = '000000',
  ['bright-orange'] = 'F15F04',
  ['cyan-blue'] = '0493F1',
  ['olive-green'] = 'A9B665',
  ['purple'] = '6533A9',
  ['quill-grey'] = 'DAD5B9',
  ['red-brown'] = '3F1212',
  ['red-orange'] = 'FF3D3D',
  ['vivid-blue'] = '0041EA',
  ['white'] = 'FFFFFF',
  ['yellow-orange'] = 'EABF00',
}

---
--- Processes color tags and variables in the provided string.
---
---@param target string
---@param variables? MarkupVariables
---
backbone.processMarkup = function(target, variables)
  --
  -- Replace opening and closing color tags. If the specified
  -- color doesn't exist, `white` is used as fallback.

  target = target:gsub('<color=([a-z][a-z-]*[a-z]*)>', function(color)
    return '|cFF' .. (palette[color] or 'FFFFFF') --
  end)

  target = target:gsub('</color>', '|r')

  -- ?

  target = target:gsub('<br>', '\n')

  -- Replace variable placeholders with their actual values. If a variable
  -- doesn't exist, the placeholder is left intact in the resulting string.

  if type(variables) == 'table' then
    target = target:gsub(
      '[$]([a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]*)',
      function(variable) return variables[variable] or ('$' .. variable) end
    )
  end

  return target
end
