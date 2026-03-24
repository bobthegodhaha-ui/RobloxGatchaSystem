-- GachaClient LocalScript
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local GachaRemote = ReplicatedStorage:WaitForChild("GachaSpin")

local lastSpinResults = nil

local function RequestSpin(category: string, spinCount: number)
    local success, response = pcall(function()
        return GachaRemote:InvokeServer(category, spinCount)
    end)
    
    if not success then
        warn("[Gacha] Network error:", response)
        return nil
    end
    
    if response.success then
        lastSpinResults = response.results
        print("[Gacha] Spin successful!")
        for _, item in ipairs(response.results) do
            print(string.format("  • %s (%s) [%s]", item.name, item.rarity, item.id))
        end
        return response.results
    else
        warn("[Gacha] Spin failed:", response.error, "(" .. response.code .. ")")
        return nil
    end
end

_G.GachaAPI = {
    Spin = function(category: string, spinCount: number)
        return RequestSpin(category, spinCount or 1)
    end,
    
    GetLastResults = function()
        return lastSpinResults
    end,
}

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.E then
        print("Spinning Balls category (1 spin)...")
        RequestSpin("Balls", 1)
    end
    
    if input.KeyCode == Enum.KeyCode.R then
        print("Spinning Abilities category (5 spins)...")
        RequestSpin("Abilities", 5)
    end
end)

print("[GachaClient] Gacha client loaded! Press E for Balls, R for Abilities")
