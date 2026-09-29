if GetResourceState(Config.Resources['qb-notify']) ~= 'started' then return end

Nx.Notifies['qb-notify'] = Nx.Notifies['qb-notify'] or {}

-- Notify(msg, msgType, duration) -- shows a notification to THIS client
Nx.Notifies['qb-notify'].Notify = function(msg, msgType, duration)
    if Nx.Framework and Nx.Framework.Notify then
        Nx.Framework.Notify(msg, msgType, duration)
    end
end

if Config.Debug then print('^2[nx_bridge]^7 notify (client) registered: ^3qb-notify^7') end
