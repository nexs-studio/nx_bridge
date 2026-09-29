if GetResourceState(Config.Resources.ox_lib) ~= 'started' then return end

Nx.Notifies['ox_lib'] = Nx.Notifies['ox_lib'] or {}

Nx.Notifies['ox_lib'].Notify = function(msg, msgType, duration)
    exports.ox_lib:notify({
        description = msg,
        type = msgType or 'inform',
        duration = duration or 5000,
    })
end

if Config.Debug then print('^2[nx_bridge]^7 notify (client) registered: ^3ox_lib^7') end
