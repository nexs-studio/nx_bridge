-- ✅ Documented API (this event name lineage is shared by nearly every
-- QB-derived vehiclekeys fork, since they all trace back to the same origin)
if GetResourceState(Config.Resources['qb-vehiclekeys']) ~= 'started' then return end

Nx.VehicleKeySystems['qb-vehiclekeys'] = {
    GiveKeys = function(vehicle)
        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent('vehiclekeys:client:SetOwner', plate)
    end,

    HasKeys = function(vehicle)
        return exports['qb-vehiclekeys']:HasKeys(vehicle)
    end,

    RemoveKeys = function(vehicle)
        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent('vehiclekeys:client:RemoveKeys', plate)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 vehiclekeys (client) registered: ^3qb-vehiclekeys^7') end
