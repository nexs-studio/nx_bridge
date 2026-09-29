-- ✅ Documented API
if GetResourceState(Config.Resources['qs-dispatch']) ~= 'started' then return end

Nx.Dispatches['qs-dispatch'] = {
    -- data = { title, message, coords, jobs, code, sound, length }
    SendAlert = function(data)
        exports['qs-dispatch']:CustomAlert({
            coords = data.coords,
            title = data.title,
            message = data.message,
            dispatchCode = data.code or '10-80',
            job_table = data.jobs or { 'police' },
            radius = data.length,
            sound = data.sound ~= false,
        })
    end,
}

if Config.Debug then print('^2[nx_bridge]^7 dispatch (server) registered: ^3qs-dispatch^7') end
