if not WoWUnit then return end
local WoWUnit = _G.WoWUnit --[[@as WoWUnit]]

--
--      #
--     # #   #    #  ####  #    # ###### #    # #####
--    #   #  #    # #    # ##  ## #      ##   #   #
--   #     # #    # #      # ## # #####  # #  #   #
--   ####### #    # #  ### #    # #      #  # #   #
--   #     # #    # #    # #    # #      #   ##   #
--   #     #  ####   ####  #    # ###### #    #   #
--
-- World of Warcraft addon ecosystem, created by Erik Riklund (2024)
--

local test = WoWUnit('utils: typical')

local equal = WoWUnit.AreEqual
local mock = WoWUnit.Replace
local revert = WoWUnit.ClearReplaces

local func = function() end
local task = coroutine.create(func)
local type_error = _G.exception.type_error

--#region [function: test.examine]

function test.examine()
  local examine = _G.typical.examine

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

--#region [function: test.validate]

function test.validate()
  local validate, required, optional =
      _G.typical.validate, _G.typical.required, _G.typical.optional

  --#region [simple types]

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
  --#region [flat schema]

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
  --#region [nested schemas]

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

--#region [function: test.declare]

function test.declare()
  local declare, required, optional =
      _G.typical.declare, _G.typical.required, _G.typical.optional

  mock(_G, 'error', function(message) return message end)

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

  revert()
end

--#endregion
