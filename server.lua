CreateThread(function()
    gitRepo = "https://github.com/KKasutaja/kk-taskbar.git"
    resourceName = "kk-taskbar ("..GetCurrentResourceName()..")"

    local function checkVersion(err, responseText, headers)
        curVersion = LoadResourceFile(GetCurrentResourceName(), "version")

        if curVersion ~= responseText and tonumber(curVersion) < tonumber(responseText) then
            print("^3You are running the latest version of kk-taskbar (current version: %s)")
        else
            print("^3Update is available for kk-taskbar - please download the latest release (current version: %s)")
        end
    end

    PerformHttpRequest("https://raw.githubusercontent.com"..gitRepo.."/master/version", checkVersion, "Checking Version")
end)
