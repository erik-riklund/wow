--[[~ Module: Error Handler ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: 2024/10/14

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
--- ?
---
---@param message string
---@param ... string | number
backbone.displayErrorMessage = function(message, ...)
  local frame = _G['BackboneErrorFrame'] --[[@as ErrorFrame]]

  if not frame:IsShown() then
    if backbone.getEnvironment() == 'development' then
      -- TODO: add markup processing.
      backbone.widgetControllers.setErrorFrameContent(
        (... and string.format(message, ...)) or message
      )
    else
      if not frame.isInitialized then
        frame.isInitialized = true

        backbone.registerLocalizedLabels {
          { object = frame.contentLabel, labelKey = 'backbone:GENERIC_INTERNAL_ERROR' },
        }
        backbone.widgetControllers.setErrorFrameContent(
          backbone.getLocalizedString('backbone', 'GENERIC_INTERNAL_ERROR')
        )
      end
    end

    frame:SetShown(true)
  end
end
