--[[~ Component: List ~
  Updated: 2024/10/24 | Author(s): Erik Riklund (Gopher)
]]

---
--- Represents a list data structure that allows for dynamic storage and management
--- of values, including adding, retrieving, and modifying items in the list.
---
---@class List
---
local list = {}

---
--- An array that holds the values in the list.
---
---@protected
---@type unknown[]
---
list.values = {}

---
--- Returns the total number of values currently stored in the list.
---
list.countValues = function(self) return #self.values end

---
--- Retrieves all values stored in the list.
---
list.getValues = function(self) return self.values end

---
--- Returns an iterator for the list, allowing for easy traversal of the stored values.
---
list.getIterator = function(self) return ipairs(self.values) end

---
--- Retrieves the value at the specified index in the list.
--- Throws an exception if the index exceeds the list's length.
---
list.getValue = function(self, index)
  if index > #self.values then
    backbone.throwException 'The specified index exceeds the length of the list.'
  end

  return self.values[index]
end

---
--- Inserts a new value into the list at the specified position.
--- If no position is provided, the value is added to the end of the list.
---
---@param value unknown
---@param position? number
---
list.insertValue = function(self, value, position)
  table.insert(self.values, position or (#self.values + 1), value)
end

---
--- Replaces the value at the specified index in the list with a new value.
--- Throws an exception if the index exceeds the list's length.
---
---@param index number
---@param value unknown
---
list.replaceValue = function(self, index, value)
  if index > #self.values then
    backbone.throwException 'The specified index exceeds the length of the list.'
  end

  self.values[index] = value
end

---
--- Removes the value at the specified position from the list. If no position is 
--- provided, the last value is removed. Throws an exception if the position exceeds 
--- the list's length.
---
---@param position? number
---
list.removeValue = function(self, position)
  if position and position > #self.values then
    backbone.throwException 'The specified index exceeds the length of the list.'
  end

  return table.remove(self.values, position)
end

---
--- Returns the index of the first occurrence of the specified value in the list,
--- or `-1` if the value is not found.
---
list.getIndex = function(self, value)
  local valueIndex = -1
  local currentIndex = 1
  local valueCount = #self.values

  while valueIndex == -1 and currentIndex <= valueCount do
    if self.values[currentIndex] == value then valueIndex = currentIndex end
    currentIndex = currentIndex + 1
  end

  return valueIndex
end

---
--- Creates and returns a new list instance,
--- optionally initialized with the provided values.
---
---@param values? unknown[]
---@return List
---
backbone.components.createList = function(values)
  return backbone.utilities.inheritParent({ values = values or {} }, list)
end
