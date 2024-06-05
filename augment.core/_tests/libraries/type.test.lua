local _, CORE = ...

--
--      #
--     # #   #    #  ####  #    # ###### #    # #####
--    #   #  #    # #    # ##  ## #      ##   #   #
--   #     # #    # #      # ## # #####  # #  #   #
--   ####### #    # #  ### #    # #      #  # #   #
--   #     # #    # #    # #    # #      #   ##   #
--   #     #  ####   ####  #    # ###### #    #   #
--
-- World of Warcraft addon framework, created by Erik Riklund (2024)
--

--- @cast CORE framework

if not WoWUnit then return end
local WoWUnit = _G.WoWUnit --[[@as WoWUnit]]
local test = WoWUnit('library: type')

local equal = WoWUnit.AreEqual
local mock = WoWUnit.Replace
local revert = WoWUnit.ClearReplaces

local func = function() end
local task = coroutine.create(func)

--#region [test: examine]

function test.examine()
  local examine = CORE.libs.type.examine

  equal('undefined', examine(nil))
  equal('string', examine('1'))
  equal('number', examine(1))
  equal('boolean', examine(true))
  equal('table', examine({}))
  equal('list', examine({ 1, 2, 3 }))
  equal('map', examine({ alpha = 'a', beta = 'b' }))
  equal('thread', examine(task))
  equal('function', examine(function() end))
end

--#endregion

--#region [test: validate]

function test.validate()
  local validate = CORE.libs.type.validate
  local required = CORE.libs.type.required
  local optional = CORE.libs.type.optional

  local type_error = function(expected_type, actual_type)
    return string.format("Expected a value of type `%s` but recieved `%s`", expected_type, actual_type)
  end

  --#region: simple types

  equal(nil, validate('hello', required('string')).error)
  equal(nil, validate(1, required('number')).error)
  equal(nil, validate(true, required('boolean')).error)
  equal(nil, validate(func, required('function')).error)
  equal(nil, validate(task, required('thread')).error)

  equal(nil, validate({}, required('table')).error)
  equal(nil, validate({ 1, 2, 3 }, required('list')).error)
  equal(nil, validate({}, required('list')).error)
  equal(nil, validate({ a = 'alpha' }, required('map')).error)
  equal(nil, validate({}, required('map')).error)

  equal(type_error('string', 'number'), validate(1, required('string')).error)
  equal(type_error('any', 'undefined'), validate(nil, required('any')).error)
  equal(type_error('map', 'list'), validate({ 1, 2, 3 }, required('map')).error)

  --#endregion

  --#region: flat schema

  equal(
    {
      a = 'alpha',
      b = 123
    },
    validate(
      {
        a = 'alpha'
      },
      required(
        {
          a = required('string'),
          b = optional('number', 123),
          c = optional('table')
        }
      )
    ).value
  )

  equal(
    "Schema validation failed @ \"/c\": Expected a value of type `map` but recieved `list`",
    validate(
      {
        a = 'alpha',
        c = { 1, 2, 3 }
      },
      required(
        {
          a = required('string'),
          b = optional('number', 123),
          c = optional('map')
        }
      )
    ).error
  )

  --#endregion

  --#region: nested schemas

  equal(
    {
      a = 'alpha',
      b = { c = 1 }
    },
    validate(
      {
        a = 'alpha',
        b = { c = 1 }
      },
      required(
        {
          a = required('string'),
          b = required(
            {
              c = required('number')
            }
          )
        }
      )
    ).value
  )

  equal(
    "Schema validation failed @ \"/b/c\": Expected a value of type `number` but recieved `string`",
    validate(
      {
        a = 'alpha',
        b = { c = '1' }
      },
      required(
        {
          a = required('string'),
          b = required(
            {
              c = required('number')
            }
          )
        }
      )
    ).error
  )

  --#endregion
end

--#endregion

--#region [test: declare]

function test.declare()
  local declare = CORE.libs.type.declare
  local required = CORE.libs.type.required
  local optional = CORE.libs.type.optional

  mock(
    CORE.libs.exception, 'throw',
    function(message, ...)
      return ... and string.format(message, ...) or message
    end
  )

  equal(
    { 1, 'hello world' },
    {
      declare(
        { 1, required('number') },
        { 'hello world', optional('string') }
      )
    }
  )

  equal(
    { 1 },
    {
      declare(
        { 1, required('number') },
        { nil, optional('string') }
      )
    }
  )

  equal(
    { 1, 'howdy world' },
    {
      declare(
        { 1, required('number') },
        { nil, optional('string', 'howdy world') }
      )
    }
  )

  equal(
    "Type error for argument #1: Expected a value of type `string` but recieved `number`",
    declare(
      { 1, required('string') }
    )
  )

  revert()
end

--#endregion
