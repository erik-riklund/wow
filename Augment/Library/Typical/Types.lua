local ADDON, CORE = ...
local Type = Type

--      #
--     # #   #    #  ####  #    # ###### #    # #####
--    #   #  #    # #    # ##  ## #      ##   #   #
--   #     # #    # #      # ## # #####  # #  #   #
--   ####### #    # #  ### #    # #      #  # #   #
--   #     # #    # #    # #    # #      #   ##   #
--   #     #  ####   ####  #    # ###### #    #   #
--
-- World of Warcraft addon ecosystem, created by Erik Riklund (2024)
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

function Type:Undefined()
  return self:Validator("nil")
end

function Type:Any()
  return self:Not(self:Undefined())
end

function Type:Boolean(default_value)
  return self:Validator("boolean", default_value)
end

function Type:String(default_value)
  return self:Validator("string", default_value)
end

function Type:Number(default_value)
  return self:Validator("number", default_value)
end

function Type:Function(default_value)
  return self:Validator("function", default_value)
end

function Type:Userdata(default_value)
  return self:Validator("userdata", default_value)
end

function Type:Thread(default_value)
  return self:Validator("thread", default_value)
end

function Type:Optional()
  print("NOT IMPLEMENTED - Type:Optional")
end

function Type:First()
  print("NOT IMPLEMENTED - Type:First")
end

function Type:Not(callback)
  print("NOT IMPLEMENTED - Type:Not") -- how?
end
