-- ⚠ UNVERIFIED: low confidence. cd_garage is primarily a garage/storage
-- system -- its key-giving behaviour is usually bundled into vehicle
-- retrieval rather than exposed as a standalone export. Please confirm
-- against your installed version before relying on this.
if GetResourceState(Config.Resources.cd_garage) ~= 'started' then return end

Nx.VehicleKeySystems.cd_garage = {
    GiveKeys = function(vehicle)
        local plate = GetVehicleNumberPlateText(vehicle)
        exports['cd_garage']:GiveKey(plate)
    end,

    HasKeys = function(vehicle)
        local plate = GetVehicleNumberPlateText(vehicle)
        return exports['cd_garage']:HasKey(plate)
    end,

    RemoveKeys = function(vehicle)
        local plate = GetVehicleNumberPlateText(vehicle)
        exports['cd_garage']:RemoveKey(plate)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 vehiclekeys (client) registered: ^3cd_garage^7 (⚠ UNVERIFIED API, please confirm)') end
