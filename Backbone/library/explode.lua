
--[[~ Updated: 2024/11/27 | Author(s): Gopher ]]

---@param target string The string to be split.
---@param separator string The delimiter used to separate the string.
---@param pieces? number The maximum number of splits to perform. If not provided, all possible splits are performed.
---@return Vector components A `Vector` object containing the split components of the string.
---Splits a string into parts based on a given separator, and returns the result as a `Vector` object.
_G.explode = function (target, separator, pieces)
  local components = new ('Vector', { string.split(separator, target, pieces) })
  components:forEach(function (_, element) return string.trim(element) end)

  return components
end
