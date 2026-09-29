-- Picks whichever inventory adapter registered on the server
-- and exposes it as Nx.Inventory / Nx.InventoryName.
CreateThread(function()
    Wait(0)

    local selected = Config.Inventory

    if selected == 'auto' then
        selected = nil
        for name in pairs(Nx.Inventories) do
            selected = name
            break
        end
    end

    Nx.Inventory = selected and Nx.Inventories[selected] or nil
    Nx.InventoryName = Nx.Inventory and selected or nil

    if Config.Debug then
        if Nx.Inventory then
            print(('^2[nx_bridge]^7 Active inventory: ^3%s^7'):format(Nx.InventoryName))
        else
            print('^3[nx_bridge]^7 No supported inventory detected (optional, skipping)')
        end
    end
end)
