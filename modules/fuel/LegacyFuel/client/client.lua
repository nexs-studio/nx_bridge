-- ✅ Documented API
if GetResourceState(Config.Resources.LegacyFuel) ~= 'started' then return end

Nx.Fuels.LegacyFuel = {
    GetFuel = function(vehicle)
        return exports['LegacyFuel']:GetFuel(vehicle)
    end,

    SetFuel = function(vehicle, amount)
        exports['LegacyFuel']:SetFuel(vehicle, amount)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 fuel (client) registered: ^3LegacyFuel^7') end
