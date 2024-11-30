
--[[~ Updated: 2024/11/30 | Author(s): Gopher ]]

---@param target table
---@param parents? string
---@param result? table
---?
_G.flattenTable = function (target, parents, result)
  if type (target) ~= 'table' then
    error('Expected a table for argument #1 (target).', 3)
  end

  result = (type (result) == 'table' and result) or {}
  for key, value in pairs (target) do
    local modified_key = string.gsub(key, '[$]', '')
    local result_key = (parents and string.format ('%s/%s', parents, modified_key)) or modified_key
    
    if type (value) == 'table' and (string.sub (key, 1, 1) ~= '$') then
      flattenTable (value, result_key, result) else result[result_key] = value
    end
  end

  return result
end
