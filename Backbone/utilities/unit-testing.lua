--[[~ Utility: Unit Testing ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/01

  Provides testing utilities for the Backbone ecosystem, including test suites
  and groups, as well as support for mocking values and functions during tests.

]]

---@type table<string, { source: table, key: unknown, content: unknown }>
local mocks = {}

---
--- ?
---
backbone.testing = {
  ---
  --- ?
  ---
  ---@param label string
  ---@param suites function
  ---
  group = function(label, suites)
    if not backbone.isProductionMode() then
      print('\n|cFFD69D85 ~' .. label .. ' ~|r\n\n')
      suites() -- execute the provided test suites.
    end
  end,

  ---
  --- ?
  ---
  ---@param label string
  ---@param tests table<string, function>
  ---
  suite = function(label, tests)
    local passed = 0
    local failed = {}

    -- [explain this section]

    for identifier, callback in pairs(tests) do
      local success, exception = pcall(callback)

      if not success then
        local pieces = { string.split(':', exception) }
        table.insert(failed, { id = identifier, message = pieces[3] })
      else
        passed = passed + 1
      end
    end

    -- [explain this section]

    print(
      '|cFFEEC400' .. label .. ' :|r',
      (passed == 0 and #failed == 0 and '|cFFA39477no tests specified|r')
        or (#failed == 0 and '|cFFA9B665' .. passed .. ' passed|r')
        or (passed == 0 and #failed > 0 and '|cFFFF9933' .. #failed .. ' failed|r')
        or string.format('|cFFA9B665%s passed|r , |cFFFF9933%s failed|r', passed, #failed)
    )

    -- [explain this section]

    if #failed > 0 then
      print ' '

      for index, result in ipairs(failed) do
        print('|cFFFF8040   ' .. result.id .. ':|r', result.message)
      end

      print ' '
    end
  end,

  ---
  --- ?
  ---
  ---@param first unknown
  ---@param second unknown
  ---
  assertEqual = function(first, second)
    -- [explain this section]

    if type(first) == 'table' and type(second) == 'table' then
      return backbone.testing.compareTables(first, second)
    end

    -- [explain this section]

    local message = '|cFFD4BE98expected "|cFFF8E9CC%s|r" \124 recieved "|cFFF8E9CC%s|r"|r'
    assert(first == second, string.format(message, tostring(first), tostring(second)))
  end,

  ---
  --- ?
  ---
  ---@param first unknown
  ---@param second unknown
  ---
  assertNotEqual = function(first, second)
    local success = pcall(backbone.testing.isEqual, first, second)
    assert(success == false, '|cFFD4BE98expected values to be different|r')
  end,

  ---
  --- ?
  ---
  ---@param exception string
  ---@param callback function
  ---
  assertError = function(exception, callback)
    local success, result = pcall(callback)
    
    assert(result == exception, string.format('expected error (%s)', exception))
  end,

  ---
  --- ?
  ---
  ---@param callback function
  ---
  assertNoError = function(callback)
    local success, result = pcall(callback)
    
    assert(success == true, string.format('expected no error (%s)', result or ''))
  end,

  ---
  --- ?
  ---
  ---@param source unknown
  ---@param target unknown
  ---@param parents? string
  ---
  compareTables = function(source, target, parents)
    parents = parents or ''

    -- [explain this section]

    for key, value in pairs(target) do
      if type(value) == 'table' and type(source[key]) == 'table' then
        backbone.testing.compareTables(value, source[key], parents .. '/' .. key)
      else
        if source[key] ~= value then
          local message = '|cFFD4BE98expected "|cFFF8E9CC%s|r" but recieved '
            .. '"|cFFF8E9CC%s|r" at index "|cFFF8E9CC%s%s|r"|r'

          error(string.format(message, tostring(value), tostring(source[key]), parents, key))
        end
      end
    end
  end,

  ---
  --- ?
  ---
  ---@param identifier string
  ---@param source table
  ---@param key unknown
  ---@param replacement unknown
  ---
  mock = function(identifier, source, key, replacement)
    if source[key] == nil then error('Mock failed, verify the source.', 3) end

    if mocks[identifier] ~= nil then
      error(string.format('Mock failed, non-unique identifier "%s".', identifier), 3)
    end

    mocks[identifier] = { source = source, key = key, content = source[key] }
    source[key] = replacement
  end,

  ---
  --- ?
  ---
  ---@param identifier string
  ---
  resetMock = function(identifier)
    if mocks[identifier] == nil then
      error(string.format('Unknown mock "%s"', identifier), 3)
    end

    local mock = mocks[identifier]
    mock.source[mock.key] = mock.content
  end,

  ---
  --- ?
  ---
  resetAllMocks = function()
    for identifier in pairs(mocks) do
      backbone.testing.resetMock(identifier)
    end
  end,
}
