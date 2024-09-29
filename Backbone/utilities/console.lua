--[[~ Module: Console Logger ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/29

  This module provides a console logging utility for the framework. It supports various logging 
  levels, such as `info`, `log`, and `exception`, with support for formatted messages and variables. 
  The logging output is color-coded based on the log level, and exceptions are handled differently 
  depending on the environment (development vs. production).

  Features:

  - Color-coded console logging for different log levels.
  - Support for variable replacement in log messages.
  - Custom exception handling based on the environment.

]]

_G.console = {
  ---
  --- This function logs an informational message to the console. The message is formatted with
  --- a color-coded prefix indicating that it comes from the Backbone framework. Optionally, variables
  --- in the message can be replaced using the provided `variables` table.
  ---
  ---@param message    string "The informational message to log."
  ---@param variables? table<string, string|number> "(optional) Table of variables for replacement."
  ---
  info = function(message, variables)
    print(
      processMarkup(
        '<color=light-mustard>[Backbone] <color=wheat>' .. message .. '</color></color>',
        variables
      )
    )
  end,

  ---
  --- This function logs a debug message to the console. It only outputs the message when the
  --- framework is not in production mode. The log message is color-coded to differentiate it
  --- from other types of messages, and variables in the message can be replaced using the
  --- `variables` table.
  ---
  ---@param message    string "The debug message to log."
  ---@param variables? table<string, string|number> "(optional) Table of variables for replacement."
  ---
  log = function(message, variables)
    if not _G.production then
      print(processMarkup('<color=olivine>[Backbone]</color> ' .. message, variables))
    end
  end,

  ---
  --- This function logs an exception message to the console. In development mode, the message
  --- is printed with color-coded formatting. In production mode, a simplified message is logged,
  --- advising the user to reload or enable development mode for more detailed error reporting.
  ---
  ---@param message    string "The exception message to log."
  ---@param variables? table<string, string|number> "(optional) Table of variables for replacement."
  ---
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
