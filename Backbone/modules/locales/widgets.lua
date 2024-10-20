--[[~ Module: Localized Widgets Controller ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/18

]]

---@type LocalizedLabel[]
local localizedLabels = {}

---
--- Registers a list of localized labels to be updated when the locale changes.
---
---@param labels LocalizedLabel[]
backbone.registerLocalizedLabels = function(labels)
  for _, label in ipairs(labels) do
    localizedLabels[#localizedLabels + 1] = label

    label.object:HookScript('OnShow', function()
      local namespace, key = string.split(':', label.labelKey)
      label.object:SetText(backbone.getLocalizedString(namespace, key))

      local parent = label.object:GetParent()
      if parent ~= nil and parent:IsShown() then
        backbone.widgetControllers.forceRender(parent)
      end
    end)

    backbone.widgetControllers.forceRender(label.object)
  end
end

---
--- ?
---
--- TODO: add listener to update the labels when the locale changes.
