-- ⚠ UNVERIFIED: low confidence on this resource's exact API. origen_police
-- bundles dispatch into its broader MDT/police suite -- please confirm the
-- real export/event name in your installed version before relying on this.
if GetResourceState(Config.Resources['origen_police']) ~= 'started' then return end

Nx.Dispatches['origen_police'] = {
    -- data = { title, message, coords, jobs, sound }
    SendAlert = function(data)
        exports['origen_police']:sendAlert({
            title = data.title,
            message = data.message,
            coords = data.coords,
            jobs = data.jobs or { 'police' },
            sound = data.sound ~= false,
        })
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 dispatch (server) registered: ^3origen_police^7 (⚠ UNVERIFIED API, please confirm)') end
