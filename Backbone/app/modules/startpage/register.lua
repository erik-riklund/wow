---@type string, Repository
local addon, repository = ...

--[[~ Module: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

repository.app.registerModule {
  identifier = 'startpage',
  localizedLabel = 'APP_MENU_BUTTON_STARTPAGE',
  mainPanel = 'BackboneStartpageModuleMainPanel',
}

repository.app.registerModule {
  identifier = 'plugins',
  localizedLabel = 'APP_MENU_BUTTON_PLUGINS',
  mainPanel = 'BackboneStartpageModuleMainPanel',
}

repository.app.registerModule {
  identifier = 'console',
  localizedLabel = 'APP_MENU_BUTTON_CONSOLE',
  mainPanel = 'BackboneStartpageModuleMainPanel',
}

repository.app.registerModule {
  identifier = 'tests',
  localizedLabel = 'APP_MENU_BUTTON_TESTS',
  mainPanel = 'BackboneStartpageModuleMainPanel',
  hideInProductionMode = true,
}
