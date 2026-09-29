-- ⚠ VERIFY: moderate confidence on exact event name/signature. Test against
-- your installed version before relying on this in production.
if GetResourceState(Config.Resources['codem-dispatch']) ~= 'started' then return end

Nx.Dispatches['codem-dispatch'] = {
    -- data = { title, message, coords, jobs, sound }
    SendAlert = function(data)
        TriggerEvent('codem-dispatch:server:notify', data.jobs or { 'police' }, {
            coords = data.coords,
            title = data.title,
            message = data.message,
            sound = data.sound ~= false,
        })
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 dispatch (server) registered: ^3codem-dispatch^7 (⚠ unverified, check your version)') end
