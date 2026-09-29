-- ⚠ UNVERIFIED: low confidence on this resource's exact API. This is a
-- best-effort placeholder -- please confirm the real event/export name in
-- gksphone's own source before relying on this.
if GetResourceState(Config.Resources.gksphone) ~= 'started' then return end

Nx.Phones.gksphone = {
    -- data = { app, title, message, icon }
    SendNotification = function(src, data)
        TriggerClientEvent('gksphone:notification', src, {
            app = data.app or 'messages',
            title = data.title,
            message = data.message,
            icon = data.icon,
        })
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 phone (server) registered: ^3gksphone^7 (⚠ UNVERIFIED API, please confirm)') end
