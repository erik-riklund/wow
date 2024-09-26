--[[~ Module: Environment Control ~

  Version: 1.0.0 | Updated: 2024/09/25

  This module provides a simple mechanism to toggle between development and production modes in the
  framework. This flag can be used to conditionally enable or disable specific behaviors depending on
  the environment, such as logging, error handling, or performance-related optimizations.

  Features:
  - A global `production` flag that components and plugins can check
    to adjust their behavior based on the environment.

]]

-- This flag can be toggled to enable or disable production-specific behaviors in
-- the framework, allowing different behavior in production vs. development modes.
_G.production = false
