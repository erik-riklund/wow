--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/habits (2026)

--
-- # Behavioral loot thresholds & constants
--
-- Configures the parameters for the player habit tracking engine.
-- This determines how quickly the addon learns what you like to loot,
-- and how fast it forgets items when you stop looting them.
--

local threshold = 3                  -- The number of manual loots needed before auto-loot kicks in.
local decay_rate = 0.5               -- ?
local count_limit = 10               -- Cap the maximum history tally to prevent extreme memory lock-in.
local seconds_per_day = 60 * 60 * 24 -- Math helper to translate game uptime seconds into calendar days.

--
-- # Saved habit data retrieval
--
-- Pulls the historical habit metrics and the last execution timestamp
-- from the addon's saved variables.
--

local now = GetTime()
local today = date("%m/%d/%y")
local last_purge = scavenger.get_variable("/habits/last_purge")
local registry = scavenger.get_variable("/habits/registry")

---
-- # Registry initialization
--
-- If this is a clean install or a new character, establish the database
-- structure in the saved variables to ensure tracking begins cleanly.
--

if not registry then
  registry = {} -- Initialize the table used to track looted items.
  scavenger.set_variable("/habits/registry", registry)
end

--
-- # Daily habit decay & cache purge
--
-- Runs once per day. It checks how many real-world days have elapsed since
-- an item was last looted and decays its counter using an exponential decay formula.
-- This prevents the database from bloating with items you only picked up once.
--

if last_purge ~= today then
  scavenger.set_variable("/habits/last_purge", today)

  for link, data in pairs(registry) do
    local days_passed = (now - data.last_looted) / seconds_per_day
    local decayed_tally = math.floor(data.count * (decay_rate ^ days_passed))

    if decayed_tally < 1 then
      registry[link] = nil -- Clear the item data from the cache if the habit completely died out.
    else
      registry[link] = {
        count = decayed_tally,
        last_looted = data.last_looted
      }
    end
  end
end

--
-- # Dynamic habit auto-loot rule
--
-- A rule injected into the core evaluation engine. If an item appears in the loot
-- window and your history shows you have manually looted it at least 'threshold'
-- times recently, it bypasses the UI and auto-loots it instantly.
--

scavenger.register_loot_rule(
  function(slot)
    if slot.type == Enum.LootSlotType.Item then
      local item = slot.item
      local item_data = registry[item.link]

      if item_data and item_data.count >= threshold then
        return true -- Instruct the controller to loot the item.
      end
    end
  end
)

--
-- # Player interaction hook
--
-- Listens for successful item loot events. If you manually loot an item that isn't
-- soulbound, this hook increments its frequency count in the habit directory and
-- refreshes the timer, slowly training the addon to handle it for you in the future.
--

scavenger.add_event_hook(
  "SLOT_LOOTED", function(slot)
    if slot and not slot.ignored and slot.type == Enum.LootSlotType.Item then
      local item = slot.item

      if item.bind_type == Enum.ItemBind.None then
        if not slot.autolooted and registry[item.link] == nil then
          registry[item.link] = {
            count = 1, last_looted = GetTime()
          }
        elseif registry[item.link] ~= nil then
          registry[item.link] = {
            count = math.min(registry[item.link].count + 1, count_limit),
            last_looted = GetTime()
          }
        end
      end
    end
  end
)
