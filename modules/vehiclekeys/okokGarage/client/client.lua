-- ⚠ UNVERIFIED: low confidence. okokGarage is primarily a garage/storage
-- system -- its key-giving behaviour is usually bundled into vehicle
-- retrieval rather than exposed as a standalone export. Please confirm
-- against your installed version before relying on this.
if GetResourceState(Config.Resources.okokGarage) ~= 'started' then return end

Nx.VehicleKeySystems.okokGarage = {
    GiveKeys = function(vehicle)
        local plate = GetVehicleNumberPlateText(vehicle)
        exports['okokGarage']:GiveKey(plate)
    end,

    HasKeys = function(vehicle)
        local plate = GetVehicleNumberPlateText(vehicle)
        return exports['okokGarage']:HasKey(plate)
    end,

    RemoveKeys = function(vehicle)
        local plate = GetVehicleNumberPlateText(vehicle)
        exports['okokGarage']:RemoveKey(plate)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 vehiclekeys (client) registered: ^3okokGarage^7 (⚠ UNVERIFIED API, please confirm)') end
