-- Picks whichever target adapter registered on the client
-- and exposes it as Nx.Target / Nx.TargetName. Optional -- fine if none found.
CreateThread(function()
    Wait(0)

    if Config.Target == 'none' then
        if Config.Debug then print('^3[nx_bridge]^7 Target system disabled via config') end
        return
    end

    local selected = Config.Target

    if selected == 'auto' then
        selected = nil
        for name in pairs(Nx.Targets) do
            selected = name
            break
        end
    end

    Nx.Target = selected and Nx.Targets[selected] or nil
    Nx.TargetName = Nx.Target and selected or nil

    if Config.Debug then
        if Nx.Target then
            print(('^2[nx_bridge]^7 Active target system: ^3%s^7'):format(Nx.TargetName))
        else
            print('^3[nx_bridge]^7 No target system detected (optional, skipping)')
        end
    end
end)
