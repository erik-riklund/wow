--[[~ Script: API Protection ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  Blocks accidental modifications to the framework API
  to maintain its integrity during runtime.

]]

setmetatable(backbone, {
  __newindex = function ()
    backbone.throwError('Blocked attempt to modify the framework API.') --
  end
})
