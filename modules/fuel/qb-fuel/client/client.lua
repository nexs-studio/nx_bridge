-- ✅ Documented API
if GetResourceState(Config.Resources['qb-fuel']) ~= 'started' then return end

Nx.Fuels['qb-fuel'] = {
    GetFuel = function(vehicle)
        return exports['qb-fuel']:GetFuel(vehicle)
    end,

    SetFuel = function(vehicle, amount)
        exports['qb-fuel']:SetFuel(vehicle, amount)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 fuel (client) registered: ^3qb-fuel^7') end
