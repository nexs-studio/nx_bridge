-- ⚠ VERIFY: moderate confidence -- follows the GetFuel/SetFuel convention
-- shared by nearly every fuel script in the ecosystem, but not confirmed
-- against lc_fuel's own source.
if GetResourceState(Config.Resources['lc_fuel']) ~= 'started' then return end

Nx.Fuels['lc_fuel'] = {
    GetFuel = function(vehicle)
        return exports['lc_fuel']:GetFuel(vehicle)
    end,

    SetFuel = function(vehicle, amount)
        exports['lc_fuel']:SetFuel(vehicle, amount)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 fuel (client) registered: ^3lc_fuel^7 (⚠ unverified, check your version)') end
