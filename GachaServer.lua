-- GachaServer Script
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local GachaService = require(ServerStorage:WaitForChild("Modules"):WaitForChild("GachaService"))
local GachaConfig = require(ServerStorage:WaitForChild("Modules"):WaitForChild("GachaConfig"))

local GachaRemote = Instance.new("RemoteFunction")
GachaRemote.Name = "GachaSpin"
GachaRemote.Parent = ReplicatedStorage

local spinCooldowns = {}
local COOLDOWN_SECONDS = 1

GachaRemote.OnServerInvoke = function(player: Player, category: string, spinCount: number)
    if not GachaConfig:IsValidCategory(category) then
        return {
            success = false,
            error = "Invalid category",
            code = "INVALID_CATEGORY",
        }
    end
    
    if type(spinCount) ~= "number" or spinCount < 1 then
        return {
            success = false,
            error = "Invalid spin count",
            code = "INVALID_COUNT",
        }
    end
    
    local lastSpin = spinCooldowns[player.UserId]
    if lastSpin and (tick() - lastSpin) < COOLDOWN_SECONDS then
        return {
            success = false,
            error = "Cooldown active. Please wait before spinning again.",
            code = "COOLDOWN",
            remainingWait = math.ceil(COOLDOWN_SECONDS - (tick() - lastSpin)),
        }
    end
    
    local results = GachaService.MultiSpin(category, spinCount)
    spinCooldowns[player.UserId] = tick()
    
    return {
        success = true,
        results = results,
        category = category,
        totalSpins = spinCount,
    }
end

print("[GachaServer] Gacha system loaded and ready!")
