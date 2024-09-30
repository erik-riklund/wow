--[[~ Module: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/30

  ?

  Features:

  - ?

]]

backbone.testing = {}

---
---
---
---@param label string
---@param suites function
---
backbone.testing.group = function(label, suites)
  print('\n~ ' .. label .. ' ~\n\n')
  suites() -- execute the provided test suites.
end

---
--- ?
---
---@param label string
---@param tests table<string, function>
---
backbone.testing.suite = function(label, tests)
  local passed = 0
  local failed = {}

  for identifier, callback in pairs(tests) do
    local success, exception = pcall(callback)

    if not success then
      local pieces = { string.split(':', exception) }
      table.insert(failed, { id = identifier, message = pieces[3] })
    else
      passed = passed + 1
    end
  end

  print(
    '|cFFEEC400' .. label .. ' :|r',
    (passed == 0 and #failed == 0 and '|cFFA39477no tests available|r')
      or (#failed == 0 and '|cFFA9B665' .. passed .. ' passed|r')
      or string.format('|cFFA9B665%s passed|r , |cFFDE4B37%s failed|r', passed, #failed)
  )

  if #failed > 0 then
    print ' '

    for index, result in ipairs(failed) do
      print('|cFFC65555   ' .. result.id .. ':|r', result.message)
    end

    print ' '
  end
end

---
--- ?
---
---@param first unknown
---@param second unknown
---
backbone.testing.isEqual = function(first, second)
  assert(
    first == second,
    string.format(
      '|cFFD4BE98expected "|cFFF8E9CC%s|r" \124 recieved "|cFFF8E9CC%s|r"|r',
      tostring(first),
      tostring(second)
    )
  )
end

---
--- ?
---
---@param source unknown
---@param target unknown
---@param parents? string
---
backbone.testing.compareTables = function(source, target, parents)
  parents = parents or ''

  for key, value in pairs(target) do
    if type(value) == 'table' and type(source[key]) == 'table' then
      backbone.testing.compareTables(value, source[key], parents .. '/' .. key)
    else
      if source[key] ~= value then
        error(
          string.format(
            '|cFFD4BE98expected "|cFFF8E9CC%s|r" but recieved "|cFFF8E9CC%s|r" '
              .. 'at index "|cFFF8E9CC%s%s|r"|r',
            tostring(value),
            tostring(source[key]),
            parents,
            key
          )
        )
      end
    end
  end
end
