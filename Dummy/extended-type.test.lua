--[[~ Script: ? ~
  Created: 2024/10/01
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

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
    -- [explain this section]

    ['character should match character'] = function()
      test.isEqual({ compareExtendedTypes('c', 'character') }, { true, 'character' })
    end,
    ['string should match character'] = function()
      test.isEqual({ compareExtendedTypes('c', 'string') }, { true, 'string' })
    end,
    ['character should not match string'] = function()
      test.isEqual({ compareExtendedTypes('alpha', 'character') }, { false, 'string' })
    end,

    -- [explain this section]

    ['array should match table'] = function()
      test.isEqual({ compareExtendedTypes({}, 'array') }, { true, 'array' })
    end,
    ['array should match array'] = function()
      test.isEqual({ compareExtendedTypes(numericTable, 'array') }, { true, 'array' })
    end,
    ['array should not match hashmap'] = function()
      test.isEqual({ compareExtendedTypes(associativeTable, 'array') }, { false, 'hashmap' })
    end,

    -- [explain this section]

    ['hashmap should match table'] = function()
      test.isEqual({ compareExtendedTypes({}, 'hashmap') }, { true, 'hashmap' })
    end,
    ['hashmap should match hashmap'] = function()
      test.isEqual({ compareExtendedTypes(associativeTable, 'hashmap') }, { true, 'hashmap' })
    end,
    ['hashmap should not match array'] = function()
      test.isEqual({ compareExtendedTypes(numericTable, 'hashmap') }, { false, 'array' })
    end,

    -- [explain this section]
  })
end)
