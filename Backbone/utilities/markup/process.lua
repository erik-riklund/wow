--[[~ Module: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/30

  ?

]]

---@type array<fun(target: string): string>
backbone.markupParsers = {}

---
--- ?
---
---@param target string
---@param variables? hashmap<string, string|number>
---@return string
---
backbone.processMarkup = function(target, variables)
  -- [explain this section]

  for index, parser in ipairs(backbone.markupParsers) do
    local success, result = pcall(parser, target)

    if not success then
      -- todo: implement error reporting through the console.
    else
      target = result
    end
  end

  -- [explain this section]

  if type(variables) == 'table' then
    target = target:gsub('[$]([a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]*)', function(variable)
      return variables[variable] or ('$' .. variable)
    end)
  end

  return target
end
