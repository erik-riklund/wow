--[[~ Vector (data structure) ~
  Updated: 2024/11/18 | Author(s): Erik Riklund (Gopher)
]]

---
---@class Vector
---
local vector = {}

---
--- ?
---
---@protected
---@type table<number, unknown>
---
vector.values = nil

---
--- ?
---
vector.getSize = function(self) return #self.values end

---
--- ?
---
vector.getIterator = function(self) return ipairs(self.values) end

---
--- ?
---
---@param index number
---
vector.getElement = function(self, index) return self.values[index] end

---
--- ?
---
---@param element unknown
---@param index? number
---
vector.insertElement = function(self, element, index)
  table.insert(self.values, index or (#self.values + 1), element)
end

---
--- ?
---
---@param index? number
---
vector.removeElement = function(self, index) return table.remove(self.values, index) end

---
--- ?
---
---@param callback fun(index: number, element: unknown): unknown?
---
vector.forEach = function(self, callback)
  for index, element in self:getIterator() do
    local result = callback(index, element)
    if result ~= nil then self.values[index] = result end
  end
end

---
--- ?
---
local prototype = { __index = vector }

---
--- ?
---
---@param initial_values? table<number, unknown>
---
Vector = function(initial_values)
  return setmetatable({ values = initial_values or {} }, prototype)
end
