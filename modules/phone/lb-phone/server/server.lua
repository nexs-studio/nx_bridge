-- ✅ Documented API
if GetResourceState(Config.Resources['lb-phone']) ~= 'started' then return end

Nx.Phones['lb-phone'] = {
    -- data = { app, title, message, icon }
    SendNotification = function(src, data)
        exports['lb-phone']:SendNotification({
            playerId = src,
            app = data.app or 'messages',
            title = data.title,
            content = data.message,
            icon = data.icon,
        })
    end,

    GetEquippedPhoneNumber = function(identifier)
        exports['lb-phone']:GetEquippedPhoneNumber(identifier)
    end,

    ToggleVerified = function(plat, accountname, bool)
        exports['lb-phone']:ToggleVerified(plat, accountname, bool)
    end,

    EmergencyNotification = function(src, data)
        exports['lb-phone']:EmergencyNotification(src, {
            title = data.title,
            content = data.message,
            icon = data.icon,
        })
    end,

-- exports["lb-phone"]:EmergencyNotification(source, {
--     title = "Emergency Alert",
--     content = "This is a test emergency alert",
--     icon = "warning",
-- })

}

if Config.Debug then print('^2[nx_bridge]^7 phone (server) registered: ^3lb-phone^7') end
