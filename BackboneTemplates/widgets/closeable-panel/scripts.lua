--[[~ Closeable Panel ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@param self BackboneCloseablePanelTemplate
---
BackboneCloseablePanelTemplate_OnLoad = function(self)
  BackboneFrameTemplate_OnLoad(self) -- parent constructor

  backbone.widgets.makeMovable(self)
  self.closeButton:HookScript('OnClick', function() self:SetShown(false) end)

  backbone.widgets.onThemeChange(function()
    backbone.widgets.setFontColor(self.title, 'titleTextColor')
    backbone.widgets.setTextureColor(self.titleBorder, 'borderColor')
    backbone.widgets.setTextureColor(self.titleShader, 'borderShaderColor')
  end)
end

---
--- ?
---
---@param self BackboneCloseablePanelTemplate
---@param keyPath string
---
BackboneCloseablePanelTemplate_SetTitle = function(self, keyPath)
  backbone.widgets.setText(self.title, keyPath) --
end
