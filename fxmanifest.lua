fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Your Name'
description 'nx_bridge -- universal framework / target / inventory / notify / appearance / dispatch / phone / fuel / vehiclekeys / voice bridge'
version '1.1.0'

-- Only config.lua is truly shared (it just builds the Nx namespace + Config table).
-- Everything else lives under modules/<component>/<adapter>/<client|server>/
-- and is loaded on the side it actually applies to. selector.lua files are
-- side-agnostic and listed once per side they're needed on; each just acts
-- on whatever registered into Nx.* on that side.
shared_scripts {
    'config.lua',
}

client_scripts {
    -- framework adapters (client half)
    'modules/framework/qbcore/client/client.lua',
    'modules/framework/qbox/client/client.lua',
    'modules/framework/esx/client/client.lua',
    'modules/framework/selector.lua',

    -- target adapters (client only -- no server-side concept of "target")
    'modules/target/qb-target/client/client.lua',
    'modules/target/ox_target/client/client.lua',
    'modules/target/selector.lua',

    -- inventory adapters (client half -- opening stashes/trunks/gloveboxes
    -- has to happen client-side, see comments in the adapter file)
    'modules/inventory/qb-inventory/client/client.lua',
    'modules/inventory/selector.lua',

    -- notify adapters (client half)
    'modules/notify/qb-notify/client/client.lua',
    'modules/notify/ox_lib/client/client.lua',
    'modules/notify/selector.lua',

    -- appearance adapters (client only -- ped customization is client-rendered)
    'modules/appearance/esx_skin/client/client.lua',
    'modules/appearance/fivem-appearance/client/client.lua',
    'modules/appearance/illenium-appearance/client/client.lua',
    'modules/appearance/qb-clothing/client/client.lua',
    'modules/appearance/selector.lua',

    -- fuel adapters (client only -- fuel level is a client-rendered vehicle property)
    'modules/fuel/LegacyFuel/client/client.lua',
    'modules/fuel/cdn-fuel/client/client.lua',
    'modules/fuel/lc_fuel/client/client.lua',
    'modules/fuel/ox_fuel/client/client.lua',
    'modules/fuel/qb-fuel/client/client.lua',
    'modules/fuel/rcore_fuel/client/client.lua',
    'modules/fuel/Renewed-Fuel/client/client.lua',
    'modules/fuel/selector.lua',

    -- vehicle keys adapters (client only -- key ownership is tracked per-client)
    'modules/vehiclekeys/cd_garage/client/client.lua',
    'modules/vehiclekeys/okokGarage/client/client.lua',
    'modules/vehiclekeys/qb-vehiclekeys/client/client.lua',
    'modules/vehiclekeys/qbx_vehiclekeys/client/client.lua',
    'modules/vehiclekeys/Renewed-Vehiclekeys/client/client.lua',
    'modules/vehiclekeys/wasabi_carlock/client/client.lua',
    'modules/vehiclekeys/selector.lua',

    -- voice adapters (client only)
    'modules/voice/pma-voice/client/client.lua',
    'modules/voice/selector.lua',

    'modules/core/client/client.lua',
    'exports.lua',
}

server_scripts {
    -- framework adapters (server half)
    'modules/framework/qbcore/server/server.lua',
    'modules/framework/qbox/server/server.lua',
    'modules/framework/esx/server/server.lua',
    'modules/framework/selector.lua',

    -- inventory adapters (server half -- item ops are server-authoritative)
    'modules/inventory/qb-inventory/server/server.lua',
    'modules/inventory/ox_inventory/server/server.lua',
    'modules/inventory/selector.lua',

    -- notify adapters (server half)
    'modules/notify/qb-notify/server/server.lua',
    'modules/notify/ox_lib/server/server.lua',
    'modules/notify/selector.lua',

    -- dispatch adapters (server only -- alerts need server-side job filtering
    -- to reach every officer online)
    'modules/dispatch/cd_dispatch/server/server.lua',
    'modules/dispatch/codem-dispatch/server/server.lua',
    'modules/dispatch/core_dispatch/server/server.lua',
    'modules/dispatch/lb-tablet/server/server.lua',
    'modules/dispatch/origen_police/server/server.lua',
    'modules/dispatch/ps-dispatch/server/server.lua',
    'modules/dispatch/qs-dispatch/server/server.lua',
    'modules/dispatch/rcore_dispatch/server/server.lua',
    'modules/dispatch/tk_dispatch/server/server.lua',
    'modules/dispatch/selector.lua',

    -- phone adapters (server only -- pushing a notification to a specific
    -- player is server-initiated)
    'modules/phone/17mov_phone/server/server.lua',
    'modules/phone/gksphone/server/server.lua',
    'modules/phone/lb-phone/server/server.lua',
    'modules/phone/meteo-phone/server/server.lua',
    'modules/phone/npwd/server/server.lua',
    'modules/phone/qs-smartphone-pro/server/server.lua',
    'modules/phone/roadphone/server/server.lua',
    'modules/phone/yflip/server/server.lua',
    'modules/phone/yphone/server/server.lua',
    'modules/phone/yseries/server/server.lua',
    'modules/phone/selector.lua',

    'modules/core/server/server.lua',
    'exports.lua',
}
