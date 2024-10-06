--[[~ Module: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

---
--- ?
---
---@param target string
---@param prefix string|string[]
---
utilities.stringHasPrefix = function(target, prefix)
  local targetLength = target:len()
  if type(prefix) ~= 'table' then prefix = { prefix } end

  for i = 1, #prefix do
    local prefixLength = prefix[i]:len()

    if prefixLength <= targetLength then
      if target:sub(1, prefixLength) == prefix[i] then return true end
    end
  end

  return false
end
