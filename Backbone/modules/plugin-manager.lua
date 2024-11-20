---@class Backbone
local context = select(2, ...)

---
--- ?
---
local plugins = new 'Dictionary'

---
--- ?
---
local extensions = new 'Vector'

---
--- ?
---
---@param callback fun(plugin: Plugin)
---
context.registerPluginExtension = function(callback)
  extensions:insertElement(callback)
end

---
--- ?
---
---@param name string
---@return Plugin
---
backbone.createPlugin = function(name)
  local identifier = string.lower(name)

  if plugins:hasEntry(identifier) then
    new('Error', 'Failed to register plugin "%s" (non-unique identifier)', name)
  end

  local plugin = { identifier = identifier, name = name }

  extensions:forEach(
    ---@param extension fun(plugin: Plugin)
    function(_, extension) extension(plugin) end
  )

  plugins:setEntry(identifier, plugin)
  return new('Proxy', plugin) --[[@as Plugin]]
end
