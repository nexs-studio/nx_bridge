-- ✅ Documented API (classic ESX callback-via-event pattern -- esx_skin
-- predates the exports() system, so it's not exports-based like the rest).
if GetResourceState(Config.Resources.esx_skin) ~= 'started' then return end

Nx.Appearances.esx_skin = {
    GetAppearance = function()
        local appearance = nil
        TriggerEvent('esx_skin:getPlayerSkin', function(skin) appearance = skin end)
        local timeout = 0
        while appearance == nil and timeout < 500 do Wait(0) timeout = timeout + 1 end
        return appearance
    end,

    SetAppearance = function(data)
        TriggerEvent('esx_skin:setPlayerSkin', data)
    end,

    OpenMenu = function(onDone)
        TriggerEvent('esx_skin:openSaveableMenu', onDone)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 appearance (client) registered: ^3esx_skin^7') end
