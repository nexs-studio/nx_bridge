-- ⚠ VERIFY: moderate confidence on exact export names -- confirm against
-- your installed version before relying on this.
if GetResourceState(Config.Resources['wasabi_carlock']) ~= 'started' then return end

Nx.VehicleKeySystems['wasabi_carlock'] = {
    GiveKeys = function(vehicle)
        local plate = GetVehicleNumberPlateText(vehicle)
        exports['wasabi_carlock']:GiveKey(plate)
    end,

    HasKeys = function(vehicle)
        local plate = GetVehicleNumberPlateText(vehicle)
        return exports['wasabi_carlock']:HasKey(plate)
    end,

    RemoveKeys = function(vehicle)
        local plate = GetVehicleNumberPlateText(vehicle)
        exports['wasabi_carlock']:RemoveKey(plate)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 vehiclekeys (client) registered: ^3wasabi_carlock^7 (⚠ unverified, check your version)') end
