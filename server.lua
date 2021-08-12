ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('ron-banking:server:openUI', function()

    TriggerClientEvent('ron-banking:client:openUI', source, GetChar(source).last)

end)

ESX.RegisterServerCallback('ron-banking:server:get', function(source, cb)

    xPlayer = ESX.GetPlayerFromId(source)

    PlayerData = {}

    PlayerData.bank = xPlayer.getAccount('bank').money

    PlayerData.cash = xPlayer.getMoney()

    PlayerData.firstname = GetChar(source).firstname
    
    PlayerData.lastname = GetChar(source).lastname

    cb(PlayerData)

end)

RegisterServerEvent('ron-banking:deposit', function(amount)

    xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= amount then

        xPlayer.removeMoney(amount)

        xPlayer.addAccountMoney('bank', amount)

    end

end)

RegisterServerEvent('ron-banking:withdraw', function(amount)

    xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getAccount('bank').money >= amount then

        xPlayer.removeAccountMoney('bank', amount)

        xPlayer.addMoney(amount)

    end

end)

RegisterServerEvent('ron-banking:transfer', function(id, amount)

	xPlayer = ESX.GetPlayerFromId(source)

	xTarget = ESX.GetPlayerFromId(id)

	if xTarget ~= nil then
		
		if source ~= id then

			if xPlayer.getAccount('bank').money >= amount then

				xPlayer.removeAccountMoney('bank', amount)

				xTarget.addAccountMoney('bank', amountt)

			end

		end

	end

end)

updateLast = function(src, last)

    print(last)

    Last = GetChar(src).last

    xPlayer = ESX.GetPlayerFromId(src)

    New_Last = Last + last

    TriggerClientEvent('ron-banking:client:updateLast', src, New_Last)

    MySQL.Sync.execute('UPDATE users SET last = @last WHERE identifier = @identifier', {

        ['@identifier'] = xPlayer.identifier,

        ['@last'] = New_Last

    })

end

GetChar = function(src)

    xPlayer = ESX.GetPlayerFromId(src)

    local result = MySQL.Sync.fetchAll('SELECT * FROM `users` WHERE `identifier` = \'' .. xPlayer.identifier .. '\'', {})

    if result[1] then

        return result[1]

    else

        return nil

    end

end