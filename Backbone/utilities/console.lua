--[[~ Module: Console Logger ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/30

  Provides logging functionality for informational, debug, and
  exception messages, with optional variable replacement.

  Features:

  - Supports logging informational, debug, and exception messages.
  - Handles variable replacements in messages.
  - Differentiates logging behavior based on the production environment.

]]

_G.console = {
  -- Logs an informational message to the console, supporting variable replacements.

  ---@param message    string "The informational message to log."
  ---@param variables? table<string, string|number> "(optional) Table of variables for replacement."
  info = function(message, variables)
    print(
      processMarkup(
        '<color=light-mustard>[Backbone] <color=wheat>' .. message .. '</color></color>',
        variables
      )
    )
  end,

  -- Logs a debug message to the console, only if not in the production environment.

  ---@param message    string "The debug message to log."
  ---@param variables? table<string, string|number> "(optional) Table of variables for replacement."
  log = function(message, variables)
    if not _G.production then
      print(processMarkup('<color=olivine>[Backbone]</color> ' .. message, variables))
    end
  end,

  -- Logs an exception message. In production, logs a simplified error message
  -- and suggests reloading or enabling detailed error reporting.

  ---@param message    string "The exception message to log."
  ---@param variables? table<string, string|number> "(optional) Table of variables for replacement."
  exception = function(message, variables)
    if not _G.production then
      print(processMarkup('<color=vivid-orange>[Backbone]</color> ' .. message, variables))
    else
      console.info(
        'The framework encountered an internal or plugin-related exception. You can try "/reload" to '
          .. 'see if the problem persists, or use "/backbone development" to enable more detailed error reporting.'
      )
    end
  end,
}
