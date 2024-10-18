--[[~ Module: Error Handler ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: 2024/10/18

]]

---
--- Throws a formatted exception in development mode,
--- with the provided message and optional arguments.
---
---@param message string
---@param ... string | number
backbone.throwException = function(message, ...)
  if backbone.getEnvironment() == 'development' then
    error((... and string.format(message, ...)) or message, 3)
  end

  backbone.displayErrorMessage '?' -- display a generic error message in production mode.
end

---
--- Displays the error frame with the specified message in development mode,
--- or a generic error message in production mode.
---
---@param message string
---@param ... string | number
backbone.displayErrorMessage = function(message, ...)
  local frame = _G['BackboneErrorFrame'] --[[@as ErrorFrame]]

  if not frame:IsShown() then
    backbone.widgetControllers.setErrorFrameContent(
      (
        backbone.getEnvironment() == 'development'
        and ((... and string.format(message, ...)) or message)
      ) or backbone.getLocalizedString('backbone', 'GENERIC_INTERNAL_ERROR')
    )

    frame:SetShown(true)
  end
end
