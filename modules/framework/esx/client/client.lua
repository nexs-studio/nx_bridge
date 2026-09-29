if GetResourceState(Config.Resources.esx) ~= 'started' then return end

local ESX = exports['es_extended']:getSharedObject()

Nx.Frameworks.esx = Nx.Frameworks.esx or {}

Nx.Frameworks.esx.GetPlayerData = function()
    return ESX.GetPlayerData()
end

Nx.Frameworks.esx.Notify = function(msg, msgType, duration)
    ESX.ShowNotification(msg)
end

if Config.Debug then print('^2[nx_bridge]^7 framework (client) registered: ^3esx^7') end
