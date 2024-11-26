
--[[~ Updated: 2024/11/18 | Author(s): Gopher ]]

---@class Dictionary
local dictionary = {}

---@protected
---@type table<string|table, unknown>
dictionary.content = nil

---Returns an iterator for traversing the dictionary's key-value pairs.
dictionary.getIterator = function (self) return pairs (self.content) end

---@param key string|table
---@return boolean key_exists
---Checks if a key exists in the dictionary.
---* Returns true if the key exists, false otherwise.
dictionary.hasEntry = function (self, key) return self.content[key] ~= nil end

---@param key string|table
---Retrieves the value associated with a given key.
dictionary.getEntry = function (self, key) return self.content[key] end

---@param key string|table
---@param value unknown
---Sets a key-value pair in the dictionary.
dictionary.setEntry = function (self, key, value) self.content[key] = value end

---@param key string|table
---Removes an entry from the dictionary by key.
dictionary.dropEntry = function (self, key) self.content[key] = nil end

---@param callback fun(key: string|table, value: unknown): unknown?
---Iterates through all key-value pairs and applies a callback function.
---* Updates entries if the callback returns a non-nil value.
dictionary.forEach = function (self, callback)
  for index, value in self:getIterator () do
    local result = callback (index, value)
    if result ~= nil then self:setEntry (index, result) end
  end
end

---Prototype for creating new `Dictionary` instances.
local prototype = { __index = dictionary }

---@param initial_content? table<string|table, unknown>
---Creates a new `Dictionary` instance with optional initial content.
Dictionary = function (initial_content)
  return setmetatable ({ content = initial_content or {} }, prototype)
end
