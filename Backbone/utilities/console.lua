--[[~ Module: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/29

  ?

  Features:

  - ?

  Dependencies: ?

]]

---@type console
local console = {
  -- [explain what the purpose and result of this function is]

  info = function(message, ...)
    -- todo: implementation
  end,

  -- [explain what the purpose and result of this function is]

  log = function(message, ...)
    if _G.production ~= true then
      -- todo: implementation
    end
  end,

  -- [explain what the purpose and result of this function is]

  warning = function(message, ...)
    if _G.production ~= true then
      -- todo: implementation
    end
  end,

  -- [explain what the purpose and result of this function is]

  exception = function(message, ...)
    if _G.production ~= true then
      -- todo: implementation
    end
  end,
}

-- [explain this section up until the next placeholder]

_G.console = getProtectedProxy(console) --[[@as console]]
