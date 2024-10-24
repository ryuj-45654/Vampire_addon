RegisterNetEvent('vampire:giveAbilities')
AddEventHandler('vampire:giveAbilities', function()
    local playerPed = PlayerPedId()

    -- Aplicar velocidad aumentada
    SetRunSprintMultiplierForPlayer(PlayerId(), Config.VampireAbilities.speed)

    -- Visión nocturna
    if Config.VampireAbilities.night_vision then
        SetNightvision(true)
    end

    -- Regeneración de salud
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000) -- Cada segundo
            if GetEntityHealth(playerPed) < 200 then -- Si la salud no es máxima
                SetEntityHealth(playerPed, GetEntityHealth(playerPed) + Config.VampireAbilities.health_regeneration)
            end
        end
    end)
end)