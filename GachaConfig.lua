-- GachaConfig ModuleScript
local GachaConfig = {}

GachaConfig.Categories = {
    Styles = 53,
    Balls = 53,
    Abilities = 20,
}

GachaConfig.RarityWeights = {
    Styles = {
        Common = 0.50,
        Uncommon = 0.30,
        Rare = 0.15,
        Legendary = 0.05,
    },
    Balls = {
        Common = 0.50,
        Uncommon = 0.30,
        Rare = 0.15,
        Legendary = 0.05,
    },
    Abilities = {
        Common = 0.40,
        Uncommon = 0.35,
        Rare = 0.20,
        Legendary = 0.05,
    },
}

GachaConfig.ItemPools = {
    Styles = {},
    Balls = {},
    Abilities = {},
}

for i = 1, 53 do
    table.insert(GachaConfig.ItemPools.Styles, {
        id = "Style_" .. i,
        name = "Style " .. i,
        rarity = i % 20 == 0 and "Legendary" or (i % 5 == 0 and "Rare" or (i % 2 == 0 and "Uncommon" or "Common")),
    })
    table.insert(GachaConfig.ItemPools.Balls, {
        id = "Ball_" .. i,
        name = "Ball " .. i,
        rarity = i % 20 == 0 and "Legendary" or (i % 5 == 0 and "Rare" or (i % 2 == 0 and "Uncommon" or "Common")),
    })
end

for i = 1, 20 do
    table.insert(GachaConfig.ItemPools.Abilities, {
        id = "Ability_" .. i,
        name = "Ability " .. i,
        rarity = i % 5 == 0 and "Legendary" or (i % 3 == 0 and "Rare" or (i % 2 == 0 and "Uncommon" or "Common")),
    })
end

function GachaConfig:IsValidCategory(category: string): boolean
    return self.Categories[category] ~= nil
end

function GachaConfig:ValidateSpinCount(count: number): number
    return math.clamp(tonumber(count) or 1, 1, 10)
end

return GachaConfig
