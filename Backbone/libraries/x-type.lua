--[[~ Library: Type Extension ~

  Version: 1.0.0 | Updated: 2024/09/27

  ?

  Features:

  - ?

]]

_G.xtype = {}

---
--- ?
---
---@param value unknown "?"
---@return xtype.type "?"
---
xtype.examine = function(value)
  local valueType = type(value)

  if valueType == 'table' then
    if next(value) == nil then
      return 'empty-table'
    end

    -- distinguish arrays from associative tables:

    local elementCount = #value
    local actualElementCount = 0

    for _ in pairs(value) do
      actualElementCount = actualElementCount + 1
    end

    return (elementCount == actualElementCount and 'array') or 'table'
  end

  if valueType == 'string' and string.len(value) == 1 then
    return 'character' -- ?
  end

  return (valueType == 'nil' and 'undefined') or valueType --[[@as xtype.type]]
end

---
--- ?
---
---@param value unknown "?"
---@param types xtype.type | xtype.type[] "?"
---@return boolean, xtype.type "?"
---
xtype.compare = function(value, types)
  local extendedType = xtype.examine(value)

  if _G.production == true then
    return true, extendedType -- skip validation in production mode.
  end

  if type(types) ~= 'table' then
    types = { types } -- convert a single type into an array.
  end

  for index, expectedType in ipairs(types) do
    if expectedType == extendedType then
      return true, extendedType -- types match.
    end

    if extendedType == 'character' and expectedType == 'string' then
      return true, 'string' -- a single character counts as a string, but not the other way around.
    end

    if extendedType == 'empty-table' then
      if expectedType == 'array' or expectedType == 'table' then
        return true, expectedType -- empty table treated as the expected type (array or table).
      end
    end
  end

  return false, extendedType
end

---
--- ?
---
---@param arguments xtype.validation[] "?"
---
xtype.validate = function(arguments)
  if _G.production ~= true then
    for index, argument in ipairs(arguments) do
      local options, value = unpack(argument)
      local identifier, types = string.split(':', options)

      if types == nil then
        error('Missing type declaration for argument.', 3)
      end

      local optional = xstring.hasSuffix(types, '?')
      if optional == true then
        types = types:sub(1, #types - 1) -- remove the trailing question mark.
      end

      ---@type xtype.type[]
      local expectedTypes = { string.split('/', types) }
      local typesMatch, extendedType = xtype.compare(value, expectedTypes)

      if not typesMatch and not (extendedType == 'undefined' and optional) then
        local expected = table.concat(expectedTypes, ' or ')

        local message = 'Invalid argument type for "%s": expected %s, got %s.'
        error(message:format(identifier, expected, extendedType), 3)
      end
    end
  end
end
