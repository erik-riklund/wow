--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|
--
--- @type string, Context
local addon, framework = ...

local exception = _G.exception
local type = _G.type

--
-- This table centrally stores objects exported by framework modules or plugins,
-- organized by context to ensure isolation and avoid naming conflicts.
--
--- @type table<string, unknown>
--
local objects = {}

--
-- Retrieves an object from the framework or a specific plugin's context and throws
-- an error if the owner's context or the requested object does not exist, aiding in
-- debugging dependency issues.
--
framework.import = function(identifier, owner)
  owner = owner or framework

  if type(objects[owner]) ~= 'table' then
    exception('Import failed: The `owner` context has not exported any objects.')
  end

  if objects[owner][identifier] == nil then
    exception('Import failed: The requested object ("%s") does not exist.', identifier)
  end

  return objects[owner][identifier]
end

--
-- Registers an object to either the framework context or a specific plugin's context.
-- Errors are thrown if the object is `nil` or if an object with the same identifier
-- already exists in the given context.
--
framework.export = function(identifier, object, owner)
  owner = owner or framework

  if object == nil then
    exception('Export failed: Cannot export a `nil` object.')
  end

  if type(objects[owner]) ~= 'table' then
    objects[owner] = {}
  end

  if objects[owner][identifier] ~= nil then
    exception('Export failed: An object with the identifier "%s" already exists.', identifier)
  end

  objects[owner][identifier] = object
end
