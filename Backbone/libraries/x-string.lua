--[[~ Library: ? ~
  
  Version: 1.0.0 | Updated: 2024/09/25

  ?

  Dependencies: ?

]]

---
--- ?
---
_G.xstring = {}

---
--- ?
---
---@param target  string  "?"
---@param prefix  string  "?"
---
xstring.hasPrefix = function(target, prefix)
  return (target:sub(1, prefix:len()) == prefix)
end

---
--- ?
---
---@param target string "?"
---@param suffix string "?"
---
xstring.hasSuffix = function(target, suffix)
  local targetLength = #target
  local suffixLength = #suffix

  if suffixLength > targetLength then return false end
  return (suffix == target:sub(targetLength - suffixLength + 1))
end
