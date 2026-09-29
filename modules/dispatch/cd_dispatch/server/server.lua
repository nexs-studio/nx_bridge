-- ✅ Documented API
if GetResourceState(Config.Resources.cd_dispatch) ~= 'started' then return end

Nx.Dispatches.cd_dispatch = {
    -- data = { title, message, coords, jobs, sound, flash }
    SendAlert = function(data)
        TriggerEvent('cd_dispatch:AddNotification', {
            job_table = data.jobs or { 'police' },
            coords = data.coords,
            title = data.title,
            message = data.message,
            flash = data.flash and 1 or 0,
            unique_id = tostring(math.random(1000000, 9999999)),
            sound = data.sound == false and 0 or 1,
            offset = false,
        })
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 dispatch (server) registered: ^3cd_dispatch^7') end
