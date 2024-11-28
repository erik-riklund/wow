---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/28 | Author(s): Gopher ]]

---?
local palette = {
  default = 'F5DEB3', debug = 'EEC400', error = 'FF3D3D', success = '7D9039'
}

---@param input string
---?
backbone.colorizeString = function (input)
  input = string.gsub (input, '/([a-z]+)/', function (color)
      return '|cFF'..(palette[color] or palette.default)
    end)
  input = string.gsub (input, '//', '|r')
  
  return input
end

---@param message string
---@param ... string|number
---?
backbone.print = function (message, ...)
  message = backbone.colorizeString (message)
  print ((... and string.format (message, ...)) or message)
end

---@class Plugin
local output_api = {}

---@param message string
---@param ... string|number
---?
output_api.print = function (self, message, ...)
  backbone.print ('/default/['.. self.name ..']: '.. message ..'//', ...)
end

---@param message string
---@param ... string|number
---?
output_api.debug = function (self, message, ...)
  if backbone.getEnvironment() == 'development' then
    backbone.print ('/debug/['.. self.name ..']: '.. message ..'//', ...)
  end
end

---@param message string
---@param ... string|number
---?
output_api.error = function (self, message, ...)
  backbone.throw ('['.. self.name ..']: '.. message, ...)
end

---?
context.registerPluginExtension(
  function (plugin) integrateTable(plugin, output_api) end
)
