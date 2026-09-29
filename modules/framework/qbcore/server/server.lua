if GetResourceState(Config.Resources.qbcore) ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()

Nx.Frameworks.qbcore = Nx.Frameworks.qbcore or {}

Nx.Frameworks.qbcore.GetPlayer = function(src)
    return QBCore.Functions.GetPlayer(src)
end

Nx.Frameworks.qbcore.GetPlayerIdentifier = function(src)
    local Player = QBCore.Functions.GetPlayer(src)
    return Player and Player.PlayerData.citizenid or nil
end

Nx.Frameworks.qbcore.GetMoney = function(src, moneyType)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return 0 end
    return Player.PlayerData.money[moneyType or 'cash'] or 0
end

Nx.Frameworks.qbcore.AddMoney = function(src, moneyType, amount)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    return Player.Functions.AddMoney(moneyType or 'cash', amount)
end

Nx.Frameworks.qbcore.RemoveMoney = function(src, moneyType, amount)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    return Player.Functions.RemoveMoney(moneyType or 'cash', amount)
end

Nx.Frameworks.qbcore.GetJob = function(src)
    local Player = QBCore.Functions.GetPlayer(src)
    return Player and Player.PlayerData.job or nil
end

if Config.Debug then print('^2[nx_bridge]^7 framework (server) registered: ^3qbcore^7') end
