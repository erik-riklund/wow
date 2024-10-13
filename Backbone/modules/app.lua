---@type string, Repository
local addon, repository = ...

--[[~ Module: App ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

---@type Module[]
local modules = {}

local currentActiveModule = nil
local currentSidePanel = nil
local currentMainPanel = nil

---@type fun(module: Module)
local registerModule = function(module) table.insert(modules, module) end

---@type fun(identifier: string)
local setActiveModule = function(identifier)
  for _, module in ipairs(modules) do
    if module.identifier == identifier then
      currentActiveModule = identifier

      if currentMainPanel then currentMainPanel:SetShown(false) end
      if currentSidePanel then currentSidePanel:SetShown(false) end

      if _G[module.mainPanel] then
        currentMainPanel = _G[module.mainPanel] --[[@as Frame]]
        currentMainPanel:SetShown(true)
      end

      if module.sidePanel and _G[module.sidePanel] then
        currentSidePanel = _G[module.sidePanel] --[[@as Frame]]
        currentSidePanel:SetShown(true)
      end
    end
  end
end

---@type fun(module: string, panel: string)
local setActivePanel = function(module, panel)
  if currentActiveModule ~= module then
    backbone.throwError('Blocked panel change for non-active module "%s".', module) --
  end
  
  if _G[panel] then
    if currentMainPanel then currentMainPanel:SetShown(false) end

    currentMainPanel = _G[panel] --[[@as Frame]]
    currentMainPanel:SetShown(true)

    return -- exit.
  end

  backbone.throwError('Unknown panel "%s".', panel)
end

---@type fun(): Module[]
local getRegisteredModules = function() return modules end

-- ?

repository.app = {
  registerModule = registerModule,
  getRegisteredModules = getRegisteredModules,
  setActiveModule = setActiveModule,
  setActivePanel = setActivePanel,
}
