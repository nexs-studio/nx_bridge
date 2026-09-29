-- ⚠ VERIFY: moderate confidence -- follows the GetFuel/SetFuel convention
-- shared by nearly every fuel script in the ecosystem, but not confirmed
-- against cdn-fuel's own source. Check the exact resource name casing too.
if GetResourceState(Config.Resources['cdn-fuel']) ~= 'started' then return end

Nx.Fuels['cdn-fuel'] = {
    GetFuel = function(vehicle)
        return exports['cdn-fuel']:GetFuel(vehicle)
    end,

    SetFuel = function(vehicle, amount)
        exports['cdn-fuel']:SetFuel(vehicle, amount)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 fuel (client) registered: ^3cdn-fuel^7 (⚠ unverified, check your version)') end
