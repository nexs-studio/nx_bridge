-- ⚠ VERIFY: moderate confidence -- follows the GetFuel/SetFuel convention
-- shared by nearly every fuel script in the ecosystem, but not confirmed
-- against Renewed-Fuel's own source.
if GetResourceState(Config.Resources['Renewed-Fuel']) ~= 'started' then return end

Nx.Fuels['Renewed-Fuel'] = {
    GetFuel = function(vehicle)
        return exports['Renewed-Fuel']:GetFuel(vehicle)
    end,

    SetFuel = function(vehicle, amount)
        exports['Renewed-Fuel']:SetFuel(vehicle, amount)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 fuel (client) registered: ^3Renewed-Fuel^7 (⚠ unverified, check your version)') end
