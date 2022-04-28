local actionInProgress = false

-- Functions
local function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Wait(5)
	end
end

local function TaskBar(name, text, time, clip, dict, freeze, cb)
	local playerPed = PlayerPedId()

	if not actionInProgress then
		actionInProgress = true

		if time > 750 and text then
			if dict and clip then
				loadAnimDict(dict); TaskPlayAnim(playerPed, dict, clip, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
			elseif not dict and clip then
				TaskStartScenarioInPlace(playerPed, clip, 0, true)
			end

			if freeze then FreezeEntityPosition(playerPed, true) end

			SendNUIMessage({type = 'ui', display = true, time = time, text = text})

			if cb then
				SetTimeout(time + 100, function()
					if clip then ClearPedTasks(cache.ped) end
					if freeze then FreezeEntityPosition(playerPed, false) end
					cb()

					actionInProgress = false
				end)
			else
				Wait(time + 100)
				if clip then ClearPedTasks(cache.ped) end
				if freeze then FreezeEntityPosition(playerPed, false) end

				actionInProgress = false; return true
			end
		else
			print('[KKF]: Time and text are not correct.')
		end
	else
		print('[KKF]: You cannot perform two activities at the same time.')
	end
end

local function DrawBar(time, text, cb)
	TaskBar('deprecated_taskBar', text, time, nil, nil, false, cb)
end
-- Functions end

-- Exports
exports('TaskBar', TaskBar)

exports('DrawBar', DrawBar)
-- Exports end

-- Events
RegisterNetEvent('KKF.UI.TaskBar', TaskBar)
-- Events end
