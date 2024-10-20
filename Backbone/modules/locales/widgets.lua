--[[~ Module: Localized Widgets Controller ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/18

]]

---@type LocalizedLabel[]
local localizedLabels = {}

---
--- ?
---
---@param label LocalizedLabel
local updateLocalizedLabel = function(label)
  local namespace, key = string.split(':', label.labelKey)
  label.object:SetText(backbone.getLocalizedString(namespace, key))

  local parent = label.object:GetParent()
  if parent ~= nil and parent:IsShown() then
    -- triggers width adjustments for buttons.
    backbone.widgetControllers.forceRender(parent)
  end
end

---
--- Registers a list of localized labels to be updated when the locale changes.
---
---@param labels LocalizedLabel[]
backbone.registerLocalizedLabels = function(labels)
  for _, label in ipairs(labels) do
    localizedLabels[#localizedLabels + 1] = label
    updateLocalizedLabel(label)
  end
end

---
--- ?
---
--- TODO: add listener to update labels when the locale changes.
