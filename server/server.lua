ESX.RegisterUsableItem(Config.BloodItem, function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    xPlayer.removeInventoryItem(Config.BloodItem, 1) -- Remover sangre del inventario
    TriggerClientEvent('esx_status:add', playerId, 'health', 200000) -- Regenerar salud
end)

RegisterNetEvent('vampire:transform')
AddEventHandler('vampire:transform', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.setJob(Config.VampireJob, 0) -- Asignar trabajo de vampiro
    TriggerClientEvent('vampire:giveAbilities', source) -- Dar habilidades de vampiro
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000) -- Cada minuto
        for _, playerId in ipairs(GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if xPlayer.job.name == Config.VampireJob then
                local bloodCount = xPlayer.getInventoryItem(Config.BloodItem).count
                if bloodCount <= 0 then
                    -- Reducir salud por no tener sangre
                    TriggerClientEvent('esx_status:remove', playerId, 'health', 10)
                end
            end
        end
    end
end)