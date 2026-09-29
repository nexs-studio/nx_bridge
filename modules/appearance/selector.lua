-- Picks whichever appearance adapter registered on the client
-- and exposes it as Nx.Appearance / Nx.AppearanceName.
CreateThread(function()
    Wait(0)

    if Config.Appearance == 'none' then
        if Config.Debug then print('^3[nx_bridge]^7 Appearance system disabled via config') end
        return
    end

    local selected = Config.Appearance

    if selected == 'auto' then
        selected = nil
        for name in pairs(Nx.Appearances) do
            selected = name
            break
        end
    end

    Nx.Appearance = selected and Nx.Appearances[selected] or nil
    Nx.AppearanceName = Nx.Appearance and selected or nil

    if Config.Debug then
        if Nx.Appearance then
            print(('^2[nx_bridge]^7 Active appearance system: ^3%s^7'):format(Nx.AppearanceName))
        else
            print('^3[nx_bridge]^7 No appearance system detected (optional, skipping)')
        end
    end
end)
