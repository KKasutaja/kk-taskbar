# kk-taskbar

## Dependencies
- [ox_lib](https://github.com/overextended/ox_lib)

#### Usage

```lua
-- RECOMMENDED USAGE
TriggerEvent('KKF.UI.TaskBar', name, text, time, clip, dict, function()
    -- Code
end)

exports['kk-taskbar']:Taskbar(name, text, time, clip, dict, function()
    -- Code
end)

-- DEPRECATED USAGE
exports['kk-taskbar']:DrawBar(time, text, function()
    -- Code
end)
```

**Make sure you have the latest version to ensure the best experience.**