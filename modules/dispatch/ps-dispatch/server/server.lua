-- ✅ Documented API
if GetResourceState(Config.Resources['ps-dispatch']) ~= 'started' then return end

Nx.Dispatches['ps-dispatch'] = {
    -- data = { title, message, coords, jobs, sound, icon, length, flash }
    SendAlert = function(data)
        exports['ps-dispatch']:CustomAlert({
            job_table = data.jobs or { 'police' },
            coords = data.coords,
            title = data.title,
            message = data.message,
            flash = data.flash or false,
            sound = data.sound ~= false,
            icon = data.icon or 'fas fa-circle-exclamation',
            length = data.length or 3,
        })
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 dispatch (server) registered: ^3ps-dispatch^7') end
