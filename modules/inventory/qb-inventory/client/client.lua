if GetResourceState(Config.Resources['qb-inventory']) ~= 'started' then return end

Nx.Inventories['qb-inventory'] = Nx.Inventories['qb-inventory'] or {}
local qb = Nx.Inventories['qb-inventory']

-- ═══════════════════════════════════════════════════════
--  OPENING SECONDARY INVENTORIES
--  All of these funnel into qb-inventory's single
--  'inventory:server:OpenInventory' event. They MUST be triggered
--  client-side: qb-inventory reads `source` off that server event to know
--  which player is opening it, so it can't be faked from another server
--  resource -- only the real client who wants it open can ask for it.
-- ═══════════════════════════════════════════════════════

qb.OpenStash = function(stashId, options)
    TriggerServerEvent('inventory:server:OpenInventory', 'stash', stashId, options or {})
    TriggerEvent("inventory:client:SetCurrentStash", stashId)
end

qb.OpenTrunk = function(plate, options)
    -- qb-inventory indexes straight into options.maxweight/options.slots
    -- with no nil-check for trunks, so this table can never be nil.
    TriggerServerEvent('inventory:server:OpenInventory', 'trunk', plate, options or {})
end

qb.OpenGlovebox = function(plate, options)
    TriggerServerEvent('inventory:server:OpenInventory', 'glovebox', plate, options or {})
end

qb.OpenOtherPlayer = function(targetId)
    TriggerServerEvent('inventory:server:OpenInventory', 'otherplayer', targetId)
end

qb.OpenShop = function(shopId, shopData)
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', shopId, shopData)
end

qb.UseItemSlot = function(slot)
    TriggerServerEvent('inventory:server:UseItemSlot', slot)
end

qb.GiveItem = function(targetId, itemName, amount, slot)
    TriggerServerEvent('inventory:server:GiveItem', {
        playerId = targetId,
        name = itemName,
        amount = amount,
        slot = slot,
    })
end

-- ═══════════════════════════════════════════════════════
--  RELAY qb-inventory'S OWN CLIENT EVENTS ONTO BRIDGE-LEVEL EVENTS
--  So other resources can react to a pickup/use animation or an
--  inventory refresh without hardcoding qb-inventory's event names.
-- ═══════════════════════════════════════════════════════
RegisterNetEvent('inventory:client:ItemBox', function(itemData, type, amount)
    TriggerEvent('nx_bridge:client:itemBox', itemData, type, amount)
end)

RegisterNetEvent('inventory:client:UpdatePlayerInventory', function(reopen)
    TriggerEvent('nx_bridge:client:inventoryUpdated', reopen)
end)

if Config.Debug then print('^2[nx_bridge]^7 inventory (client) registered: ^3qb-inventory^7') end
