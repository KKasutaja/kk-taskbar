# kk-taskbar

#### Preview [https://i.imgur.com/DoYpuzT.png]

#### Usage

```lua
-- RECOMMENDED USAGE
TriggerEvent('KKF.UI.TaskBar', name, text, time, clip, dict, freeze, function()
    -- Code
end)

exports['kk-taskbar']:Taskbar(name, text, time, clip, dict, freeze, function()
    -- Code
end)

local progress = exports['kk-taskbar']:Taskbar(name, text, time, clip, dict, freeze)

if progress then
    -- Code
end

-- DEPRECATED USAGE
exports['kk-taskbar']:DrawBar(time, text, function()
    -- Code
end)
```

**Make sure you have the latest version to ensure the best experience.**
