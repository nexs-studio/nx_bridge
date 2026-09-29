-- ⚠ VERIFY: moderate confidence -- follows the GetFuel/SetFuel convention
-- shared by nearly every fuel script in the ecosystem, but not confirmed
-- against rcore_fuel's own source.
if GetResourceState(Config.Resources['rcore_fuel']) ~= 'started' then return end

Nx.Fuels['rcore_fuel'] = {
    GetFuel = function(vehicle)
        return exports['rcore_fuel']:GetFuel(vehicle)
    end,

    SetFuel = function(vehicle, amount)
        exports['rcore_fuel']:SetFuel(vehicle, amount)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 fuel (client) registered: ^3rcore_fuel^7 (⚠ unverified, check your version)') end
