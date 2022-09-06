local actionInProgress = false
local controlsDisabled = false
local mapOpend = false
local currentAction = {}

local returnable = nil
local callback = nil

exports('canInteract', function()
	return actionInProgress
end)

RegisterNUICallback('actionDone', function(args, cb)
	SetTimeout(100, function()
		local playerPed = PlayerPedId()

		if callback then
			callback(true);
		else
			returnable = true
		end
		
		if currentAction.clip then ClearPedTasks(playerPed) end
		if currentAction.freeze then FreezeEntityPosition(playerPed, false) end
		if currentAction.controls then controlsDisabled = false end
	
		currentAction = {}; actionInProgress = false
	end)
end)

-- Shitty loops
Citizen.CreateThread(function()
	while true do
		wait = 0

		if controlsDisabled then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 38, true) -- E
			DisableControlAction(0, 77, true) -- X

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			wait = 500
		end

		Wait(wait)
	end
end)

CreateThread(function()
	while true do
        if IsPauseMenuActive() and not mapOpend then
            mapOpend = true
            SendNUIMessage({type = "hide"});
        elseif not IsPauseMenuActive() and mapOpend then
            mapOpend = false
            SendNUIMessage({type = "show"});
        end

		Wait(800)
	end
end)

-- Functions
local function TaskBar(name, text, time, clip, dict, data, cb)
	local playerPed = PlayerPedId()

	if not actionInProgress then
		actionInProgress = true

		if text then
			if dict and clip then
				lib.requestAnimDict(dict); TaskPlayAnim(playerPed, dict, clip, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
			elseif not dict and clip then
				TaskStartScenarioInPlace(playerPed, clip, 0, true)
			end

			if data.freeze then FreezeEntityPosition(playerPed, true) end
			if data.controls then controlsDisabled = true end

			currentAction['clip'] = clip
			currentAction['freeze'] = data.freeze
			currentAction['controls'] = data.controls

			SendNUIMessage({type = 'ui', time = time, text = text})

			if cb then
				currentAction['cb'] = cb
			else
				returnable = nil

				while returnable == nil do
					Wait(50)
				end
				
				return returnable
			end
		else
			print('[KKF.UI.TaskBar]: Time and text are not correct.')
		end
	else
		--TriggerEvent('KKF.UI.ShowNotification', 'error', 'Te ei saa kahe tegevusega korraga tegeleda.')
		ClearPedTasks(playerPed)
	end
end

-- Exports
exports('TaskBar', TaskBar)

RegisterCommand('cancelAction', function()
	--if exports['kk-ems']:getHealing() then return end
	
	if actionInProgress then
		local playerPed = PlayerPedId()

		if callback then
			callback(false);
		else
			returnable = false
		end

		if currentAction.clip then ClearPedTasks(playerPed) end
		if currentAction.freeze then FreezeEntityPosition(playerPed, false) end
		if currentAction.controls then controlsDisabled = false end

		SendNUIMessage({ type = 'cancel' }); currentAction =  {}; actionInProgress = false
		--TriggerEvent('KKF.UI.ShowNotification', 'error', 'Katkestasite tegevuse!')
	end
end)

RegisterKeyMapping('cancelAction', 'Katkesta tegevus.', 'keyboard', 'C')