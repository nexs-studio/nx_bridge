-- ⚠ VERIFY: qb-clothing forks vary a lot between server installs. This uses
-- the most commonly seen event names for this resource, but check your
-- specific version's client files before relying on this in production.
if GetResourceState(Config.Resources['qb-clothing']) ~= 'started' then return end

Nx.Appearances['qb-clothing'] = {
    GetAppearance = function()
        return LocalPlayer.state.skin
    end,

    SetAppearance = function(data)
        TriggerEvent('qb-clothing:client:loadOutfit', data)
    end,

    OpenMenu = function()
        TriggerEvent('qb-clothing:client:openMenu')
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 appearance (client) registered: ^3qb-clothing^7 (⚠ unverified, check your version)') end
