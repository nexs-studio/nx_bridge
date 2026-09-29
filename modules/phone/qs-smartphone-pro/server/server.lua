-- ⚠ VERIFY: moderate confidence, follows Quasar's qs-* export convention
-- (consistent with qs-dispatch's CustomAlert) but not confirmed against
-- source. Check your installed version before relying on this.
if GetResourceState(Config.Resources['qs-smartphone-pro']) ~= 'started' then return end

Nx.Phones['qs-smartphone-pro'] = {
    -- data = { app, title, message, icon }
    SendNotification = function(src, data)
        exports['qs-smartphone-pro']:sendNotify(src, {
            app = data.app or 'messages',
            title = data.title,
            message = data.message,
            icon = data.icon,
        })
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 phone (server) registered: ^3qs-smartphone-pro^7 (⚠ unverified, check your version)') end
