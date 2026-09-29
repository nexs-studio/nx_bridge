-- Picks whichever voice adapter registered on the client
-- and exposes it as Nx.Voice / Nx.VoiceName.
CreateThread(function()
    Wait(0)

    if Config.Voice == 'none' then
        if Config.Debug then print('^3[nx_bridge]^7 Voice system disabled via config') end
        return
    end

    local selected = Config.Voice

    if selected == 'auto' then
        selected = nil
        for name in pairs(Nx.Voices) do
            selected = name
            break
        end
    end

    Nx.Voice = selected and Nx.Voices[selected] or nil
    Nx.VoiceName = Nx.Voice and selected or nil

    if Config.Debug then
        if Nx.Voice then
            print(('^2[nx_bridge]^7 Active voice system: ^3%s^7'):format(Nx.VoiceName))
        else
            print('^3[nx_bridge]^7 No voice system detected (optional, skipping)')
        end
    end
end)
