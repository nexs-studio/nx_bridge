-- ⚠ UNVERIFIED: low confidence on this resource's exact API. This is a
-- best-effort placeholder -- please confirm the real event/export name in
-- rcore_dispatch's own source before relying on this.
if GetResourceState(Config.Resources['rcore_dispatch']) ~= 'started' then return end

Nx.Dispatches['rcore_dispatch'] = {
    -- data = { title, message, coords, jobs, sound }
    SendAlert = function(data)
        TriggerEvent('rcore_dispatch:server:createalert', {
            title = data.title,
            message = data.message,
            coords = data.coords,
            jobs = data.jobs or { 'police' },
            sound = data.sound ~= false,
        })
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 dispatch (server) registered: ^3rcore_dispatch^7 (⚠ UNVERIFIED API, please confirm)') end
