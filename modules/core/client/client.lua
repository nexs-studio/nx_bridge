CreateThread(function()
    while not Nx.Framework do
        Wait(100)
    end

    if Config.Debug then
        print(('^2[nx_bridge]^7 Client ready -- framework: ^3%s^7 | target: ^3%s^7 | notify: ^3%s^7')
            :format(tostring(Nx.FrameworkName), tostring(Nx.TargetName), tostring(Nx.NotifyName)))
    end
end)
