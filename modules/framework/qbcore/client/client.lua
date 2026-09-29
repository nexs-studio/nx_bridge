if GetResourceState(Config.Resources.qbcore) ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()

Nx.Frameworks.qbcore = Nx.Frameworks.qbcore or {}

Nx.Frameworks.qbcore.GetPlayerData = function()
    return QBCore.Functions.GetPlayerData()
end

Nx.Frameworks.qbcore.Notify = function(msg, msgType, duration)
    QBCore.Functions.Notify(msg, msgType, duration)
end

if Config.Debug then print('^2[nx_bridge]^7 framework (client) registered: ^3qbcore^7') end
