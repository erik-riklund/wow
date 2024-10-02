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
  ---@diagnostic disable-next-line: missing-return

  for index, parser in ipairs(backbone.markupParsers) do
    target = parser(target) --
  end

  if type(variables) == 'table' then
    target = target:gsub('[$]([a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]*)', function(variable)
      return variables[variable] or ('$' .. variable)
    end)
  end

  return target
end
