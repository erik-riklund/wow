
--[[~ Updated: 2024/11/18 | Author(s): Gopher ]]

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
dictionary.getIterator = function (self) return pairs(self.content) end

---
--- ?
---
---@param key string|table
---
dictionary.hasEntry = function (self, key) return self.content[key] ~= nil end

---
--- ?
---
---@param key string|table
---
dictionary.getEntry = function (self, key) return self.content[key] end

---
--- ?
---
---@param key string|table
---@param value unknown
---
dictionary.setEntry = function (self, key, value) self.content[key] = value end

---
--- ?
---
---@param key string|table
---
dictionary.dropEntry = function (self, key) self.content[key] = nil end

---
--- ?
---
---@param callback fun(key: string|table, value: unknown): unknown?
---
dictionary.forEach = function (self, callback)
  for index, value in self:getIterator() do
    local result = callback(index, value)
    if result ~= nil then self:setEntry(index, result) end
  end
end

---
---
---
local prototype = { __index = dictionary }

---
--- ?
---
---@param initial_content? table<string|table, unknown>
---
Dictionary = function (initial_content)
  return setmetatable({ content = initial_content or {} }, prototype)
end
