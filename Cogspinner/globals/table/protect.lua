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
local blockModifications = function()
  throw('Attempt to modify a protected table')
end

---
--- Creates a read-only proxy for a table, ensuring its contents cannot be modified.
--- Any nested tables are also wrapped in protected proxies upon return.
---
--- @param target table
---
_G.createProtectedProxy = function(target)
  local proxy = {
    __newindex = blockModifications,
    __index = function(self, key)
      return (type(target[key]) ~= 'table' and target[key])
              or createProtectedProxy(target[key])
    end
  }

  return setmetatable({}, proxy)
end
