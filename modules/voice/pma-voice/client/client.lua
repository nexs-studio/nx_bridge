-- ✅ Documented API
if GetResourceState(Config.Resources['pma-voice']) ~= 'started' then return end

Nx.Voices['pma-voice'] = {
    SetRadioChannel = function(channel)
        exports['pma-voice']:setPlayerRadioChannel(channel)
    end,

    GetRadioChannel = function()
        return exports['pma-voice']:getPlayerRadioChannel()
    end,

    RemoveFromRadio = function()
        exports['pma-voice']:setPlayerRadioChannel(0)
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 voice (client) registered: ^3pma-voice^7') end
