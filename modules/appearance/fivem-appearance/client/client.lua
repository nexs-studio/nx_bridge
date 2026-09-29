-- ✅ Documented API
if GetResourceState(Config.Resources['fivem-appearance']) ~= 'started' then return end

Nx.Appearances['fivem-appearance'] = {
    GetAppearance = function()
        return exports['fivem-appearance']:getPlayerAppearance()
    end,

    SetAppearance = function(data)
        exports['fivem-appearance']:setPlayerAppearance(data)
    end,

    OpenMenu = function(onDone, options)
        exports['fivem-appearance']:startPlayerCustomization(onDone, {}, options or {})
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 appearance (client) registered: ^3fivem-appearance^7') end
