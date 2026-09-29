-- ⚠ UNVERIFIED: low confidence on this resource's exact API. This is a
-- best-effort placeholder -- please confirm the real event/export name in
-- 17mov_phone's own source before relying on this.
if GetResourceState(Config.Resources['17mov_phone']) ~= 'started' then return end

Nx.Phones['17mov_phone'] = {
    -- data = { app, title, message, icon }
    SendNotification = function(src, data)
        TriggerClientEvent('17mov_phone:client:notify', src, {
            app = data.app or 'messages',
            title = data.title,
            message = data.message,
            icon = data.icon,
        })
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 phone (server) registered: ^317mov_phone^7 (⚠ UNVERIFIED API, please confirm)') end
