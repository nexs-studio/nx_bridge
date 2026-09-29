-- ⚠ UNVERIFIED: low confidence on this resource's exact API. This is a
-- best-effort placeholder using the naming convention common across
-- dispatch scripts -- please confirm the real event/export name in
-- core_dispatch's own source before relying on this.
if GetResourceState(Config.Resources['core_dispatch']) ~= 'started' then return end

Nx.Dispatches['core_dispatch'] = {
    -- data = { title, message, coords, jobs, sound }
    SendAlert = function(data)
        TriggerEvent('core_dispatch:server:notify', {
            job_table = data.jobs or { 'police' },
            coords = data.coords,
            title = data.title,
            message = data.message,
            sound = data.sound ~= false,
        })
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 dispatch (server) registered: ^3core_dispatch^7 (⚠ UNVERIFIED API, please confirm)') end
