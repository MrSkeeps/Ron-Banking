ESX = nil

Citizen.CreateThread(function()

    while ESX == nil do

        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

        Citizen.Wait(0)

    end

end)

CreateThread(function()
    
    while true do

        Wait(0)

        local PlayerCoords = GetEntityCoords(PlayerPedId())

        for _, v in pairs(Config.Banks) do

            if Vdist(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, v['coords']) < 1.5 then

                DrawText3Ds(v['coords'] , '[E] Use The Bank')
    
                if IsControlJustPressed(0, 38) then
    
                    TriggerServerEvent('ron-banking:server:openUI')
    
                end
    
            end
            
        end
    
    end

end)

RegisterNetEvent("ron-banking:client:openUI",function(last)

    ESX.TriggerServerCallback('ron-banking:server:get', function(playerData) 
        
        SetNuiFocus(true, true)
    
        SendNUIMessage({
    
            action = true,
    
            last = last,
    
            playerData = playerData
    
        })
        
    end)

end)

RegisterNetEvent("ron-banking:client:updateLast",function(last)

    SetTimeout(500, function()

        SendNUIMessage({updateLast = true, last = last})

    end)
    
end)

RegisterNUICallback('Deposit', function(data,cb)

    TriggerServerEvent('ron-banking:deposit', data.inputVal)

    SetTimeout(500, function()

        ESX.TriggerServerCallback('ron-banking:server:get', function(playerData)
    
            SendNUIMessage({

                updateBalance = true,
      
                playerData = playerData
      
            })

        end)

    end)

end)

RegisterNUICallback('Withdraw', function(data,cb)

    TriggerServerEvent('ron-banking:withdraw', data.inputVal)

    SetTimeout(500, function()

        ESX.TriggerServerCallback('ron-banking:server:get', function(playerData)

            SendNUIMessage({

                updateBalance = true,
      
                playerData = playerData
      
            })

        end)

    end)

end)

RegisterNUICallback('transfer', function(data,cb)

    TriggerServerEvent('ron-banking:transfer', data.inputValID, data.inputVal)

    SetTimeout(500, function()

        ESX.TriggerServerCallback('ron-banking:server:get', function(playerData)

            SendNUIMessage({

                updateBalance = true,
      
                playerData = playerData
      
            })

        end)

    end)

end)

RegisterNUICallback('quickdep', function(data,cb)

    quickActionsDeposit(data.amount)

end)

RegisterNUICallback('quickwit', function(data,cb)

    quickActionsWithdraw(data.amount)

end)

function quickActionsWithdraw(amount)

    TriggerServerEvent('ron-banking:withdraw', amount)

    SetTimeout(500, function()

        ESX.TriggerServerCallback('ron-banking:server:get', function(playerData)

            SendNUIMessage({

                updateBalance = true,
      
                playerData = PlayerData
      
            })

        end)

    end)

end

function quickActionsDeposit(amount)

    TriggerServerEvent('ron-banking:deposit', amount)

    SetTimeout(500, function()

        ESX.TriggerServerCallback('ron-banking:server:get', function(playerData)

            SendNUIMessage({

                updateBalance = true,
      
                playerData = PlayerData
      
            })

        end)

    end)

end

RegisterNUICallback("close", function()
    
    SetNuiFocus(false, false)

end)

Citizen.CreateThread(function()

    for _,loc in pairs(Config.Banks) do

        loc = AddBlipForCoord(loc.coords.x, loc.coords.y, loc.coords.z)

        SetBlipSprite(loc, 108)

        SetBlipColour(loc, 0)

        SetBlipScale(loc, 0.6)

        SetBlipAsShortRange(loc, true)

        BeginTextCommandSetBlipName("STRING")

        AddTextComponentString("Bank")

        EndTextCommandSetBlipName(loc)

    end

end)

DrawText3Ds = function(coords, text)

	SetTextScale(0.35, 0.35)

    SetTextFont(4)

    SetTextProportional(1)

    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")

    SetTextCentre(true)

    AddTextComponentString(text)

    SetDrawOrigin(coords, 0)

    DrawText(0.0, 0.0)

    local factor = (string.len(text)) / 370

    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)

    ClearDrawOrigin()

end