-- ═══════════════════════════════════════════════════════
--  nx_bridge EXPORTS
--  Call these from any other resource:
--    exports['nx_bridge']:FunctionName(...)
--
--  Listed in both client_scripts and server_scripts in
--  fxmanifest.lua, so this same file runs once per side.
--  IsDuplicityVersion() = true on the server, false on the client.
-- ═══════════════════════════════════════════════════════

if IsDuplicityVersion() then
    -- ───────────────────────── SERVER ─────────────────────────

    exports('IsReady', function()
        return Nx.Framework ~= nil
    end)

    RegisterNetEvent('nx_bridge:server:IsReady', function()
        local src = source
        TriggerClientEvent('nx_bridge:server:IsReady:cb', src, Nx.Framework ~= nil)
    end)

    exports('WaitForBridge', function()
        while not Nx.Framework do Wait(0) end
        return true
    end)

    RegisterNetEvent('nx_bridge:server:WaitForBridge', function()
        local src = source
        while not Nx.Framework do Wait(0) end
        TriggerClientEvent('nx_bridge:server:WaitForBridge:cb', src, true)
    end)

    exports('GetFrameworkName', function()
        return Nx.FrameworkName
    end)

    RegisterNetEvent('nx_bridge:server:GetFrameworkName', function()
        local src = source
        TriggerClientEvent('nx_bridge:server:GetFrameworkName:cb', src, Nx.FrameworkName)
    end)

    exports('GetPlayer', function(src)
        return Nx.Framework and Nx.Framework.GetPlayer(src)
    end)

    RegisterNetEvent('nx_bridge:server:GetPlayer', function(targetSrc)
        local src = source
        local player = Nx.Framework and Nx.Framework.GetPlayer(targetSrc or src)
        TriggerClientEvent('nx_bridge:server:GetPlayer:cb', src, player)
    end)

    exports('GetPlayerIdentifier', function(src)
        return Nx.Framework and Nx.Framework.GetPlayerIdentifier(src)
    end)

    RegisterNetEvent('nx_bridge:server:GetPlayerIdentifier', function(targetSrc)
        local src = source
        local id = Nx.Framework and Nx.Framework.GetPlayerIdentifier(targetSrc or src)
        TriggerClientEvent('nx_bridge:server:GetPlayerIdentifier:cb', src, id)
    end)

    exports('GetJob', function(src)
        return Nx.Framework and Nx.Framework.GetJob(src)
    end)

    RegisterNetEvent('nx_bridge:server:GetJob', function(targetSrc)
        local src = source
        local job = Nx.Framework and Nx.Framework.GetJob(targetSrc or src)
        TriggerClientEvent('nx_bridge:server:GetJob:cb', src, job)
    end)

    -- money
    exports('GetMoney', function(src, moneyType)
        return Nx.Framework and Nx.Framework.GetMoney(src, moneyType) or 0
    end)

    RegisterNetEvent('nx_bridge:server:GetMoney', function(moneyType)
        local src = source
        local amount = Nx.Framework and Nx.Framework.GetMoney(src, moneyType) or 0
        TriggerClientEvent('nx_bridge:server:GetMoney:cb', src, amount)
    end)

    exports('AddMoney', function(src, moneyType, amount)
        return Nx.Framework and Nx.Framework.AddMoney(src, moneyType, amount) or false
    end)

    RegisterNetEvent('nx_bridge:server:AddMoney', function(src, moneyType, amount)
        return Nx.Framework and Nx.Framework.AddMoney(src, moneyType, amount) or false
    end)

    exports('RemoveMoney', function(src, moneyType, amount)
        return Nx.Framework and Nx.Framework.RemoveMoney(src, moneyType, amount) or false
    end)

    RegisterNetEvent('nx_bridge:server:RemoveMoney', function(src, moneyType, amount)
        return Nx.Framework and Nx.Framework.RemoveMoney(src, moneyType, amount) or false
    end)

    -- inventory
    exports('AddItem', function(src, item, amount, slotOrMeta, metadata)
        return Nx.Inventory and Nx.Inventory.AddItem(src, item, amount, slotOrMeta, metadata)
    end)

    RegisterNetEvent('nx_bridge:server:AddItem', function(src, item, amount, slotOrMeta, metadata)
        return Nx.Inventory and Nx.Inventory.AddItem(src, item, amount, slotOrMeta, metadata)
    end)

    exports('RemoveItem', function(src, item, amount, slotOrMeta)
        return Nx.Inventory and Nx.Inventory.RemoveItem(src, item, amount, slotOrMeta)
    end)

    RegisterNetEvent('nx_bridge:server:RemoveItem', function(src, item, amount, slotOrMeta)
        return Nx.Inventory and Nx.Inventory.RemoveItem(src, item, amount, slotOrMeta)
    end)

    exports('HasItem', function(src, item, amount)
        return Nx.Inventory and Nx.Inventory.HasItem(src, item, amount) or false
    end)

    RegisterNetEvent('nx_bridge:server:HasItem', function(item, amount)
        local src = source
        local result = Nx.Inventory and Nx.Inventory.HasItem(src, item, amount) or false
        TriggerClientEvent('nx_bridge:server:HasItem:cb', src, result)
    end)

    exports('GetItemCount', function(src, item)
        return Nx.Inventory and Nx.Inventory.GetItemCount(src, item) or 0
    end)

    RegisterNetEvent('nx_bridge:server:GetItemCount', function(item)
        local src = source
        local count = Nx.Inventory and Nx.Inventory.GetItemCount(src, item) or 0
        TriggerClientEvent('nx_bridge:server:GetItemCount:cb', src, count)
    end)

    exports('GetItemBySlot', function(src, slot)
        return Nx.Inventory and Nx.Inventory.GetItemBySlot and Nx.Inventory.GetItemBySlot(src, slot)
    end)

    RegisterNetEvent('nx_bridge:server:GetItemBySlot', function(slot)
        local src = source
        local item = Nx.Inventory and Nx.Inventory.GetItemBySlot and Nx.Inventory.GetItemBySlot(src, slot)
        TriggerClientEvent('nx_bridge:server:GetItemBySlot:cb', src, item)
    end)

    exports('GetItemByName', function(src, item)
        return Nx.Inventory and Nx.Inventory.GetItemByName and Nx.Inventory.GetItemByName(src, item)
    end)

    RegisterNetEvent('nx_bridge:server:GetItemByName', function(item)
        local src = source
        local result = Nx.Inventory and Nx.Inventory.GetItemByName and Nx.Inventory.GetItemByName(src, item)
        TriggerClientEvent('nx_bridge:server:GetItemByName:cb', src, result)
    end)

    exports('GetItemsByName', function(src, item)
        return Nx.Inventory and Nx.Inventory.GetItemsByName and Nx.Inventory.GetItemsByName(src, item)
    end)

    RegisterNetEvent('nx_bridge:server:GetItemsByName', function(item)
        local src = source
        local results = Nx.Inventory and Nx.Inventory.GetItemsByName and Nx.Inventory.GetItemsByName(src, item)
        TriggerClientEvent('nx_bridge:server:GetItemsByName:cb', src, results)
    end)

    exports('ClearInventory', function(src, filterItems)
        return Nx.Inventory and Nx.Inventory.ClearInventory and Nx.Inventory.ClearInventory(src, filterItems)
    end)

    RegisterNetEvent('nx_bridge:server:ClearInventory', function(src, filterItems)
        return Nx.Inventory and Nx.Inventory.ClearInventory and Nx.Inventory.ClearInventory(src, filterItems)
    end)

    exports('SetInventory', function(src, items)
        return Nx.Inventory and Nx.Inventory.SetInventory and Nx.Inventory.SetInventory(src, items)
    end)

    RegisterNetEvent('nx_bridge:server:SetInventory', function(src, items)
        return Nx.Inventory and Nx.Inventory.SetInventory and Nx.Inventory.SetInventory(src, items)
    end)

    exports('SetItemData', function(src, item, key, val)
        return Nx.Inventory and Nx.Inventory.SetItemData and Nx.Inventory.SetItemData(src, item, key, val)
    end)

    RegisterNetEvent('nx_bridge:server:SetItemData', function(src, item, key, val)
        return Nx.Inventory and Nx.Inventory.SetItemData and Nx.Inventory.SetItemData(src, item, key, val)
    end)

    exports('CreateUsableItem', function(item, data)
        return Nx.Inventory and Nx.Inventory.CreateUsableItem and Nx.Inventory.CreateUsableItem(item, data)
    end)

    RegisterNetEvent('nx_bridge:server:CreateUsableItem', function(item, data)
        return Nx.Inventory and Nx.Inventory.CreateUsableItem and Nx.Inventory.CreateUsableItem(item, data)
    end)

    exports('UseItem', function(item, ...)
        return Nx.Inventory and Nx.Inventory.UseItem and Nx.Inventory.UseItem(item, ...)
    end)

    RegisterNetEvent('nx_bridge:server:UseItem', function(src, item, ...)
        return Nx.Inventory and Nx.Inventory.UseItem and Nx.Inventory.UseItem(src, item, ...)
    end)

    -- stashes (see modules/inventory/qb-inventory/server/server.lua for
    -- why these go through events/DB reads rather than plain exports)
    exports('GetStashItems', function(stashId)
        return Nx.Inventory and Nx.Inventory.Stash and Nx.Inventory.Stash.GetItems(stashId) or {}
    end)

    RegisterNetEvent('nx_bridge:server:GetStashItems', function(stashId)
        local src = source
        local items = Nx.Inventory and Nx.Inventory.Stash and Nx.Inventory.Stash.GetItems(stashId) or {}
        TriggerClientEvent('nx_bridge:server:GetStashItems:cb', src, items)
    end)

    exports('SaveStashItems', function(stashId, items)
        if Nx.Inventory and Nx.Inventory.Stash then
            Nx.Inventory.Stash.SaveItems(stashId, items)
        end
    end)

    RegisterNetEvent('nx_bridge:server:SaveStashItems', function(stashId, items)
        if Nx.Inventory and Nx.Inventory.Stash then
            Nx.Inventory.Stash.SaveItems(stashId, items)
        end
    end)

    -- vehicle trunk / glovebox
    exports('SeedTrunk', function(plate, items)
        if Nx.Inventory and Nx.Inventory.Trunk then
            Nx.Inventory.Trunk.Seed(plate, items)
        end
    end)

    RegisterNetEvent('nx_bridge:server:SeedTrunk', function(plate, items)
        if Nx.Inventory and Nx.Inventory.Trunk then
            Nx.Inventory.Trunk.Seed(plate, items)
        end
    end)

    exports('GetTrunkItems', function(plate)
        return Nx.Inventory and Nx.Inventory.Trunk and Nx.Inventory.Trunk.GetItems(plate) or {}
    end)

    RegisterNetEvent('nx_bridge:server:GetTrunkItems', function(plate)
        local src = source
        local items = Nx.Inventory and Nx.Inventory.Trunk and Nx.Inventory.Trunk.GetItems(plate) or {}
        TriggerClientEvent('nx_bridge:server:GetTrunkItems:cb', src, items)
    end)

    exports('GetGloveboxItems', function(plate)
        return Nx.Inventory and Nx.Inventory.Glovebox and Nx.Inventory.Glovebox.GetItems(plate) or {}
    end)

    RegisterNetEvent('nx_bridge:server:GetGloveboxItems', function(plate)
        local src = source
        local items = Nx.Inventory and Nx.Inventory.Glovebox and Nx.Inventory.Glovebox.GetItems(plate) or {}
        TriggerClientEvent('nx_bridge:server:GetGloveboxItems:cb', src, items)
    end)

    -- notify (server -> targets a specific client)
    exports('Notify', function(src, msg, msgType, duration)
        if Nx.Notify then
            Nx.Notify.Notify(src, msg, msgType, duration)
        end
    end)

    RegisterNetEvent('nx_bridge:server:Notify', function(msg, msgType, duration)
        local src = source
        if Nx.Notify then
            Nx.Notify.Notify(src, msg, msgType, duration)
        end
    end)

    -- dispatch
    -- data = { title, message, coords, jobs, code, sound, icon, length, flash }
    -- (not every field is used by every adapter -- each one maps whatever
    -- applies onto its own alert format, see modules/dispatch/*/server/server.lua)
    exports('SendDispatchAlert', function(data)
        if Nx.Dispatch then
            Nx.Dispatch.SendAlert(data)
        end
    end)

    RegisterNetEvent('nx_bridge:server:SendDispatchAlert', function(data)
        if Nx.Dispatch then
            Nx.Dispatch.SendAlert(data)
        end
    end)

    exports('GetDispatchName', function()
        return Nx.DispatchName
    end)

    RegisterNetEvent('nx_bridge:server:GetDispatchName', function()
        local src = source
        TriggerClientEvent('nx_bridge:server:GetDispatchName:cb', src, Nx.DispatchName)
    end)

    -- phone
    -- data = { app, title, message, icon }
    exports('SendPhoneNotification', function(src, data)
        if Nx.Phone then
            Nx.Phone.SendNotification(src, data)
        end
    end)

    RegisterNetEvent('nx_bridge:server:SendPhoneNotification', function(src, data)
        if Nx.Phone then
            Nx.Phone.SendNotification(src, data)
        end
    end)

    -- data = { app, title, message, icon }
    exports('GetEquippedPhoneNumber', function(identifier)
        if Nx.Phone then
            Nx.Phone.GetEquippedPhoneNumber(identifier)
        end
    end)

    RegisterNetEvent('nx_bridge:server:GetEquippedPhoneNumber', function(identifier)
        if Nx.Phone then
            Nx.Phone.GetEquippedPhoneNumber(identifier)
        end
    end)

    -- data = { app, title, message, icon }
    exports('ToggleVerified', function(plat, accountname, bool)
        if Nx.Phone then
            Nx.Phone.ToggleVerified(plat, accountname, bool)
        end
    end)

    RegisterNetEvent('nx_bridge:server:ToggleVerified', function(plat, accountname, bool)
        if Nx.Phone then
            Nx.Phone.ToggleVerified(plat, accountname, bool)
        end
    end)

    exports('EmergencyNotification', function(src, data)
        if Nx.Phone then
            Nx.Phone.EmergencyNotification(src, data)
        end
    end)

    RegisterNetEvent('nx_bridge:server:EmergencyNotification', function(data)
        local src = source
        if Nx.Phone then
            Nx.Phone.EmergencyNotification(src, data)
        end
    end)

    exports('GetPhoneName', function()
        return Nx.PhoneName
    end)

    RegisterNetEvent('nx_bridge:server:GetPhoneName', function()
        local src = source
        TriggerClientEvent('nx_bridge:server:GetPhoneName:cb', src, Nx.PhoneName)
    end)

else
    -- ───────────────────────── CLIENT ─────────────────────────

    -- exports('SendDispatchAlert', function(data)
    --     if Nx.Dispatch then
    --         Nx.Dispatch.SendAlert(data)
    --     end
    -- end)

    exports('IsReady', function()
        return Nx.Framework ~= nil
    end)

    exports('WaitForBridge', function()
        while not Nx.Framework do Wait(0) end
        return true
    end)

    exports('GetFrameworkName', function()
        return Nx.FrameworkName
    end)

    exports('GetPlayerData', function()
        return Nx.Framework and Nx.Framework.GetPlayerData()
    end)

    -- notify (client -> notifies itself)
    exports('Notify', function(msg, msgType, duration)
        if Nx.Notify then
            Nx.Notify.Notify(msg, msgType, duration)
        elseif Nx.Framework and Nx.Framework.Notify then
            Nx.Framework.Notify(msg, msgType, duration)
        end
    end)

    RegisterNetEvent('nx_bridge:notify', function(msg, msgType, duration)
        if Nx.Notify then
            Nx.Notify.Notify(msg, msgType, duration)
        elseif Nx.Framework and Nx.Framework.Notify then
            Nx.Framework.Notify(msg, msgType, duration)
        end
    end)

    -- target
    exports('AddTargetEntity', function(entity, options)
        if Nx.Target then Nx.Target.AddEntity(entity, options) end
    end)

    RegisterNetEvent('nx_bridge:client:AddTargetEntity', function(entity, options)
        if Nx.Target then Nx.Target.AddEntity(entity, options) end
    end)

    exports('AddTargetModel', function(models, options)
        if Nx.Target then Nx.Target.AddModel(models, options) end
    end)

    RegisterNetEvent('nx_bridge:client:AddTargetModel', function(models, options)
        if Nx.Target then Nx.Target.AddModel(models, options) end
    end)

    exports('AddBoxZone', function(name, coords, length, width, options)
        if Nx.Target then Nx.Target.AddBoxZone(name, coords, length, width, options or {}) end
    end)

    RegisterNetEvent('nx_bridge:client:AddBoxZone', function(name, coords, length, width, options)
        if Nx.Target then Nx.Target.AddBoxZone(name, coords, length, width, options or {}) end
    end)

    exports('RemoveZone', function(name)
        if Nx.Target then Nx.Target.RemoveZone(name) end
    end)

    RegisterNetEvent('nx_bridge:client:RemoveZone', function(name)
        if Nx.Target then Nx.Target.RemoveZone(name) end
    end)

    -- inventory: opening stashes/trunks/gloveboxes has to be requested by
    -- the actual client (see modules/inventory/qb-inventory/client/client.lua)
    exports('OpenStash', function(stashId, options)
        if Nx.Inventory and Nx.Inventory.OpenStash then Nx.Inventory.OpenStash(stashId, options) end
    end)

    RegisterNetEvent('nx_bridge:client:OpenStash', function(stashId, options)
        if Nx.Inventory and Nx.Inventory.OpenStash then Nx.Inventory.OpenStash(stashId, options) end
    end)

    exports('OpenTrunk', function(plate, options)
        if Nx.Inventory and Nx.Inventory.OpenTrunk then Nx.Inventory.OpenTrunk(plate, options) end
    end)

    RegisterNetEvent('nx_bridge:client:OpenTrunk', function(plate, options)
        if Nx.Inventory and Nx.Inventory.OpenTrunk then Nx.Inventory.OpenTrunk(plate, options) end
    end)

    exports('OpenGlovebox', function(plate, options)
        if Nx.Inventory and Nx.Inventory.OpenGlovebox then Nx.Inventory.OpenGlovebox(plate, options) end
    end)

    RegisterNetEvent('nx_bridge:client:OpenGlovebox', function(plate, options)
        if Nx.Inventory and Nx.Inventory.OpenGlovebox then Nx.Inventory.OpenGlovebox(plate, options) end
    end)

    exports('OpenOtherPlayerInventory', function(targetId)
        if Nx.Inventory and Nx.Inventory.OpenOtherPlayer then Nx.Inventory.OpenOtherPlayer(targetId) end
    end)

    RegisterNetEvent('nx_bridge:client:OpenOtherPlayerInventory', function(targetId)
        if Nx.Inventory and Nx.Inventory.OpenOtherPlayer then Nx.Inventory.OpenOtherPlayer(targetId) end
    end)

    exports('UseItemSlot', function(slot)
        if Nx.Inventory and Nx.Inventory.UseItemSlot then Nx.Inventory.UseItemSlot(slot) end
    end)

    RegisterNetEvent('nx_bridge:client:UseItemSlot', function(slot)
        if Nx.Inventory and Nx.Inventory.UseItemSlot then Nx.Inventory.UseItemSlot(slot) end
    end)

    exports('GiveItem', function(targetId, itemName, amount, slot)
        if Nx.Inventory and Nx.Inventory.GiveItem then Nx.Inventory.GiveItem(targetId, itemName, amount, slot) end
    end)

    RegisterNetEvent('nx_bridge:client:GiveItem', function(targetId, itemName, amount, slot)
        if Nx.Inventory and Nx.Inventory.GiveItem then Nx.Inventory.GiveItem(targetId, itemName, amount, slot) end
    end)

    -- ── convenience: framework + target + inventory wired together ──
    -- Drops a target box zone that opens a stash on interact, in one call.
    exports('CreateStashZone', function(stashId, coords, length, width, options)
        if not Nx.Target then return end
        options = options or {}

        Nx.Target.AddBoxZone(('stash_%s'):format(stashId), coords, length or 1.5, width or 1.5, {
            heading = options.heading,
            debug = options.debug,
            targetOptions = {
                {
                    label = options.label or 'Open Stash',
                    icon = options.icon or 'fas fa-box-open',
                    action = function()
                        if Nx.Inventory and Nx.Inventory.OpenStash then
                            Nx.Inventory.OpenStash(stashId, options.stash or {})
                        end
                    end,
                },
            },
        })
    end)

    RegisterNetEvent('nx_bridge:client:CreateStashZone', function(stashId, coords, length, width, options)
        if not Nx.Target then return end
        options = options or {}

        Nx.Target.AddBoxZone(('stash_%s'):format(stashId), coords, length or 1.5, width or 1.5, {
            heading = options.heading,
            debug = options.debug,
            targetOptions = {
                {
                    label = options.label or 'Open Stash',
                    icon = options.icon or 'fas fa-box-open',
                    action = function()
                        if Nx.Inventory and Nx.Inventory.OpenStash then
                            Nx.Inventory.OpenStash(stashId, options.stash or {})
                        end
                    end,
                },
            },
        })
    end)

    -- appearance / skin
    exports('GetAppearance', function()
        return Nx.Appearance and Nx.Appearance.GetAppearance()
    end)

    exports('SetAppearance', function(data)
        if Nx.Appearance then Nx.Appearance.SetAppearance(data) end
    end)

    RegisterNetEvent('nx_bridge:client:SetAppearance', function(data)
        if Nx.Appearance then Nx.Appearance.SetAppearance(data) end
    end)

    exports('OpenAppearanceMenu', function(onDone, options)
        if Nx.Appearance then Nx.Appearance.OpenMenu(onDone, options) end
    end)

    RegisterNetEvent('nx_bridge:client:OpenAppearanceMenu', function(options)
        if Nx.Appearance then Nx.Appearance.OpenMenu(nil, options) end
    end)

    exports('GetAppearanceName', function()
        return Nx.AppearanceName
    end)

    -- fuel
    exports('GetFuel', function(vehicle)
        return Nx.Fuel and Nx.Fuel.GetFuel(vehicle) or 0.0
    end)

    exports('SetFuel', function(vehicle, amount)
        if Nx.Fuel then Nx.Fuel.SetFuel(vehicle, amount) end
    end)

    RegisterNetEvent('nx_bridge:client:SetFuel', function(vehicle, amount)
        if Nx.Fuel then Nx.Fuel.SetFuel(vehicle, amount) end
    end)

    exports('GetFuelName', function()
        return Nx.FuelName
    end)

    -- vehicle keys
    exports('GiveVehicleKeys', function(vehicle)
        if Nx.VehicleKeys then Nx.VehicleKeys.GiveKeys(vehicle) end
    end)

    RegisterNetEvent('nx_bridge:client:GiveVehicleKeys', function(vehicle)
        if Nx.VehicleKeys then Nx.VehicleKeys.GiveKeys(vehicle) end
    end)

    exports('HasVehicleKeys', function(vehicle)
        return Nx.VehicleKeys and Nx.VehicleKeys.HasKeys(vehicle) or false
    end)

    exports('RemoveVehicleKeys', function(vehicle)
        if Nx.VehicleKeys then Nx.VehicleKeys.RemoveKeys(vehicle) end
    end)

    RegisterNetEvent('nx_bridge:client:RemoveVehicleKeys', function(vehicle)
        if Nx.VehicleKeys then Nx.VehicleKeys.RemoveKeys(vehicle) end
    end)

    exports('GetVehicleKeysName', function()
        return Nx.VehicleKeysName
    end)

    -- voice
    exports('SetRadioChannel', function(channel)
        if Nx.Voice then Nx.Voice.SetRadioChannel(channel) end
    end)

    RegisterNetEvent('nx_bridge:client:SetRadioChannel', function(channel)
        if Nx.Voice then Nx.Voice.SetRadioChannel(channel) end
    end)

    exports('GetRadioChannel', function()
        return Nx.Voice and Nx.Voice.GetRadioChannel()
    end)

    exports('RemoveFromRadio', function()
        if Nx.Voice and Nx.Voice.RemoveFromRadio then Nx.Voice.RemoveFromRadio() end
    end)

    RegisterNetEvent('nx_bridge:client:RemoveFromRadio', function()
        if Nx.Voice and Nx.Voice.RemoveFromRadio then Nx.Voice.RemoveFromRadio() end
    end)

    exports('GetVoiceName', function()
        return Nx.VoiceName
    end)
end
