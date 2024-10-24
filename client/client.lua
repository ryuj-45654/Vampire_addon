RegisterNetEvent('vampire:giveAbilities')
AddEventHandler('vampire:giveAbilities', function()
    local playerPed = PlayerPedId()

    -- Aplicar velocidad aumentada
    SetRunSprintMultiplierForPlayer(PlayerId(), Config.VampireAbilities.speed)

    -- Visi�n nocturna
    if Config.VampireAbilities.night_vision then
        SetNightvision(true)
    end

    -- Regeneraci�n de salud
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000) -- Cada segundo
            if GetEntityHealth(playerPed) < 200 then -- Si la salud no es m�xima
                SetEntityHealth(playerPed, GetEntityHealth(playerPed) + Config.VampireAbilities.health_regeneration)
            end
        end
    end)
end)