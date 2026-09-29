-- Picks whichever vehiclekeys adapter registered on the client
-- and exposes it as Nx.VehicleKeys / Nx.VehicleKeysName.
-- Registry of all adapters lives in Nx.VehicleKeySystems (see config.lua);
-- this file narrows that down to the one active adapter.
CreateThread(function()
    Wait(0)

    if Config.VehicleKeys == 'none' then
        if Config.Debug then print('^3[nx_bridge]^7 Vehicle keys system disabled via config') end
        return
    end

    local selected = Config.VehicleKeys

    if selected == 'auto' then
        selected = nil
        for name in pairs(Nx.VehicleKeySystems) do
            selected = name
            break
        end
    end

    Nx.VehicleKeys = selected and Nx.VehicleKeySystems[selected] or nil
    Nx.VehicleKeysName = Nx.VehicleKeys and selected or nil

    if Config.Debug then
        if Nx.VehicleKeys then
            print(('^2[nx_bridge]^7 Active vehicle keys system: ^3%s^7'):format(Nx.VehicleKeysName))
        else
            print('^3[nx_bridge]^7 No vehicle keys system detected (optional, skipping)')
        end
    end
end)
