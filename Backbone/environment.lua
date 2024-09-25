--[[~ Module: Environment Control ~

  Version: 1.0.0 | Updated: 2024/09/25

  This module provides a global flag, `_G.production`, to control the behavior of 
  the framework based on the environment. By toggling this flag, the framework can 
  adapt its behavior to either production or development modes, allowing for 
  different levels of logging, error reporting, or optimizations.

  Developer's notes:
  
  - The `_G.production` flag is set to `false` by default, indicating that the 
    framework is running in development mode. This flag can be toggled to `true` 
    when switching to a production environment.

]]

--
-- This flag can be toggled to enable or disable production-specific behaviors in
-- the framework, allowing different behavior in production vs. development modes.
--
_G.production = false
