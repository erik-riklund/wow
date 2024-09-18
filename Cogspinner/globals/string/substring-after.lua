--
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- ?
--- 
--- @param target     string
--- @param char       string
--- @param occurence? number
--- 
--- @return string
---
_G.getSubstringAfter = function(target, char, occurence)
  -- ?

  if type(target) ~= 'string' then throw('?') end
  if type(char) ~= 'string' or #char > 1 then throw('?') end
  if type(occurence) ~= 'number' then throw('?') end

  -- ?

  local matchesFound = 0
  occurence = occurence or 1
  local charsToReturn = {}

  for i = 1, #target do
    local currentChar = string.sub(target, i, i)

    if matchesFound >= occurence then table.insert(charsToReturn, currentChar) end
    if char == currentChar then matchesFound = matchesFound + 1 end
  end

  return table.concat(charsToReturn)
end
