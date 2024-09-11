--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- Determines if a given string starts with a specified prefix.
---
--- @param target string The target string to check.
--- @param prefix string The prefix to look for at the beginning of the target string.
--- @return boolean `true` if the target string starts with the specified prefix, `false` otherwise.
---
_G.startsWith = function(target, prefix)
  return (string.sub(target, 1, string.len(prefix)) == prefix)
end
