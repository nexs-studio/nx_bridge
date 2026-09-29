if GetResourceState(Config.Resources['ox_target']) ~= 'started' then return end

Nx.Targets['ox_target'] = {
    AddEntity = function(entity, options)
        exports.ox_target:addLocalEntity(entity, options)
    end,

    AddModel = function(models, options)
        exports.ox_target:addModel(models, options)
    end,

    AddBoxZone = function(name, coords, length, width, options)
        options = options or {}
        exports.ox_target:addBoxZone({
            name = name,
            coords = coords,
            size = vector3(length, width, options.height or 4.0),
            rotation = options.heading or 0,
            debug = options.debug or false,
            options = options.targetOptions or {},
        })
    end,

    RemoveZone = function(name)
        exports.ox_target:removeZone(name)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 target (client) registered: ^3ox_target^7') end
