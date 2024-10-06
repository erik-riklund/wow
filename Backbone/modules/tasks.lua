---@type string, Repository
local addon, repository = ...

--[[~ Module: Tasks ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

---@type Task[]
local tasks = {}

---
--- Executes the provided callback, passing the specified arguments if any are provided.
---
---@param identifier string
---@param callback function
---@param arguments? unknown[]
---
backbone.executeCallback = function(identifier, callback, arguments)
  if type(arguments) ~= 'table' then arguments = {} end

  ---@type boolean, string
  local success, exception = pcall(callback, unpack(arguments))

  if not success then
  end
end

---
--- Queues the provided callback for asynchronous execution.
---
---@param identifier string
---@param callback function
---@param arguments? unknown[]
---
backbone.executeCallbackAsync = function(identifier, callback, arguments)
  table.insert(tasks, { id = identifier, callback = callback, arguments = arguments })
end

-- [explain this section]

local process = coroutine.create(function()
  local frameLimit = 0.01667 -- target: 60fps

  while true do
    local started = GetTime()

    while #tasks > 0 and (GetTime() - started <= frameLimit) do
      local task = table.remove(tasks, 1) --[[@as Task]]
      backbone.executeCallback(task.id, task.callback, task.arguments)
    end

    coroutine.yield()
  end
end)

-- [explain this section]

repository.frame:SetScript('OnUpdate', function()
  if coroutine.status(process) == 'suspended' then
    if #tasks > 0 then coroutine.resume(process) end
  end
end)
