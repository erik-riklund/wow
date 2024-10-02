--[[~ Script: API Protection ~
  Created: 2024/10/02
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/02

  Protects the framework API by preventing accidental modifications,
  ensuring its integrity during runtime.

]]

setmetatable(_G.backbone, {
  __newindex = function()
    error('Modifications to the framework API are not allowed.', 3)
  end,
})
