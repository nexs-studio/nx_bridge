-- Picks whichever notify adapter registered on this side
-- and exposes it as Nx.Notify / Nx.NotifyName.
-- Falls back to the framework's own Notify() if none is selected.
CreateThread(function()
    Wait(0)

    local selected = Config.Notify

    if selected == 'auto' then
        selected = nil
        for name in pairs(Nx.Notifies) do
            selected = name
            break
        end
    end

    Nx.Notify = selected and Nx.Notifies[selected] or nil
    Nx.NotifyName = Nx.Notify and selected or nil

    if Config.Debug then
        if Nx.Notify then
            print(('^2[nx_bridge]^7 Active notify (%s): ^3%s^7')
                :format(IsDuplicityVersion() and 'server' or 'client', Nx.NotifyName))
        else
            print('^3[nx_bridge]^7 No dedicated notify system selected for this side, falling back to framework Notify() where available')
        end
    end
end)
