--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/core (2026)

local x = select(2, ...)

--
-- A centralized hexadecimal color configuration map.
--

local palette = {
  normal    = 'F5DEB3', -- Warm, wheat color.
  neutral   = 'FFFFFF', -- Plain white.
  faded     = 'BEBEBE', -- Light gray.
  info      = '4682B4', -- Steel blue.
  error     = 'CC4733', -- Dark red-orange.
  highlight = 'FCD462', -- Soft golden-yellow.
  success   = '00AC00', -- Bright green.
}

--
-- Converts custom pseudo-HTML styling tags inside a string into
-- native UI escape formatting tokens (`|cFFxxxxxx` and `|r`).
-- 
-- Resolves either explicit hex sequences (e.g., `<#FFFFFF>`) or mapped palette 
-- names (e.g., `<success>`), closing strings cleanly via the `</end>` tag wrapper.
--

local function colorize_text(input)
  local result = input
      :gsub(
        '<#(%x%x%x%x%x%x)>', function(color)
          return '|cFF' .. color
        end
      )
      :gsub(
        '<([a-z]+)>', function(color_code)
          return '|cFF' .. (palette[color_code] or palette.normal)
        end
      )
      :gsub('</end>', '|r')

  return result
end

--
-- Intercepts string logs, formatting optional additional string arguments via 
-- 'string.format'. Enforces standard layout token wrappers and prints to the active 
-- chat framing layout using the 'normal' palette profile.
--

scavenger.extend(
  "print", function(output, ...)
    local result = (... and string.format(output, ...)) or output
    print(colorize_text('<normal>' .. tostring(result) .. '</end>'))
  end
)

--
-- Formats and prints warning outputs. Applies the soft golden-yellow 
-- 'highlight' styling token wrapper before displaying text to draw visibility.
--

scavenger.extend(
  "warn", function(output, ...)
    local result = (... and string.format(output, ...)) or output
    print(colorize_text('<highlight>' .. tostring(result) .. '</end>'))
  end
)

--
-- Formats and prints terminal failures or exception warnings. Applies the dark 
-- red-orange 'error' styling token wrapper to designate critical pipeline operations.
--

scavenger.extend(
  "error", function(output, ...)
    local result = (... and string.format(output, ...)) or output
    print(colorize_text('<error>' .. tostring(result) .. '</end>'))
  end
)
