-- ⚠ VERIFY: npwd's exact export/field names have shifted across versions.
-- This uses the most commonly referenced pattern from its notification
-- module -- confirm against your installed version before relying on this.
if GetResourceState(Config.Resources.npwd) ~= 'started' then return end

Nx.Phones.npwd = {
    -- data = { app, title, message, icon }
    SendNotification = function(src, data)
        exports['npwd']:createNotification(src, {
            app = data.app or 'sms',
            content = data.message,
            title = data.title,
            icon = data.icon,
        })
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 phone (server) registered: ^3npwd^7 (⚠ unverified, check your version)') end
