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
  --
  test.suite('getExtendedType', {
    ['is undefined'] = function()
      test.assertEqual(getExtendedType(nil), 'undefined')
    end,

    ['is character'] = function()
      test.assertEqual(getExtendedType 'a', 'character')
    end,

    ['is string'] = function()
      test.assertEqual(getExtendedType 'alpha', 'string')
    end,

    ['is table'] = function()
      test.assertEqual(getExtendedType(emptyTable), 'table')
    end,

    ['is array'] = function()
      test.assertEqual(getExtendedType(numericTable), 'array')
    end,

    ['is hashmap'] = function()
      test.assertEqual(getExtendedType(associativeTable), 'hashmap')
    end,
  })

  test.suite('compareExtendedTypes', {
    -- [explain this section]

    ['is character'] = function()
      test.assertEqual({ compareExtendedTypes('c', 'character') }, { true, 'character' })
    end,

    ['string is character'] = function()
      test.assertEqual({ compareExtendedTypes('c', 'string') }, { true, 'string' })
    end,

    ['character is not string'] = function()
      test.assertNotEqual(
        { compareExtendedTypes('alpha', 'character') },
        { true, 'character' }
      )
    end,

    -- [explain this section]

    ['array is table'] = function()
      test.assertEqual({ compareExtendedTypes({}, 'array') }, { true, 'array' })
    end,

    ['is array'] = function()
      test.assertEqual({ compareExtendedTypes(numericTable, 'array') }, { true, 'array' })
    end,

    ['array is not hashmap'] = function()
      test.assertNotEqual(
        { compareExtendedTypes(associativeTable, 'array') },
        { true, 'array' }
      )
    end,

    -- [explain this section]

    ['hashmap is table'] = function()
      test.assertEqual({ compareExtendedTypes({}, 'hashmap') }, { true, 'hashmap' })
    end,

    ['is hashmap'] = function()
      test.assertEqual(
        { compareExtendedTypes(associativeTable, 'hashmap') },
        { true, 'hashmap' }
      )
    end,

    ['hashmap is not array'] = function()
      test.assertNotEqual(
        { compareExtendedTypes(numericTable, 'hashmap') },
        { true, 'hashmap' }
      )
    end,
  })

  test.suite('validateExtendedTypes', {
    -- [explain this section]

    ['rule without type should error'] = function()
      test.assertError('Missing type declaration for argument "alpha".', function()
        backbone.validateExtendedTypes { { rule = 'alpha', value = 'alpha' } }
      end)
    end,

    ['invalid type should error'] = function()
      test.assertError(
        'Invalid argument type for "alpha": expected string, got number.',
        function()
          backbone.validateExtendedTypes { { rule = 'alpha:string', value = 1 } }
        end
      )
    end,

    ['missing argument should error'] = function()
      test.assertError(
        'Invalid argument type for "alpha": expected string, got undefined.',
        function()
          backbone.validateExtendedTypes { { rule = 'alpha:string' } }
        end
      )
    end,

    -- [explain this section]

    ['missing optional argument should not error'] = function()
      test.assertNoError(function()
        backbone.validateExtendedTypes { { rule = 'alpha:string?' } }
      end)
    end,

    ['matching single type should not error'] = function()
      test.assertNoError(function()
        backbone.validateExtendedTypes { { rule = 'alpha:string', value = '123' } }
      end)
    end,

    ['matching multiple types should not error'] = function()
      test.assertNoError(function()
        backbone.validateExtendedTypes { { rule = 'alpha:string/table', value = {} } }
      end)
    end,
  })
end)
