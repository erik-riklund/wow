--[[~ Object factory (utility) ~
  Updated: 2024/11/18 | Author(s): Erik Riklund (Gopher)
]]

---
--- Creates a new instance of the specified object type by dynamically calling<br/>
--- the global constructor function corresponding to the given `object_type`,<br />
--- passing along any additional arguments.
---
--- Throws an error if the constructor is not a globally accessible function.
---
---@generic T
---@param object_type `T`
---@param ... unknown
---
---@return T?
---
_G.new = function(object_type, ...)
  if type(_G[object_type]) ~= 'function' then
    error('Object creation failed, invalid constructor for ' .. object_type, 3)
  end

  return _G[object_type](...) -- returns a new instance of the specified type.
end
