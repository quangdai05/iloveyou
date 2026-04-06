local KeySystem = {}

KeySystem.Keys = {
    ["DAI-7D"] = {duration = 7*24*60*60},
    ["DAI-30D"] = {duration = 30*24*60*60},
    ["quangdai"] = {type = "lifetime"}
}

KeySystem.PlayerData = {}

function KeySystem:Validate(player, key)
    local info = self.Keys[key]
    if not info then return false end

    if info.type == "lifetime" then return true end

    self.PlayerData[player.UserId] = self.PlayerData[player.UserId] or {}
    local pdata = self.PlayerData[player.UserId]

    if not pdata[key] then
        pdata[key] = os.time()
    end

    return os.time() <= (pdata[key] + info.duration)
end

return KeySystem
