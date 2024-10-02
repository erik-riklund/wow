--[[~ Utility: Unit Testing ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/01

  Provides testing utilities for the Backbone ecosystem, including test suites
  and groups, as well as support for mocking values and functions during tests.

]]

local processMarkup = backbone.processMarkup

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
      print(processMarkup('\n<color: donkey-brown>~ $label ~</color>\n\n', { label = label }))
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
      processMarkup('<color: golden>$label:</color>', { label = label }),
      (
        passed == 0
        and #failed == 0
        and processMarkup '<color: donkey-brown>no tests specified</color>'
      )
        or (#failed == 0 and processMarkup(
          '<color: olive-green>$passed passed</color>',
          { passed = passed }
        ))
        or (passed == 0 and processMarkup(
          '<color: saffron>$failed failed</color>',
          { failed = #failed }
        ))
        or processMarkup(
          '<color: olive-green>$passed passed</color> , <color: saffron>$failed failed</color>',
          { passed = passed, failed = #failed }
        )
    )

    -- [explain this section]

    if #failed > 0 then
      print ' '

      for index, result in ipairs(failed) do
        print(processMarkup('<color: mango-orange>$id:\n</color> $message', result))
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

    local message = '<color: vanilla>expected "<color: white>$expected</color>" '
      .. 'but recieved "<color: white>$recieved</color>"</color>'

    assert(
      first == second,
      processMarkup(message, { expected = tostring(first), recieved = tostring(second) })
    )
  end,

  ---
  --- ?
  ---
  ---@param first unknown
  ---@param second unknown
  ---
  assertNotEqual = function(first, second)
    local success = pcall(backbone.testing.assertEqual, first, second)
    assert(success == false, processMarkup '<color: vanilla>expected different values</color>')
  end,

  ---
  --- ?
  ---
  ---@param exception string
  ---@param callback function
  ---
  assertError = function(exception, callback)
    local success, result = pcall(callback)

    assert(
      result == exception,
      processMarkup(
        '<color: vanilla>expected error (<color: white>$exception</color>)</color>',
        { exception = exception }
      )
    )
  end,

  ---
  --- ?
  ---
  ---@param callback function
  ---
  assertNoError = function(callback)
    local success, result = pcall(callback)

    assert(
      success == true,
      processMarkup(
        '<color: vanilla>expected no error (<color: white>$exception</color>)</color>',
        { exception = result or '' }
      )
    )
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
          local message = '<color: vanilla>expected "<color: white>$expected</color>" but recieved '
            .. '"<color: white>$recieved</color>" at index "<color: white>$parents$key</color>"</color>'

          error(processMarkup(message, {
            expected = tostring(value),
            recieved = tostring(source[key]),
            parents = parents,
            key = key,
          }))
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
