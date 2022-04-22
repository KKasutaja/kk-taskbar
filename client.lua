local actionInProgress = false

-- Funktsioonid
local function TaskBar(name, text, time, clip, dict, cb)
	if not actionInProgress then
		actionInProgress = true

		if time > 750 and text then
			if dict and clip then
				lib.requestAnimDict(dict); TaskPlayAnim(cache.ped, dict, clip, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
			elseif not dict and clip then
				TaskStartScenarioInPlace(cache.ped, clip, 0, true)
			end

			SendNUIMessage({type = 'ui', display = true, time = time, text = text})

			SetTimeout(time + 100, function()
				if clip then ClearPedTasks(cache.ped) end
				if cb then cb() end

				actionInProgress = false
			end)
		else
			print('[KKF.UI.TaskBar]: Time and text are not correct.')
		end
	else
		lib.notify({
			description = 'You cannot perform two activities at the same time.',
			status = 'error'
		})
	end
end

local function DrawBar(time, text, cb)
	TaskBar('deprecated_taskBar', text, time, nil, nil, cb)
end
-- Funktsioonide lõpp

-- Exportid
exports('TaskBar', TaskBar)

exports('DrawBar', DrawBar)
-- Exportide lõpp

-- Eventid
RegisterNetEvent('KKF.UI.TaskBar', TaskBar)
-- Eventide lõpp