--[[~ Updated: 2024/12/06 | Author(s): Gopher ]]

--Backbone - A World of Warcraft Addon Framework
--Copyright (C) 2024 Erik Riklund (Gopher)
--
--This program is free software: you can redistribute it and/or modify it under the terms
--of the GNU General Public License as published by the Free Software Foundation, either
--version 3 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
--without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--See the GNU General Public License <https://www.gnu.org/licenses/> for more details.

---@class Vector
local vector = {}

---@protected
---@type table<number, unknown>
---
vector.values = nil

---Returns the number of elements in the vector.
---
vector.getSize = function (self)
  return #self.values
end

---Returns an iterator for traversing the vector elements.
---
vector.getIterator = function (self)
  return ipairs (self.values)
end


---@param index number
---@return unknown? value
---Retrieves an element from the vector by index.
---
vector.getElement = function (self, index)
  return self.values[index]
end

---@param value unknown
---@param position? number
---Inserts an element into the vector at the specified position.
---* If no index is provided, the element is added to the end.
---
vector.insertElement = function (self, value, position)
  table.insert (self.values, position or (#self.values + 1), value)
end

---@param index? number
---Removes and returns an element from the vector at the specified position.
---* If no index is provided, the last element is removed.
---
vector.removeElement = function (self, index)
  return table.remove (self.values, index)
end

---@param callback fun(index: number, element: unknown): unknown?
---Iterates over all elements in the vector and applies a callback function.
---* Updates elements if the callback returns a non-nil value.
---
vector.forEach = function (self, callback)
  for index, element in self:getIterator() do
    local result = callback (index, element)
    if result ~= nil then self.values[index] = result end
  end
end

---Checks whether the vector contains the specified value.
---
vector.containsElement = function (self, searchValue)
  for _, value in ipairs (self.values) do
    if value == searchValue then return true end
  end
  return false
end

---Unpacks and returns all elements in the vector.
---
vector.unpackElements = function (self)
  return unpack (self.values)
end

---@param separator string
---@param from? number
---@param to? number
---Concatenates elements of the vector into a single string using the specified separator.
---* The concatenation starts from the optional `from` index and ends at the optional `to` index.
---* If `from` and `to` are not specified, the entire vector is concatenated.
---
vector.joinElements = function (self, separator, from, to)
  return table.concat (self, separator, from, to)
end

---@return table values
---Returns a copy of the vector's values as an array.
---
vector.toArray = function (self)
  return copyTable (self.values)
end

---Prototype for creating new `Vector` instances.
---
local prototype = { __index = vector }

---@param initialValues? table<number, unknown>
---Creates a new `Vector` instance with optional initial values.
---
Vector = function (initialValues)
  return setmetatable ({ values = initialValues or {} }, prototype)
end
