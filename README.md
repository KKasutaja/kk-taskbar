# kk-taskbar

#### Preview [https://i.imgur.com/DoYpuzT.png]

#### Usage

```lua
-- RECOMMENDED USAGE
TriggerEvent('KKF.UI.TaskBar', name, text, time, clip, dict, function()
    -- Code
end)

exports['kk-taskbar']:TaskBar(name, text, time, clip, dict, function()
    -- Code
end)

local progress = exports['kk-taskbar']:TaskBar(name, text, time, clip, dict)

if progress then
    -- Code
end

-- DEPRECATED USAGE
exports['kk-taskbar']:DrawBar(time, text, function()
    -- Code
end)
```

**Make sure you have the latest version to ensure the best experience.**
