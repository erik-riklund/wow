local _, this = ...

--
-- ?
--
this.junk = {
  min_value = { silver = 9, copper = 99 },
  max_value = { gold = 9, silver = 99 }
};

--
-- ?
--
this.money = {
  min_value = { copper = 1 },
  max_value = { gold = 24, silver = 99, copper = 99 }
};

--
-- ?
--
-- 1.  Parts
-- 4.  Jewelcrafting
-- 5.  Cloth
-- 6.  Leather
-- 7.  Metal & Stone
-- 8.  Cooking
-- 9.  Herb
-- 10. Elemental
-- 11. Other
-- 12. Enchanting
-- 16. Inscription
-- 18. Optional Reagents
-- 19. Finishing Reagents
--
this.reagents = {
  lootable_types = {
    {
      id = 5, -- cloth
      quantity = { max = 9 }
    },
    {
      id = 7, -- metal and stone
      quantity = { max = 9 }
    },
    {
      id = 9, -- herbs
      quantity = { max = 9 }
    }
  },

  quality_threshold = Enum.ItemQuality.Uncommon
};

--
-- ?
--
this.items = {
  { id = 173204, action = "ignore" }, -- Lightless Silk

  -- { id = 130267, action = "ignore" }
  -- { id = 130267, quantity = { min = 2, max = 3 } }
};

--
-- ?
--
this.currencies = {

};
