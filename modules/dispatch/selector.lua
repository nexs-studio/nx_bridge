-- Picks whichever dispatch adapter registered on the server
-- and exposes it as Nx.Dispatch / Nx.DispatchName.
CreateThread(function()
    Wait(0)

    if Config.Dispatch == 'none' then
        if Config.Debug then print('^3[nx_bridge]^7 Dispatch system disabled via config') end
        return
    end

    local selected = Config.Dispatch

    if selected == 'auto' then
        selected = nil
        for name in pairs(Nx.Dispatches) do
            selected = name
            break
        end
    end

    Nx.Dispatch = selected and Nx.Dispatches[selected] or nil
    Nx.DispatchName = Nx.Dispatch and selected or nil

    if Config.Debug then
        if Nx.Dispatch then
            print(('^2[nx_bridge]^7 Active dispatch system: ^3%s^7'):format(Nx.DispatchName))
        else
            print('^3[nx_bridge]^7 No dispatch system detected (optional, skipping)')
        end
    end
end)
