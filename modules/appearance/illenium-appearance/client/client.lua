-- ✅ Documented API (fork of fivem-appearance, same export shape)
if GetResourceState(Config.Resources['illenium-appearance']) ~= 'started' then return end

Nx.Appearances['illenium-appearance'] = {
    GetAppearance = function()
        return exports['illenium-appearance']:getPlayerAppearance()
    end,

    SetAppearance = function(data)
        exports['illenium-appearance']:setPlayerAppearance(data)
    end,

    OpenMenu = function(onDone, options)
        exports['illenium-appearance']:startPlayerCustomization(onDone, options or {})
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 appearance (client) registered: ^3illenium-appearance^7') end
