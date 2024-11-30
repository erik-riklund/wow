
--[[~ Updated: 2024/11/18 | Author(s): Gopher ]]

---@class Vector
local vector = {}

---Prototype for creating new `Vector` instances.
local prototype = { __index = vector }

---@param initial_values? table<number, unknown>
---Creates a new `Vector` instance with optional initial values.
Vector = function (initial_values)
  return setmetatable ({ values = initial_values or {} }, prototype)
end

---@protected
---@type table<number, unknown>
vector.values = nil

---Returns the number of elements in the vector.
vector.getSize = function (self) return #self.values end

---Returns an iterator for traversing the vector elements.
vector.getIterator = function (self) return ipairs (self.values) end


---@param index number
---Retrieves an element from the vector by index.
vector.getElement = function (self, index) return self.values[index] end

---@param element unknown
---@param index? number
---Inserts an element into the vector at the specified position.
---* If no index is provided, the element is added to the end.
vector.insertElement = function (self, element, index)
  table.insert (self.values, index or (#self.values + 1), element)
end

---@param index? number
---Removes and returns an element from the vector at the specified position.
---* If no index is provided, the last element is removed.
vector.removeElement = function (self, index) return table.remove (self.values, index) end

---@param callback fun(index: number, element: unknown): unknown?
---Iterates over all elements in the vector and applies a callback function.
---* Updates elements if the callback returns a non-nil value.
vector.forEach = function (self, callback)
  for index, element in self:getIterator() do
    local result = callback (index, element)
    if result ~= nil then self.values[index] = result end
  end
end

---?
vector.contains = function (self, search_value)
  for _, value in ipairs(self.values) do
    if value == search_value then return true end
  end
  return false
end

---Unpacks and returns all elements in the vector.
vector.unpackElements = function (self) return unpack (self.values) end

---@param separator string
---@param from? number
---@param to? number
---?
vector.joinElements = function (self, separator, from, to)
  return table.concat (self, separator, from, to)
end
