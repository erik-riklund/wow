if not WoWUnit then return end
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

local equal = WoWUnit.AreEqual
local _test = WoWUnit('utils.typing')

--
-- param class
--

function _test:param()
  equal({ name = 'test', type = 'string' }, param.required('test', 'string'))
  equal({ name = 'test', type = 'string', optional = true }, param.optional('test', 'string'))
  equal(
    { name = 'test', type = 'string', optional = true, default = 'Hello world' },
    param.optional('test', 'string', 'Hello world')
  )
end

--
-- property class
--

function _test:property()
  equal({ type = 'string' }, property.required('string'))
  equal({ type = 'string', optional = true }, property.optional('string'))
  equal({ type = 'string', optional = true, default = 'Hello world' }, property.optional('string', 'Hello world'))
end

--
-- type evaluator
--

function _test:examine()
  equal('undefined', examine(nil))
  equal('string', examine('1'))
  equal('number', examine(1))
  equal('boolean', examine(true))
  equal('table', examine({}))
  equal('list', examine({ 1, 2, 3 }))
  equal('map', examine({ alpha = 'a', beta = 'b' }))
  equal('thread', examine(coroutine.create(function() end)))
  equal('function', examine(function() end))
end

--
-- type validator
--

function _test:validate_type()
  equal(nil, validate_type(nil, { type = 'undefined' }).error)
  equal(nil, validate_type('1', { type = 'string' }).error)
  equal(nil, validate_type(1, { type = 'number' }).error)
  equal(nil, validate_type(true, { type = 'boolean' }).error)
  equal(nil, validate_type(function() end, { type = 'function' }).error)
  equal(nil, validate_type(coroutine.create(function() end), { type = 'thread' }).error)
  equal(nil, validate_type({}, { type = 'table' }).error)
  equal(nil, validate_type({ 1 }, { type = 'list' }).error)
  equal(nil, validate_type({}, { type = 'list' }).error)
  equal(nil, validate_type({ alpha = 'a' }, { type = 'map' }).error)
  equal(nil, validate_type({}, { type = 'map' }).error)

  equal("Expected a value of type `string` but recieved `number`", validate_type(1, { type = 'string' }).error)
  equal("Expected a value of type `any` but recieved `undefined`", validate_type(nil, { type = 'any' }).error)
  equal("Expected a value of type `map` but recieved `list`", validate_type({ 1 }, { type = 'map' }).error)
end

--
-- schema validator
--

function _test:validate_schema()
  local schema = (
    {
      alpha = property.required('string'),
      beta = property.required(
        {
          b_alpha = property.required('string'),
          b_beta = property.optional('number', 1)
        }
      ),
      charlie = property.optional('number'),
      delta = property.optional('list', { 1, 2, 3 })
    }
  ) --[[@as schema]]

  equal('@root/bogus: Unexpected property, please verify your schema', validate_schema({ bogus = true }, schema).error)
  equal('@root/alpha: Expected a value of type `string` but recieved `undefined`',
    validate_schema({ beta = {} }, schema).error)
end
