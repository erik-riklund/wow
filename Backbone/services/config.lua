---@type string, contextProvider
local addon, repository = ...
local api = repository.use 'api' --[[@as api]]

---@type storage.unitConstructor
local createStorageUnit = repository.use 'storage-unit'

--[[~ Service: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/27

  ?

  Features:

  - ?

  Dependencies: ?

]]

local prefix = '__config/'

---@type configHandler
local handler = {
  getSetting = function(self, identifier)
    ---@diagnostic disable-next-line: missing-return
  end,

  getDefaultSetting = function(self, identifier)
    return self.defaults:getEntry(identifier)
  end,

  setSetting = function(self, identifier, value)
    xtype.validate { { 'identifier:string', identifier } }

    -- ...
  end,
}

---@type configService
local createHandler = function(context, defaults)
  xtype.validate { { 'defaults:table', defaults } }
  return inheritParent({ context = context, defaults = createStorageUnit(defaults) }, handler)
end

-- register the service:
api.provideService('config', createHandler)
