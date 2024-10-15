--[[~ Module: Localized Widgets Controller ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

]]

---@type LocalizedLabel[]
local localizedLabels = {}

---
--- ?
---
---@param labels LocalizedLabel[]
backbone.registerLocalizedLabels = function(labels)
  for _, label in ipairs(labels) do
    localizedLabels[#localizedLabels + 1] = label
  end
end

---
--- ?
---
backbone.updateLocalizedLabels = function()
  for index, label in ipairs(localizedLabels) do
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
        if parent ~= nil then
          parent:SetShown(false)
          parent:SetShown(true)
        end
      end,

      identifier = 'updateLocalizedLabels.forceRender:'
        .. (label.object:GetName() or 'ANONYMOUS_LABEL'),
    }
  end
end
