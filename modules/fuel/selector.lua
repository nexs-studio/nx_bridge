-- Picks whichever fuel adapter registered on the client
-- and exposes it as Nx.Fuel / Nx.FuelName.
CreateThread(function()
    Wait(0)

    if Config.Fuel == 'none' then
        if Config.Debug then print('^3[nx_bridge]^7 Fuel system disabled via config') end
        return
    end

    local selected = Config.Fuel

    if selected == 'auto' then
        selected = nil
        for name in pairs(Nx.Fuels) do
            selected = name
            break
        end
    end

    Nx.Fuel = selected and Nx.Fuels[selected] or nil
    Nx.FuelName = Nx.Fuel and selected or nil

    if Config.Debug then
        if Nx.Fuel then
            print(('^2[nx_bridge]^7 Active fuel system: ^3%s^7'):format(Nx.FuelName))
        else
            print('^3[nx_bridge]^7 No fuel system detected (optional, skipping)')
        end
    end
end)
