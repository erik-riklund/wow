--[[~ Map ~
  Updated: 2024/11/12 | Author(s): Erik Riklund (Gopher)
]]

---
--- Represents a key-value mapping structure that allows for flexible
--- storage and retrieval of values based on various key types.
---
---@class Map
---
local map = {}

---
--- The internal table that holds the key-value pairs for the map.
---
---@protected
---@type table<unknown, unknown>
---
map.content = {}

---
--- Retrieves the value associated with the specified key from the map.
--- Throws an exception if the key does not exist.
---
---@param key unknown
---
map.getValue = function(self, key)
  if self.content[key] == nil then
    backbone.throwException('The key "%s" does not exist in the map.', key)
  end

  return self.content[key]
end

---
--- Sets the value for the specified key in the map, creating or updating the key-value pair.
---
---@param key unknown
---@param value unknown
---
map.setValue = function(self, key, value) self.content[key] = value end

---
--- Checks if the specified key exists in the map.
---
---@param key unknown
---
map.containsKey = function(self, key) return (self.content[key] ~= nil) end

---
--- Returns an iterator for the map, allowing traversal of all key-value pairs.
---
map.getIterator = function(self) return pairs(self.content) end

---
--- Creates and returns a new map instance, optionally initialized with the provided content.
---
---@param content? table<unknown, unknown>
---@return Map
---
backbone.components.createMap = function(content)
  return backbone.utilities.inheritParent({ content = content or {} }, map)
end
