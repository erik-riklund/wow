---@type string, Repository
local addon, repository = ...

--[[~ Script: Startpage ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

repository.registerPage('Startpage', {
  main = _G['BackboneStartpageMainPanel'],
  left = _G['BackboneStartpageLeftPanel'],
})
