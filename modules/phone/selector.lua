-- Picks whichever phone adapter registered on the server
-- and exposes it as Nx.Phone / Nx.PhoneName.
CreateThread(function()
    Wait(0)

    if Config.Phone == 'none' then
        if Config.Debug then print('^3[nx_bridge]^7 Phone system disabled via config') end
        return
    end

    local selected = Config.Phone

    if selected == 'auto' then
        selected = nil
        for name in pairs(Nx.Phones) do
            selected = name
            break
        end
    end

    Nx.Phone = selected and Nx.Phones[selected] or nil
    Nx.PhoneName = Nx.Phone and selected or nil

    if Config.Debug then
        if Nx.Phone then
            print(('^2[nx_bridge]^7 Active phone system: ^3%s^7'):format(Nx.PhoneName))
        else
            print('^3[nx_bridge]^7 No phone system detected (optional, skipping)')
        end
    end
end)
