-- ⚠ UNVERIFIED: low confidence on this resource's exact API. This is a
-- best-effort placeholder -- lb-tablet's dispatch module is part of
-- Linden's broader tablet suite and its exact call signature should be
-- confirmed in your installed version before relying on this.
if GetResourceState(Config.Resources['lb-tablet']) ~= 'started' then return end

Nx.Dispatches['lb-tablet'] = {
    -- data = { title, message, coords, jobs, sound, icon }
    SendAlert = function(data)
        exports['lb-tablet']:CreateDispatchCall({
            title = data.title,
            description = data.message,
            coords = data.coords,
            jobs = data.jobs or { 'police' },
            icon = data.icon,
        })
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 dispatch (server) registered: ^3lb-tablet^7 (⚠ UNVERIFIED API, please confirm)') end
