--[[~ Module: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

local testkit = backbone.getTestkit()
local stringHasPrefix = backbone.utilities.stringHasPrefix

testkit.createGroup('Utilities: String-related functions', {
  --
  -- stringHasPrefix:
  
  testkit.createSuite('stringHasPrefix', {
    testkit.createTest(
      'a string without the specified prefix return false',
      function() testkit.assertFalse(stringHasPrefix('Hello world', '123')) end
    ),
  }),
})
