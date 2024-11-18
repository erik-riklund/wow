--[[~ Dictionary (data structure) ~
  Updated: 2024/11/18 | Author(s): Erik Riklund (Gopher)
]]

---
---@class Dictionary
---
local dictionary = {}

---
--- ?
---
---@protected
---@type table<string|table, unknown>
---
dictionary.content = nil

---
--- ?
---
---@param key string|table
---
dictionary.hasEntry = function(self, key) return self.content[key] ~= nil end

---
--- ?
---
---@param key string|table
---
dictionary.getEntry = function(self, key) return self.content[key] end

---
--- ?
---
---@param key string|table
---@param value unknown
---
dictionary.setEntry = function(self, key, value) self.content[key] = value end

---
---
---
local prototype = { __index = dictionary }

---
--- ?
---
---@param initial_content? table<string|table, unknown>
---
Dictionary = function(initial_content)
  return setmetatable({ content = initial_content or {} }, prototype)
end
