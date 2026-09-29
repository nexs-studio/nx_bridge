if GetResourceState(Config.Resources.esx) ~= 'started' then return end

local ESX = exports['es_extended']:getSharedObject()

Nx.Frameworks.esx = Nx.Frameworks.esx or {}

Nx.Frameworks.esx.GetPlayer = function(src)
    return ESX.GetPlayerFromId(src)
end

Nx.Frameworks.esx.GetPlayerIdentifier = function(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    return xPlayer and xPlayer.identifier or nil
end

Nx.Frameworks.esx.GetMoney = function(src, moneyType)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return 0 end
    if not moneyType or moneyType == 'cash' or moneyType == 'money' then
        return xPlayer.getMoney()
    end
    local account = xPlayer.getAccount(moneyType)
    return account and account.money or 0
end

Nx.Frameworks.esx.AddMoney = function(src, moneyType, amount)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return false end
    if not moneyType or moneyType == 'cash' or moneyType == 'money' then
        xPlayer.addMoney(amount)
    else
        xPlayer.addAccountMoney(moneyType, amount)
    end
    return true
end

Nx.Frameworks.esx.RemoveMoney = function(src, moneyType, amount)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return false end
    if not moneyType or moneyType == 'cash' or moneyType == 'money' then
        xPlayer.removeMoney(amount)
    else
        xPlayer.removeAccountMoney(moneyType, amount)
    end
    return true
end

Nx.Frameworks.esx.GetJob = function(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    return xPlayer and xPlayer.job or nil
end

if Config.Debug then print('^2[nx_bridge]^7 framework (server) registered: ^3esx^7') end
