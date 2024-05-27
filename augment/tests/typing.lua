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

--[[
    testing of the param class
  ]]

local _param = WoWUnit('utils.typing.param')

function _param:required()
  equal(
    param.required('test', 'string'), { name = 'test', type = 'string' }
  )
end

function _param:optional()
  equal(
    param.optional('test', 'string'), { name = 'test', type = 'string', optional = true }
  )
end

function _param:optional_default()
  equal(
    param.optional('test', 'string', 'Hello world'),
    { name = 'test', type = 'string', optional = true, default = 'Hello world' }
  )
end

--[[
    testing of the property class
  ]]

local _property = WoWUnit('utils.typing.property')

function _property:required()
  equal(
    property.required('string'), { type = 'string' }
  )
end

function _property:optional()
  equal(
    property.optional('string'), { type = 'string', optional = true }
  )
end

function _property:optional_default()
  equal(
    property.optional('string', 'Hello world'),
    { type = 'string', optional = true, default = 'Hello world' }
  )
end

--[[
    testing of the type evaluator
  ]]

local _examine = WoWUnit('utils.typing.examine')

function _examine:undefined()
  equal(examine(nil), 'undefined')
end

function _examine:string()
  equal(examine('1'), 'string')
end

function _examine:number()
  equal(examine(1), 'number')
end

function _examine:boolean()
  equal(examine(true), 'boolean')
end

function _examine:table_empty()
  equal(examine({}), 'table')
end

function _examine:table_list()
  equal(examine({ 1, 2, 3 }), 'list')
end

function _examine:table_map()
  equal(examine({ alpha = 'a', beta = 'b' }), 'map')
end

function _examine:thread()
  equal(examine(coroutine.create(function() end)), 'thread')
end

function _examine:func()
  equal(examine(function() end), 'function')
end

--[[
    testing of the type validator
  ]]

local _validate_type = WoWUnit('utils.typing.validate_type')

function _validate_type:pass()
  equal(validate_type('1', { type = 'string' }).error == nil, true)
end

function _validate_type:reject()
  equal(validate_type(1, { type = 'string' }).error == nil, false)
end
