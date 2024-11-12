--[[~ ? ~
  Updated: 2024/11/10 | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@param object FontString
---@param keyPath string
---
backbone.widgets.setText = function(object, keyPath)
  ---@type string, string
  local namespace, key = string.split(':', keyPath, 2)
  object:SetText(backbone.getLocalizedString(namespace, key))
end
