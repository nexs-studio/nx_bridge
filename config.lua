-- ═══════════════════════════════════════════════════════
--  nx_bridge — shared namespace
--  Loaded first (shared_script) on both client and server.
--  Every adapter registers itself into these tables.
-- ═══════════════════════════════════════════════════════
Nx = Nx or {}
Nx.Frameworks       = {} -- registry: [name] = { ...functions }
Nx.Targets          = {}
Nx.Inventories      = {}
Nx.Notifies         = {}
Nx.Appearances      = {}
Nx.Dispatches       = {}
Nx.Phones           = {}
Nx.Fuels            = {}
Nx.VehicleKeySystems = {} -- NOTE: registry. The active adapter is Nx.VehicleKeys (see modules/vehiclekeys/selector.lua)
Nx.Voices           = {}

Config = {}

-- ═══════════════════════════════════════════════════════
--  FRAMEWORK
--  'auto'                = detect whatever is running
--  'qbcore' | 'qbox' | 'esx' = force a specific one
-- ═══════════════════════════════════════════════════════
Config.Framework = 'auto'

-- ═══════════════════════════════════════════════════════
--  TARGET SYSTEM
--  'auto' | 'qb-target' | 'ox_target' | 'none'
-- ═══════════════════════════════════════════════════════
Config.Target = 'auto'

-- ═══════════════════════════════════════════════════════
--  INVENTORY
--  'auto' | 'qb-inventory' | 'ox_inventory'
-- ═══════════════════════════════════════════════════════
Config.Inventory = 'auto'

-- ═══════════════════════════════════════════════════════
--  NOTIFICATIONS
--  'auto' | 'qb-notify' | 'ox_lib'
-- ═══════════════════════════════════════════════════════
Config.Notify = 'ox_lib'

-- ═══════════════════════════════════════════════════════
--  APPEARANCE / SKIN
--  'auto' | 'esx_skin' | 'fivem-appearance' | 'illenium-appearance' | 'qb-clothing' | 'none'
-- ═══════════════════════════════════════════════════════
Config.Appearance = 'auto'

-- ═══════════════════════════════════════════════════════
--  DISPATCH
--  'auto' | 'cd_dispatch' | 'codem-dispatch' | 'core_dispatch' | 'lb-tablet'
--  | 'origen_police' | 'ps-dispatch' | 'qs-dispatch' | 'rcore_dispatch'
--  | 'tk_dispatch' | 'none'
-- ═══════════════════════════════════════════════════════
Config.Dispatch = 'auto'

-- ═══════════════════════════════════════════════════════
--  PHONE
--  'auto' | '17mov_phone' | 'gksphone' | 'lb-phone' | 'meteo-phone' | 'npwd'
--  | 'qs-smartphone-pro' | 'roadphone' | 'yflip' | 'yphone' | 'yseries' | 'none'
-- ═══════════════════════════════════════════════════════
Config.Phone = 'auto'

-- ═══════════════════════════════════════════════════════
--  FUEL
--  'auto' | 'cdn-fuel' | 'lc_fuel' | 'LegacyFuel' | 'ox_fuel' | 'qb-fuel'
--  | 'rcore_fuel' | 'Renewed-Fuel' | 'none'
-- ═══════════════════════════════════════════════════════
Config.Fuel = 'auto'

-- ═══════════════════════════════════════════════════════
--  VEHICLE KEYS
--  'auto' | 'cd_garage' | 'okokGarage' | 'qb-vehiclekeys' | 'qbx_vehiclekeys'
--  | 'Renewed-Vehiclekeys' | 'wasabi_carlock' | 'none'
-- ═══════════════════════════════════════════════════════
Config.VehicleKeys = 'auto'

-- ═══════════════════════════════════════════════════════
--  VOICE
--  'auto' | 'pma-voice' | 'none'
-- ═══════════════════════════════════════════════════════
Config.Voice = 'auto'

-- Print detection/registration results to console
Config.Debug = true

-- ═══════════════════════════════════════════════════════
--  RESOURCE NAMES
--  Used for GetResourceState() checks. Change these if a
--  server runs a renamed fork of one of these resources.
-- ═══════════════════════════════════════════════════════
Config.Resources = {
    -- frameworks
    qbcore = 'qb-core',
    qbox   = 'qbx_core',
    esx    = 'es_extended',

    -- target systems
    ['qb-target'] = 'qb-target',
    ['ox_target'] = 'ox_target',

    -- inventories
    ['qb-inventory'] = 'qb-inventory',
    ['ox_inventory'] = 'ox_inventory',

    -- notifications
    ['qb-notify'] = 'qb-core', -- ships inside qb-core
    ['ox_lib']    = 'ox_lib',

    -- appearance / skin
    ['esx_skin']            = 'esx_skin',
    ['fivem-appearance']    = 'fivem-appearance',
    ['illenium-appearance'] = 'illenium-appearance',
    ['qb-clothing']         = 'qb-clothing',

    -- dispatch
    ['cd_dispatch']    = 'cd_dispatch',
    ['codem-dispatch'] = 'codem-dispatch',
    ['core_dispatch']  = 'core_dispatch',
    ['lb-tablet']      = 'lb-tablet',
    ['origen_police']  = 'origen_police',
    ['ps-dispatch']    = 'ps-dispatch',
    ['qs-dispatch']    = 'qs-dispatch',
    ['rcore_dispatch'] = 'rcore_dispatch',
    ['tk_dispatch']    = 'tk_dispatch',

    -- phone
    ['17mov_phone']       = '17mov_phone',
    ['gksphone']          = 'gksphone',
    ['lb-phone']          = 'lb-phone',
    ['meteo-phone']       = 'meteo-phone',
    ['npwd']              = 'npwd',
    ['qs-smartphone-pro'] = 'qs-smartphone-pro',
    ['roadphone']         = 'roadphone',
    ['yflip']             = 'yflip',
    ['yphone']            = 'yphone',
    ['yseries']           = 'yseries',

    -- fuel
    ['cdn-fuel']     = 'cdn-fuel',
    ['lc_fuel']      = 'lc_fuel',
    ['LegacyFuel']   = 'LegacyFuel',
    ['ox_fuel']      = 'ox_fuel',
    ['qb-fuel']      = 'qb-fuel',
    ['rcore_fuel']   = 'rcore_fuel',
    ['Renewed-Fuel'] = 'Renewed-Fuel',

    -- vehicle keys
    ['cd_garage']            = 'cd_garage',
    ['okokGarage']           = 'okokGarage',
    ['qb-vehiclekeys']       = 'qb-vehiclekeys',
    ['qbx_vehiclekeys']      = 'qbx_vehiclekeys',
    ['Renewed-Vehiclekeys']  = 'Renewed-Vehiclekeys',
    ['wasabi_carlock']       = 'wasabi_carlock',

    -- voice
    ['pma-voice'] = 'pma-voice',
}
