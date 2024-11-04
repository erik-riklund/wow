--[[~ Template: Window (dismissable frame) ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@param self BackboneWindowTemplate
---@param colors? BackboneFrameColors
---
BackboneWindowTemplate_OnLoad = function(self, colors)
  BackboneFrameTemplate_OnLoad(self, colors) -- parent constructor.

  backbone.widgets.makeMovable(self)
  self.closeButton:HookScript('OnClick', function()
    (self.closeButton:GetParent()):SetShown(false) --
  end)
end
