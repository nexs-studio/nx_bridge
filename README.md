# nx_bridge

A drop-in compatibility layer between your scripts and popular FiveM
frameworks, target systems, inventories, and notification systems. Your
scripts call `exports['nx_bridge']:...`, never the underlying framework
directly.

## Folder structure

Nothing but files sits at the resource root. Every adapter lives in its own
folder under `modules/`, split into `client`/`server` for the side it
actually runs on.

```
nx_bridge/
├── fxmanifest.lua
├── config.lua                 -- pick framework/target/inventory/notify, or 'auto'
├── exports.lua                -- the public API other resources call into
└── modules/
    ├── core/                  -- boot logic, prints readiness once the bridge is up
    │   ├── client/client.lua
    │   └── server/server.lua
    │
    ├── framework/
    │   ├── qbcore/
    │   │   ├── client/client.lua
    │   │   └── server/server.lua
    │   ├── qbox/
    │   │   ├── client/client.lua
    │   │   └── server/server.lua
    │   ├── esx/
    │   │   ├── client/client.lua
    │   │   └── server/server.lua
    │   └── selector.lua       -- picks the active framework -> Nx.Framework
    │
    ├── target/                -- client-only: target systems have no server half
    │   ├── qb-target/
    │   │   └── client/client.lua
    │   ├── ox_target/
    │   │   └── client/client.lua
    │   └── selector.lua       -- -> Nx.Target
    │
    ├── inventory/
    │   ├── qb-inventory/
    │   │   ├── client/client.lua   -- opening stash/trunk/glovebox UIs
    │   │   └── server/server.lua   -- item ops, stash/trunk/glovebox data
    │   ├── ox_inventory/
    │   │   └── server/server.lua   -- server-only (not extended beyond basics)
    │   └── selector.lua       -- -> Nx.Inventory
    │
    ├── notify/
    │   ├── qb-notify/
    │   │   ├── client/client.lua
    │   │   └── server/server.lua
    │   ├── ox_lib/
    │   │   ├── client/client.lua
    │   │   └── server/server.lua
    │   └── selector.lua       -- -> Nx.Notify
    │
    ├── appearance/            -- client-only: ped customization is client-rendered
    │   ├── esx_skin/client/client.lua
    │   ├── fivem-appearance/client/client.lua
    │   ├── illenium-appearance/client/client.lua
    │   ├── qb-clothing/client/client.lua
    │   └── selector.lua       -- -> Nx.Appearance
    │
    ├── dispatch/              -- server-only: alerts need server-side job filtering
    │   ├── cd_dispatch/server/server.lua
    │   ├── codem-dispatch/server/server.lua
    │   ├── core_dispatch/server/server.lua
    │   ├── lb-tablet/server/server.lua
    │   ├── origen_police/server/server.lua
    │   ├── ps-dispatch/server/server.lua
    │   ├── qs-dispatch/server/server.lua
    │   ├── rcore_dispatch/server/server.lua
    │   ├── tk_dispatch/server/server.lua
    │   └── selector.lua       -- -> Nx.Dispatch
    │
    ├── phone/                 -- server-only: pushing a notification to one player is server-initiated
    │   ├── 17mov_phone/server/server.lua
    │   ├── gksphone/server/server.lua
    │   ├── lb-phone/server/server.lua
    │   ├── meteo-phone/server/server.lua
    │   ├── npwd/server/server.lua
    │   ├── qs-smartphone-pro/server/server.lua
    │   ├── roadphone/server/server.lua
    │   ├── yflip/server/server.lua
    │   ├── yphone/server/server.lua
    │   ├── yseries/server/server.lua
    │   └── selector.lua       -- -> Nx.Phone
    │
    ├── fuel/                  -- client-only: fuel level is a client-rendered vehicle property
    │   ├── cdn-fuel/client/client.lua
    │   ├── lc_fuel/client/client.lua
    │   ├── LegacyFuel/client/client.lua
    │   ├── ox_fuel/client/client.lua
    │   ├── qb-fuel/client/client.lua
    │   ├── rcore_fuel/client/client.lua
    │   ├── Renewed-Fuel/client/client.lua
    │   └── selector.lua       -- -> Nx.Fuel
    │
    ├── vehiclekeys/           -- client-only: key ownership is tracked per-client
    │   ├── cd_garage/client/client.lua
    │   ├── okokGarage/client/client.lua
    │   ├── qb-vehiclekeys/client/client.lua
    │   ├── qbx_vehiclekeys/client/client.lua
    │   ├── Renewed-Vehiclekeys/client/client.lua
    │   ├── wasabi_carlock/client/client.lua
    │   └── selector.lua       -- -> Nx.VehicleKeys (registry: Nx.VehicleKeySystems)
    │
    └── voice/                 -- client-only
        ├── pma-voice/client/client.lua
        └── selector.lua       -- -> Nx.Voice
```

**Which components are one-sided, and why:**
- `target` -- client-only, target systems have no server concept.
- `dispatch` -- server-only, alerts need server-side job filtering to reach every officer online.
- `phone` -- server-only, pushing a notification to one specific player is server-initiated.
- `appearance`, `fuel`, `vehiclekeys`, `voice` -- client-only, these are all client-rendered/client-tracked state.
- `framework`, `inventory`, `notify` -- full `client/` + `server/` split (inventory's client half exists specifically because *opening* a stash/trunk/glovebox has to be requested by the actual client, even though the item data itself is server-authoritative).

**Confidence flags:** every adapter for the newer categories (appearance,
dispatch, phone, fuel, vehiclekeys, voice) is commented at the top with one of:
- `✅ Documented API` -- confirmed against known, stable export/event names.
- `⚠ VERIFY` -- follows a strong ecosystem-wide convention, but not confirmed against that specific resource's source. Moderate confidence.
- `⚠ UNVERIFIED` -- best-effort placeholder for a resource I don't have reliable API knowledge of. Test before relying on it in production, and check that resource's own documentation/source for the real event or export names.

## How it fits together

1. `config.lua` (shared) creates the `Nx` namespace and reads your settings.
2. Each adapter file under `modules/<component>/<name>/<side>/` checks if
   its resource is running (`GetResourceState`) and, if so, registers itself
   into `Nx.Frameworks[name]`, `Nx.Targets[name]`, etc. If the resource isn't
   running, it returns immediately and does nothing.
3. Each `selector.lua` picks the active adapter (either whatever
   `config.lua` forces, or the first one found when set to `'auto'`) and
   exposes it as `Nx.Framework`, `Nx.Target`, `Nx.Inventory`, `Nx.Notify`.
   These files are listed once in `client_scripts` and once in
   `server_scripts` in `fxmanifest.lua` -- the logic is identical, it just
   acts on whatever registered on that side.
4. `exports.lua` is the only file other resources ever need to know about.
   It's loaded on both sides and branches on `IsDuplicityVersion()` to
   expose the right set of exports per side.

## Adding a new adapter

Say you want to add `ps-inventory`. Create:

```
modules/inventory/ps-inventory/server/server.lua
```

```lua
if GetResourceState(Config.Resources['ps-inventory']) ~= 'started' then return end

Nx.Inventories['ps-inventory'] = {
    AddItem = function(src, item, amount, slot, metadata) ... end,
    RemoveItem = function(src, item, amount, slot) ... end,
    HasItem = function(src, item, amount) ... end,
    GetItemCount = function(src, item) ... end,
}
```

Then:
- Add `['ps-inventory'] = 'ps-inventory'` to `Config.Resources` in `config.lua`.
- Add the new file path to `server_scripts` in `fxmanifest.lua`.

`modules/inventory/selector.lua` picks it up automatically -- no other
changes needed.

## qb-inventory: stashes, trunks & gloveboxes

qb-inventory only exports its core item functions (`AddItem`, `RemoveItem`,
`GetItemBySlot`, etc.) -- all real `exports(...)` calls, wrapped 1:1 in
`modules/inventory/qb-inventory/server/server.lua`.

Stash/trunk/glovebox handling is **not** exported at all -- `GetStashItems`,
`SaveStashItems`, `AddToTrunk`, and friends are plain globals that only exist
inside qb-inventory's own resource, invisible to everything else. The bridge
gets at them a different way for each case:

| Need | How the bridge does it | Why |
|---|---|---|
| Open a stash/trunk/glovebox UI for a player | `TriggerServerEvent('inventory:server:OpenInventory', ...)` from the **client** | qb-inventory reads `source` off that event to know who's opening it -- it can't be faked from another server resource |
| Read a stash's saved contents | Direct `SELECT` on `stashitems` / `otherstashitems` / `evidencebox` | `GetStashItems()` isn't exported, but it's a plain read, so mirroring the query is safe |
| Save a stash's contents | `TriggerEvent('qb-inventory:server:SaveStashItems', ...)` | this event's handler has no `source` dependency, so it's safe to call from anywhere, anytime |
| Seed a vehicle's trunk with loot (e.g. on spawn) | `TriggerEvent('inventory:server:addTrunkItems', ...)` | also `source`-independent; only touches the runtime cache, not the DB, until a player opens/closes that trunk in-game |
| Read a trunk/glovebox's saved contents | Direct `SELECT` on `trunkitems` / `gloveboxitems` | same reasoning as stash reads |

Exposed as, server-side:
```lua
exports['nx_bridge']:GetStashItems(stashId)
exports['nx_bridge']:SaveStashItems(stashId, items)
exports['nx_bridge']:SeedTrunk(plate, items)
exports['nx_bridge']:GetTrunkItems(plate)
exports['nx_bridge']:GetGloveboxItems(plate)
```

Client-side (these must be called from the client, see table above):
```lua
exports['nx_bridge']:OpenStash(stashId, options)
exports['nx_bridge']:OpenTrunk(plate, options)
exports['nx_bridge']:OpenGlovebox(plate, options)
exports['nx_bridge']:OpenOtherPlayerInventory(targetId)
exports['nx_bridge']:UseItemSlot(slot)
exports['nx_bridge']:GiveItem(targetId, itemName, amount, slot)
```

There's also a convenience that wires target + inventory together in one
call -- drops a target zone that opens a stash on interact:
```lua
exports['nx_bridge']:CreateStashZone('my_stash_01', vector3(123.4, 456.7, 30.0), 1.5, 1.5, {
    label = 'Open Stash',
    stash = { maxweight = 4000000, slots = 40 },
})
```

qb-inventory also fires `inventory:client:ItemBox` (pickup/use animation)
and `inventory:client:UpdatePlayerInventory` (inventory changed) as raw
client events. The bridge relays both onto its own event names so other
resources don't need to know qb-inventory's naming:
```lua
RegisterNetEvent('nx_bridge:client:itemBox', function(itemData, actionType, amount) end)
RegisterNetEvent('nx_bridge:client:inventoryUpdated', function(reopen) end)
```

## Appearance / skin

Client-side only:
```lua
exports['nx_bridge']:GetAppearance()
exports['nx_bridge']:SetAppearance(appearanceData)
exports['nx_bridge']:OpenAppearanceMenu(function(appearance) end, options)
```
Adapters: `esx_skin` (✅), `fivem-appearance` (✅), `illenium-appearance` (✅), `qb-clothing` (⚠ verify).

## Dispatch

Server-side only. Every adapter takes the same canonical alert shape and
translates it into whatever fields that specific dispatch script expects:
```lua
exports['nx_bridge']:SendDispatchAlert({
    title = '10-80 Pursuit',
    message = 'Pursuit in progress',
    coords = vector3(123.4, 456.7, 30.0),
    jobs = { 'police' },   -- who should see it
    code = '10-80',        -- optional, used by some adapters
    sound = true,          -- optional alert sound
    icon = 'fas fa-car',   -- optional map blip icon
    length = 3,            -- optional blip radius/duration, meaning varies by adapter
    flash = false,         -- optional flashing blip
})
```
Adapters: `cd_dispatch` (✅), `ps-dispatch` (✅), `qs-dispatch` (✅),
`codem-dispatch` (⚠ verify), `core_dispatch` / `lb-tablet` / `origen_police` /
`rcore_dispatch` / `tk_dispatch` (⚠ unverified -- confirm against source).

## Phone

Server-side only:
```lua
exports['nx_bridge']:SendPhoneNotification(source, {
    app = 'messages',
    title = 'Dispatch',
    message = 'Unit requested at Legion Square',
    icon = nil,
})
```
Adapters: `lb-phone` (✅), `npwd` / `qs-smartphone-pro` (⚠ verify),
`17mov_phone` / `gksphone` / `meteo-phone` / `roadphone` / `yflip` / `yphone`
/ `yseries` (⚠ unverified -- confirm against source).

## Fuel

Client-side only:
```lua
exports['nx_bridge']:GetFuel(vehicle)
exports['nx_bridge']:SetFuel(vehicle, 75.0)
```
Adapters: `LegacyFuel` (✅), `qb-fuel` (✅), `ox_fuel` (✅, uses the native
fuel level directly), `cdn-fuel` / `lc_fuel` / `rcore_fuel` / `Renewed-Fuel`
(⚠ verify -- follows the near-universal `GetFuel`/`SetFuel` convention but
not confirmed against source).

## Vehicle keys

Client-side only:
```lua
exports['nx_bridge']:GiveVehicleKeys(vehicle)
exports['nx_bridge']:HasVehicleKeys(vehicle)
exports['nx_bridge']:RemoveVehicleKeys(vehicle)
```
Adapters: `qb-vehiclekeys` (✅), `qbx_vehiclekeys` (✅), `wasabi_carlock` /
`Renewed-Vehiclekeys` (⚠ verify), `cd_garage` / `okokGarage` (⚠ unverified --
these are garage scripts first, key-giving is usually bundled into vehicle
retrieval rather than a standalone export, confirm against source).

## Voice

Client-side only:
```lua
exports['nx_bridge']:SetRadioChannel(1)
exports['nx_bridge']:GetRadioChannel()
exports['nx_bridge']:RemoveFromRadio()
```
Adapter: `pma-voice` (✅).

## Config

Edit `config.lua`:

```lua
Config.Framework   = 'auto'   -- or 'qbcore' | 'qbox' | 'esx'
Config.Target      = 'auto'   -- or 'qb-target' | 'ox_target' | 'none'
Config.Inventory   = 'auto'   -- or 'qb-inventory' | 'ox_inventory'
Config.Notify      = 'auto'   -- or 'qb-notify' | 'ox_lib'
Config.Appearance  = 'auto'   -- or 'esx_skin' | 'fivem-appearance' | 'illenium-appearance' | 'qb-clothing' | 'none'
Config.Dispatch    = 'auto'   -- or any of the 9 dispatch adapters, or 'none'
Config.Phone       = 'auto'   -- or any of the 10 phone adapters, or 'none'
Config.Fuel        = 'auto'   -- or any of the 7 fuel adapters, or 'none'
Config.VehicleKeys = 'auto'   -- or any of the 6 vehiclekeys adapters, or 'none'
Config.Voice       = 'auto'   -- or 'pma-voice' | 'none'
Config.Debug       = true
```

## Usage from your own scripts

**Server-side:**
```lua
local Player = exports['nx_bridge']:GetPlayer(source)
exports['nx_bridge']:AddMoney(source, 'cash', 500)
exports['nx_bridge']:AddItem(source, 'water_bottle', 1)
exports['nx_bridge']:Notify(source, 'You got paid!', 'success')
```

**Client-side:**
```lua
local PlayerData = exports['nx_bridge']:GetPlayerData()
exports['nx_bridge']:Notify('Hello!', 'primary')

exports['nx_bridge']:AddTargetEntity(entity, {
    { label = 'Open Shop', icon = 'fas fa-shop', action = function() end }
})
```

## Important notes

- **Resource name matters for exports.** If you rename the `nx_bridge`
  folder, update every `exports['nx_bridge']:...` call to match.
- **Start order.** `nx_bridge` must start *after* whatever framework,
  target, inventory, and notify resources you're using:
  ```
  ensure qb-core
  ensure qb-target
  ensure qb-inventory
  ensure nx_bridge
  ```
- **Waiting for the bridge.** There's a brief window right at boot before
  detection finishes. If a script calls the bridge immediately on resource
  start, use the safety export first:
  ```lua
  exports['nx_bridge']:WaitForBridge()
  ```
- Only QBCore/Qbox/ESX + qb-target/ox_target + qb-inventory/ox_inventory +
  qb-notify/ox_lib are scaffolded. The adapter pattern makes it quick to add
  more (ND_Core, qs-inventory, okokNotify, etc.) following the same
  `modules/<component>/<name>/<side>/` layout.
