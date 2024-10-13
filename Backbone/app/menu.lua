---@type string, Repository
local addon, repository = ...

--[[~ Script: Navigation Menu ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

local app = repository.app

---@param name string
_G.BackboneMenuButton_SetActiveModule = function(name)
  print 'BackboneMenuButton_SetActiveModule: not implemented yet.' --
end

---@param self Frame
_G.BackboneMenuFrame_CreateButtons = function(self)
  DevTools_Dump(app.getRegisteredModules())

  local modules = app.getRegisteredModules()
  local relativeTo = 'BackboneMenuFrameSpacer'

  for i = #modules, 1, -1 do
    local button = CreateFrame(
      'Button',
      'BackboneMenuFrameButton' .. i, --
      _G.BackboneMenuFrame --[[@as Frame]],
      'BackboneMenuButton'
    );

    ---@cast button Button
    (button.textLabel --[[@as FontString]]):SetText( --
      backbone.getLocalizedString('backbone', modules[i].localizedLabel)
    )

    button:SetPoint('RIGHT', relativeTo, 'LEFT', -16, 0)
    button:SetScript('OnClick', function() app.setActiveModule(modules[i].identifier) end)
    button:SetShown(not (modules[i].hideInProductionMode and backbone.getEnvironment() == 'production'))
    
    BackboneButtonTemplate_UpdateWidth(button)
    relativeTo = 'BackboneMenuFrameButton' .. i
  end
end
