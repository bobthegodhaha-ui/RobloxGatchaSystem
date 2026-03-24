-- GachaService ModuleScript
local GachaConfig = require(game:GetService("ServerStorage"):WaitForChild("Modules"):WaitForChild("GachaConfig"))
local GachaService = {}

math.randomseed(tick())

function GachaService.SingleSpin(category: string): table
    assert(GachaConfig:IsValidCategory(category), "Invalid category: " .. tostring(category))
    
    local pool = GachaConfig.ItemPools[category]
    local randomIndex = math.random(1, #pool)
    local item = pool[randomIndex]
    
    return {
        id = item.id,
        name = item.name,
        rarity = item.rarity,
        timestamp = tick(),
    }
end

function GachaService.MultiSpin(category: string, count: number): table
    assert(GachaConfig:IsValidCategory(category), "Invalid category: " .. tostring(category))
    
    local validCount = GachaConfig:ValidateSpinCount(count)
    local pool = GachaConfig.ItemPools[category]
    local results = {}
    
    for i = 1, validCount do
        local randomIndex = math.random(1, #pool)
        local item = pool[randomIndex]
        
        table.insert(results, {
            id = item.id,
            name = item.name,
            rarity = item.rarity,
            timestamp = tick(),
        })
    end
    
    return results
end

function GachaService.GetPoolStats(category: string): table
    assert(GachaConfig:IsValidCategory(category), "Invalid category: " .. tostring(category))
    
    local pool = GachaConfig.ItemPools[category]
    local stats = {
        totalItems = #pool,
        rarityBreakdown = {},
    }
    
    for _, item in ipairs(pool) do
        stats.rarityBreakdown[item.rarity] = (stats.rarityBreakdown[item.rarity] or 0) + 1
    end
    
    return stats
end

return GachaService
