--[[~ Utility: String Prefix ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/07

  Provides a utility to check if a string starts with a specified prefix,
  supporting comparison against both single and multiple prefixes.

]]

---
--- Checks if the provided target string starts with the specified prefix.
---
---@param target string
---@param prefix string|string[]
---
backbone.utilities.stringHasPrefix = function(target, prefix)
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
