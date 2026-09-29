if GetResourceState(Config.Resources.qbox) ~= 'started' then return end

Nx.Frameworks.qbox = Nx.Frameworks.qbox or {}

Nx.Frameworks.qbox.GetPlayer = function(src)
    return exports.qbx_core:GetPlayer(src)
end

Nx.Frameworks.qbox.GetPlayerIdentifier = function(src)
    local Player = exports.qbx_core:GetPlayer(src)
    return Player and Player.PlayerData.citizenid or nil
end

Nx.Frameworks.qbox.GetMoney = function(src, moneyType)
    local Player = exports.qbx_core:GetPlayer(src)
    if not Player then return 0 end
    return Player.PlayerData.money[moneyType or 'cash'] or 0
end

Nx.Frameworks.qbox.AddMoney = function(src, moneyType, amount)
    local Player = exports.qbx_core:GetPlayer(src)
    if not Player then return false end
    return Player.Functions.AddMoney(moneyType or 'cash', amount)
end

Nx.Frameworks.qbox.RemoveMoney = function(src, moneyType, amount)
    local Player = exports.qbx_core:GetPlayer(src)
    if not Player then return false end
    return Player.Functions.RemoveMoney(moneyType or 'cash', amount)
end

Nx.Frameworks.qbox.GetJob = function(src)
    local Player = exports.qbx_core:GetPlayer(src)
    return Player and Player.PlayerData.job or nil
end

if Config.Debug then print('^2[nx_bridge]^7 framework (server) registered: ^3qbox^7') end
