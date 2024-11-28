
--[[~ Updated: 2024/11/28 | Author(s): Gopher ]]

---@param message string
---@param ... string|number
---?
backbone.print = function (message, ...) end

---@param message string
---@param ... string|number
---?
backbone.debug = function (message, ...)
  if backbone.getEnvironment() == 'development' then
    --?
  end
end
