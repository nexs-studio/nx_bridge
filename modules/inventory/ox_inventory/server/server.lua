if GetResourceState(Config.Resources['ox_inventory']) ~= 'started' then return end

Nx.Inventories['ox_inventory'] = {
    AddItem = function(src, item, amount, metadata)
        return exports.ox_inventory:AddItem(src, item, amount, metadata)
    end,

    RemoveItem = function(src, item, amount, metadata)
        return exports.ox_inventory:RemoveItem(src, item, amount, metadata)
    end,

    HasItem = function(src, item, amount)
        local count = exports.ox_inventory:GetItemCount(src, item)
        return count >= (amount or 1)
    end,

    GetItemCount = function(src, item)
        return exports.ox_inventory:GetItemCount(src, item)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 inventory (server) registered: ^3ox_inventory^7') end
