---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/25 | Author(s): Gopher ]]

local plugins = new 'Dictionary'

---@param name string The name of the plugin to create.
---@return Plugin plugin A new plugin instance wrapped in a proxy for immutability.
---Creates a new plugin with a unique name and applies all registered extensions.
---* Throws an error if a plugin with the same identifier already exists.
backbone.createPlugin = function (name)
  local identifier = string.lower (name)
  if plugins:hasEntry (identifier) then
    backbone.throw ('Failed to register plugin "%s" (non-unique identifier)', name)
  end

  local plugin = { identifier = identifier, name = name }
  context.plugin_extensions:forEach (
    function(_, extension) extension (plugin) end
  )
  plugins:setEntry (identifier, plugin)
  return Proxy (plugin) --[[@as Plugin]]
end

---@param name string The name of the plugin to check.
---@return boolean plugin_exists True if the plugin exists, false otherwise.
---Checks if a plugin with the given name is registered.
backbone.hasPlugin = function (name) return plugins:hasEntry (string.lower (name)) end
