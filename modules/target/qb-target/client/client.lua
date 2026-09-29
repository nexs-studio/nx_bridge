if GetResourceState(Config.Resources['qb-target']) ~= 'started' then return end

Nx.Targets['qb-target'] = {
    AddEntity = function(entity, options)
        exports['qb-target']:AddTargetEntity(entity, {
            options = options,
            distance = options.distance or 2.5,
        })
    end,

    AddModel = function(models, options)
        exports['qb-target']:AddTargetModel(models, {
            options = options,
            distance = options.distance or 2.5,
        })
    end,

    AddBoxZone = function(name, coords, length, width, options)
        options = options or {}
        exports['qb-target']:AddBoxZone(name, coords, length, width, {
            name = name,
            heading = options.heading or 0,
            debugPoly = options.debug or false,
            minZ = options.minZ,
            maxZ = options.maxZ,
        }, {
            options = options.targetOptions or {},
            distance = options.distance or 2.5,
        })
    end,

    RemoveZone = function(name)
        exports['qb-target']:RemoveZone(name)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 target (client) registered: ^3qb-target^7') end
