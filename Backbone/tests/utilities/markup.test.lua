--[[~ Module: ? ~
  Created: 2024/10/02
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  Unit tests for the markup parsing utility.

]]

local test = backbone.testing
local processMarkup = backbone.processMarkup

test.group('Markup Parser', function()
  --
  test.suite('parseVariables', {
    ['no variables return the original string'] = function()
      test.assertEqual(processMarkup 'Hello world', 'Hello world')
    end,

    ['undefined variable is left intact'] = function()
      test.assertEqual(processMarkup 'Hello $world', 'Hello $world')
    end,

    ['existing variable is replaced'] = function()
      test.assertEqual(processMarkup('Hello $world', { world = 'test' }), 'Hello test')
    end,
  })

  test.suite('parseColors', {
    ['missing color is replaced with white'] = function()
      test.assertEqual(
        processMarkup '<color:no-find>Hello world</color>',
        '|cFFFFFFFFHello world|r'
      )
    end,

    ['valid color is replaced'] = function()
      test.assertEqual(
        processMarkup '<color:golden>Hello world</color>',
        '|cFFEEC400Hello world|r'
      )
    end,

    ['valid color with leading spaces is replaced'] = function()
      test.assertEqual(
        processMarkup '<color: golden>Hello world</color>',
        '|cFFEEC400Hello world|r'
      )
    end,
  })
end)
