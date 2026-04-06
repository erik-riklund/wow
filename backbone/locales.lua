--  ____             _    _
-- | __ )  __ _  ___| | _| |__   ___  _ __   ___
-- |  _ \ / _` |/ __| |/ / '_ \ / _ \| '_ \ / _ \
-- | |_) | (_| | (__|   <| |_) | (_) | | | |  __/
-- |____/ \__,_|\___|_|\_\_.__/ \___/|_| |_|\___|
--
--   github.com/erik-riklund/wow/backbone (2026)

backbone = backbone or {};
if backbone.locales then
  return; -- the module has already been initialized.
end

local locales = {}; -- used to store registered strings.

--
-- # ?
--
-- ...
--

backbone.locales = {
  --
  -- #
  --
  -- ...
  --

  get_string = function(addon_name, key)
    print("backbone.locales:get_string() is not implemented yet. Do we need this?");
  end,

  --
  -- #
  --
  -- ...
  --

  get_package = function(addon_name)
    local registry = locales[addon_name] or {};
    if not locales[addon_name] then
      print("|cffFFCC33Warning:|r The addon '" .. addon_name .. "' have no registered strings.");
    end
    return function(key)
      local source = registry and (registry[GetLocale()] or registry["enUS"]) or {};
      return source[key] or ("[Invalid localized string: " .. key .. "]");
    end;
  end,

  --
  -- #
  --
  -- ...
  --

  register_strings = function(addon_name, locale, strings)
    if not locales[addon_name] then
      locales[addon_name] = {}; -- initialize the registry for the addon.
    end
    local source = locales[addon_name][locale] or {};
    locales[addon_name][locale] = source;

    for key, value in pairs(strings) do
      if not source[key] then
        source[key] = value; -- ?
      else
        print(
          "|cffFFCC33Warning:|r The key '" .. key ..
          "' already exists for addon '" .. addon_name .. "'."
        );
      end
    end
  end
};
