if GetResourceState(Config.Resources['qb-notify']) ~= 'started' then return end

Nx.Notifies['qb-notify'] = Nx.Notifies['qb-notify'] or {}

-- Notify(src, msg, msgType, duration) -- shows a notification on a specific player's client
Nx.Notifies['qb-notify'].Notify = function(src, msg, msgType, duration)
    TriggerClientEvent('QBCore:Notify', src, msg, msgType, duration)
end

if Config.Debug then print('^2[nx_bridge]^7 notify (server) registered: ^3qb-notify^7') end
