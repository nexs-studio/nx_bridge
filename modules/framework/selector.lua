-- Picks whichever framework adapter registered on this side
-- and exposes it as Nx.Framework / Nx.FrameworkName.
-- Runs once on the client (using client-registered adapters)
-- and once on the server (using server-registered adapters).
CreateThread(function()
    Wait(0) -- let core-object exports (qb-core, qbx_core, es_extended) finish booting

    local selected = Config.Framework

    if selected == 'auto' then
        for name in pairs(Nx.Frameworks) do
            selected = name
            break
        end
    end

    Nx.Framework = Nx.Frameworks[selected]
    Nx.FrameworkName = Nx.Framework and selected or nil

    if not Nx.Framework then
        print('^1[nx_bridge]^7 No supported framework found. Check Config.Framework and make sure qb-core / qbx_core / es_extended starts BEFORE this resource.')
        return
    end

    if Config.Debug then
        print(('^2[nx_bridge]^7 Active framework (%s): ^3%s^7')
            :format(IsDuplicityVersion() and 'server' or 'client', Nx.FrameworkName))
    end

    TriggerEvent('nx_bridge:frameworkReady', Nx.FrameworkName)
end)
