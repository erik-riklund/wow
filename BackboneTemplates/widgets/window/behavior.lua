--[[~ Template: Window (dismissable frame) ~
  Updated: 2024/11/05 | Author(s): Erik Riklund (Gopher)
]]

---
--- The constructor for the window frame template. Enables movability of the
--- frame and hooks the script required for the close button to be usable.
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
