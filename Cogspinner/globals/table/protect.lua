--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
---
--- Safeguards a proxy against modifications by triggering
--- an error upon any changes to its contents.
---
local blockModifications =
 function() throw('Attempt to modify a protected table') end

---
--- Creates a read-only proxy for a table, ensuring its contents cannot be modified.
--- Any nested tables are also wrapped in protected proxies upon return.
---
--- @param target table
---
_G.createProtectedProxy = function(target)
  if type(target) ~= 'table' then
    throw('Invalid argument type (target), expected a table')
  end

  local proxy = {
    --
    -- Throws an error if any modifications to the proxy are attempted.
    --
    __newindex = blockModifications,

    --
    -- Nested tables are returned as protected proxies; other value types remain unchanged.
    --
    __index = function(self, key)
      if target[key] ~= nil then
        return (type(target[key]) ~= 'table' and target[key])
                or createProtectedProxy(target[key])
      end
    end
  }

  return setmetatable({}, proxy)
end
