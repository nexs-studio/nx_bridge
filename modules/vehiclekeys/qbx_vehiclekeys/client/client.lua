-- ✅ Documented API (Qbox generally favors clean exports over legacy events)
if GetResourceState(Config.Resources['qbx_vehiclekeys']) ~= 'started' then return end

Nx.VehicleKeySystems['qbx_vehiclekeys'] = {
    GiveKeys = function(vehicle)
        exports.qbx_vehiclekeys:GiveKeys(vehicle)
    end,

    HasKeys = function(vehicle)
        return exports.qbx_vehiclekeys:HasKeys(vehicle)
    end,

    RemoveKeys = function(vehicle)
        exports.qbx_vehiclekeys:RemoveKeys(vehicle)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 vehiclekeys (client) registered: ^3qbx_vehiclekeys^7') end
