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

---@class Dictionary
---
local dictionary = {}

---@protected
---@type table<string|table, unknown>
---
dictionary.content = nil

---Returns an iterator for traversing the dictionary's key-value pairs.
---
dictionary.getIterator = function (self)
  return pairs (self.content)
end

---@param key string|table
---@return boolean key_exists
---Checks if a key exists in the dictionary.
---* Returns true if the key exists, false otherwise.
---
dictionary.hasEntry = function (self, key)
  return self.content[key] ~= nil
end

---@param key string|table
---Retrieves the value associated with a given key.
---
dictionary.getEntry = function (self, key)
  return self.content[key]
end

---@param key string|table
---@param value unknown
---Sets a key-value pair in the dictionary.
---
dictionary.setEntry = function (self, key, value)
  self.content[key] = value
end

---@param key string|table
---Removes an entry from the dictionary by key.
---
dictionary.dropEntry = function (self, key)
  self.content[key] = nil
end

---@param callback fun(key: string|table, value: unknown): unknown?
---Iterates through all key-value pairs and applies a callback function.
---* Updates entries if the callback returns a non-nil value.
---
dictionary.forEach = function (self, callback)
  for index, value in self:getIterator() do
    local result = callback (index, value)
    if result ~= nil then self:setEntry (index, result) end
  end
end

---Prototype for creating new `Dictionary` instances.
---
local prototype = { __index = dictionary }

---@param initialContent? table<string|table, unknown>
---Creates a new `Dictionary` instance with optional initial content.
---
Dictionary = function (initialContent)
  return setmetatable ({ content = initialContent or {} }, prototype)
end
