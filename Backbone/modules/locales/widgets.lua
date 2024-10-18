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
  end
end

---
--- Updates all registered localized labels by setting their text based on the
--- current locale and forces re-rendering to apply width adjustments.
---
backbone.updateLocalizedLabels = function()
  for _, label in ipairs(localizedLabels) do
    local namespace, key = string.split(':', label.labelKey)
    
    if label.variables then
      print 'backbone.updateLocalizedLabels: variable replacement not implemented.'
    end

    if not label.variables then
      backbone.executeCallbackAsync {
        callback = label.object.SetText,
        identifier = 'updateLocalizedLabels:' .. (label.object:GetName() or 'ANONYMOUS_LABEL'),
        arguments = { label.object, backbone.getLocalizedString(namespace, key) },
      }
    end

    backbone.executeCallbackAsync {
      callback = function()
        label.object:SetShown(false)
        label.object:SetShown(true)

        local parent = label.object:GetParent()
        if parent ~= nil and parent:IsShown() then
          parent:SetShown(false)
          parent:SetShown(true)
        end
      end,

      identifier = 'updateLocalizedLabels.forceRender:'
        .. (label.object:GetName() or 'ANONYMOUS_LABEL'),
    }
  end
end
