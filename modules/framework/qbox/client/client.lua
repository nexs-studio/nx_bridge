if GetResourceState(Config.Resources.qbox) ~= 'started' then return end

Nx.Frameworks.qbox = Nx.Frameworks.qbox or {}

Nx.Frameworks.qbox.GetPlayerData = function()
    return exports.qbx_core:GetPlayerData()
end

Nx.Frameworks.qbox.Notify = function(msg, msgType, duration)
    exports.qbx_core:Notify(msg, msgType, duration)
end

if Config.Debug then print('^2[nx_bridge]^7 framework (client) registered: ^3qbox^7') end
