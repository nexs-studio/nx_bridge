CreateThread(function()
    while not Nx.Framework do
        Wait(100)
    end

    if Config.Debug then
        print(('^2[nx_bridge]^7 Server ready -- framework: ^3%s^7 | inventory: ^3%s^7')
            :format(tostring(Nx.FrameworkName), tostring(Nx.InventoryName)))
    end
end)
