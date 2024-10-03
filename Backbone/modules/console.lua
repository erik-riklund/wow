--[[~ Module: Console ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/03

  Provides a simple console message display system, supporting different 
  log levels (debug, error, info) with color-coded output.

  Future plans:
  - Replace this simple print solution with a proper console (UI).

]]

local colors = {
  debug = 'yellow-orange',
  error = 'bright-orange',
  info = 'albescent-white',
}

---
--- Prints the provided `message` to the console at the specified `level`.
---
---@param level 'debug'|'error'|'info'
---@param message string
---@param variables? MarkupVariables
---
backbone.displayMessage = function(level, message, variables)
  if backbone.getEnvironment() == 'development' or level ~= 'debug' then
    if level == 'error' and backbone.getEnvironment() == 'production' then
      print(
        backbone.processMarkup(
          '<color=yellow-orange>[Backbone] The framework encountered an internal or plugin-related exception.'
            .. '</color>\n<color=albescent-white>You can try "/reload" to check if the problem persists, '
            .. 'or use "/backbone development" to enable more detailed error reporting.</color>\n\n'
        )
      )
    else
      local template = '<color=%s>Backbone:</color>\n<color=albescent-white>%s</color>\n\n'
      message = string.format(template, colors[level], message)

      print(backbone.processMarkup(message, variables))
    end
  end
end
