if GetResourceState(Config.Resources['qb-inventory']) ~= 'started' then return end

Nx.Inventories['qb-inventory'] = Nx.Inventories['qb-inventory'] or {}
local qb = Nx.Inventories['qb-inventory']

-- ═══════════════════════════════════════════════════════
--  CORE ITEM MANAGEMENT
--  All of these ARE real qb-inventory exports.
-- ═══════════════════════════════════════════════════════
qb.AddItem = function(src, item, amount, slot, metadata)
    return exports['qb-inventory']:AddItem(src, item, amount, slot, metadata)
end

qb.RemoveItem = function(src, item, amount, slot)
    return exports['qb-inventory']:RemoveItem(src, item, amount, slot)
end

qb.HasItem = function(src, item, amount)
    return exports['qb-inventory']:HasItem(src, item, amount or 1)
end

qb.GetItemCount = function(src, item)
    local Player = Nx.Framework and Nx.Framework.GetPlayer(src)
    if not Player then return 0 end
    local itemData = Player.Functions.GetItemByName(item)
    return itemData and itemData.amount or 0
end

qb.GetItemBySlot = function(src, slot)
    return exports['qb-inventory']:GetItemBySlot(src, slot)
end

qb.GetItemByName = function(src, item)
    return exports['qb-inventory']:GetItemByName(src, item)
end

qb.GetItemsByName = function(src, item)
    return exports['qb-inventory']:GetItemsByName(src, item)
end

qb.ClearInventory = function(src, filterItems)
    return exports['qb-inventory']:ClearInventory(src, filterItems)
end

qb.SetInventory = function(src, items)
    return exports['qb-inventory']:SetInventory(src, items)
end

qb.SetItemData = function(src, item, key, val)
    return exports['qb-inventory']:SetItemData(src, item, key, val)
end

qb.GetTotalWeight = function(items)
    return exports['qb-inventory']:GetTotalWeight(items)
end

qb.GetSlotsByItem = function(items, item)
    return exports['qb-inventory']:GetSlotsByItem(items, item)
end

qb.GetFirstSlotByItem = function(items, item)
    return exports['qb-inventory']:GetFirstSlotByItem(items, item)
end

qb.LoadInventory = function(src, citizenid)
    return exports['qb-inventory']:LoadInventory(src, citizenid)
end

qb.SaveInventory = function(src, offline)
    return exports['qb-inventory']:SaveInventory(src, offline)
end

-- ═══════════════════════════════════════════════════════
--  USABLE ITEMS
-- ═══════════════════════════════════════════════════════
qb.CreateUsableItem = function(item, data)
    return exports['qb-inventory']:CreateUsableItem(item, data)
end

qb.GetUsableItem = function(item)
    return exports['qb-inventory']:GetUsableItem(item)
end

qb.UseItem = function(item, ...)
    return exports['qb-inventory']:UseItem(item, ...)
end

-- ═══════════════════════════════════════════════════════
--  STASHES
--  GetStashItems/SaveStashItems are NOT exported by qb-inventory --
--  they're plain globals, invisible outside its own resource. The only
--  way in is through its network events and DB tables, so that's what
--  we use here.
-- ═══════════════════════════════════════════════════════
qb.Stash = {}

-- 'qb-inventory:server:SaveStashItems' has no `source` dependency in its
-- handler body, so it's safe to fire from another resource at any time.
qb.Stash.SaveItems = function(stashId, items)
    TriggerEvent('qb-inventory:server:SaveStashItems', stashId, items)
end

-- Read-only. Mirrors qb-inventory's own GetStashItems() DB lookup
-- (stashitems / otherstashitems / evidencebox depending on stash id prefix)
-- since that function itself is internal-only.
qb.Stash.GetItems = function(stashId)
    local table_ = 'stashitems'
    if stashId:find('Backpack_') then
        table_ = 'otherstashitems'
    elseif stashId:find('Evidence_Box') then
        table_ = 'evidencebox'
    end

    local result = MySQL.scalar.await(('SELECT items FROM %s WHERE stash = ?'):format(table_), { stashId })
    if not result then return {} end

    return json.decode(result) or {}
end

-- ═══════════════════════════════════════════════════════
--  TRUNKS
-- ═══════════════════════════════════════════════════════
qb.Trunk = {}

-- 'inventory:server:addTrunkItems' just overwrites the live Trunks[plate]
-- cache with no `source` dependency -- perfect for seeding a vehicle with
-- loot when it's spawned (vehicle shops, delivery jobs, etc). Note this
-- only touches the runtime cache, NOT the database, until a player
-- actually opens/closes that trunk in-game.
qb.Trunk.Seed = function(plate, items)
    TriggerEvent('inventory:server:addTrunkItems', plate, items)
end

-- Read-only. Mirrors qb-inventory's GetOwnedVehicleItems() DB lookup.
qb.Trunk.GetItems = function(plate)
    local result = MySQL.scalar.await('SELECT items FROM trunkitems WHERE plate = ?', { plate })
    if not result then return {} end
    return json.decode(result) or {}
end

-- ═══════════════════════════════════════════════════════
--  GLOVEBOXES
-- ═══════════════════════════════════════════════════════
qb.Glovebox = {}

-- Read-only. Mirrors qb-inventory's GetOwnedVehicleGloveboxItems() DB lookup.
-- Unlike trunks, qb-inventory has no source-independent "seed" event for
-- gloveboxes, so writing to one has to go through a player opening it
-- in-game (see qb.OpenGlovebox on the client side).
qb.Glovebox.GetItems = function(plate)
    local result = MySQL.scalar.await('SELECT items FROM gloveboxitems WHERE plate = ?', { plate })
    if not result then return {} end
    return json.decode(result) or {}
end

if Config.Debug then print('^2[nx_bridge]^7 inventory (server) registered: ^3qb-inventory^7') end
