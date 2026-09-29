-- ✅ High confidence: ox_fuel doesn't maintain its own fuel state, it uses
-- GTA's native vehicle fuel level directly, so the bridge talks to the
-- native rather than an export.
if GetResourceState(Config.Resources.ox_fuel) ~= 'started' then return end

Nx.Fuels.ox_fuel = {
    GetFuel = function(vehicle)
        return GetVehicleFuelLevel(vehicle)
    end,

    SetFuel = function(vehicle, amount)
        SetVehicleFuelLevel(vehicle, amount + 0.0)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 fuel (client) registered: ^3ox_fuel^7') end
