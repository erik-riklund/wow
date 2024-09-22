--[[

  Project: Backbone (framework)
  Library: ?
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/22 | Updated: 2024/09/22

  Description:
  ?

  Dependencies:

  - ?

  Notes:

  - ?

]]

---
--- ?
---
_G.xstring = {
  ---
  --- Checks if the given string starts with the specified prefix.
  --- 
  --- @param target  string  "The string to check."
  --- @param prefix  string  "The prefix to check for at the start of the string."
  ---
  hasPrefix = function(target, prefix)
    return (target:sub(1, prefix:len()) == prefix)
  end,
}
