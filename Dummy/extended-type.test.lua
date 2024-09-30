--[[~ Module: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/30

  ?

  Features:

  - ?

]]

local test = backbone.testing

local getExtendedType = backbone.getExtendedType
local compareExtendedTypes = backbone.compareExtendedTypes
local validateExtendedTypes = backbone.validateExtendedTypes

-- [explain this section]

local emptyTable = {}
local numericTable = { 1, 2, 3, 4, 5 }
local associativeTable = { a = 'alpha' }

-- [explain this section]

test.group('Type Extension', function()
  -- [explain this section]

  test.suite('getExtendedType', {
    ['is undefined'] = function()
      test.isEqual(getExtendedType(nil), 'undefined')
    end,
    ['is character'] = function()
      test.isEqual(getExtendedType 'a', 'character')
    end,
    ['is string'] = function()
      test.isEqual(getExtendedType 'alpha', 'string')
    end,
    ['is table'] = function()
      test.isEqual(getExtendedType(emptyTable), 'table')
    end,
    ['is array'] = function()
      test.isEqual(getExtendedType(numericTable), 'array')
    end,
    ['is hashmap'] = function()
      test.isEqual(getExtendedType(associativeTable), 'hashmap')
    end,
  })

  -- [explain this section]

  test.suite('compareExtendedTypes', {
    ['character equals character'] = function()
      test.compareTables({ compareExtendedTypes('c', 'character') }, { true, 'character' })
    end,
    ['string match character'] = function()
      test.compareTables({ compareExtendedTypes('c', 'string') }, { true, 'string' })
    end,
    ['character does not match string'] = function()
      test.compareTables({ compareExtendedTypes('alpha', 'character') }, { false, 'string' })
    end,
  })
end)
