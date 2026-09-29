-- ⚠ VERIFY: moderate confidence -- follows the GiveKeys/HasKeys convention
-- shared by most standalone vehiclekeys scripts, but not confirmed against
-- Renewed-Vehiclekeys' own source.
if GetResourceState(Config.Resources['Renewed-Vehiclekeys']) ~= 'started' then return end

Nx.VehicleKeySystems['Renewed-Vehiclekeys'] = {
    GiveKeys = function(vehicle)
        exports['Renewed-Vehiclekeys']:GiveKeys(vehicle)
    end,

    HasKeys = function(vehicle)
        return exports['Renewed-Vehiclekeys']:HasKeys(vehicle)
    end,

    RemoveKeys = function(vehicle)
        exports['Renewed-Vehiclekeys']:RemoveKeys(vehicle)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 vehiclekeys (client) registered: ^3Renewed-Vehiclekeys^7 (⚠ unverified, check your version)') end
