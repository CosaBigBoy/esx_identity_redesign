local loadingScreenFinished = false
local ready = false
local guiEnabled = false
local timecycleModifier = "hud_def_blur"

ESX.SecureNetEvent("esx_identity:alreadyRegistered", function()
    while not loadingScreenFinished do
        Wait(100)
    end
    TriggerEvent("esx_skin:playerRegistered")
end)

ESX.SecureNetEvent("esx_identity:setPlayerData", function(data)
    SetTimeout(1, function()
        ESX.SetPlayerData("name", ("%s %s"):format(data.firstName, data.lastName))
        ESX.SetPlayerData("firstName", data.firstName)
        ESX.SetPlayerData("lastName", data.lastName)
        ESX.SetPlayerData("dateofbirth", data.dateOfBirth)
        ESX.SetPlayerData("sex", data.sex)
        ESX.SetPlayerData("height", data.height)
    end)
end)

AddEventHandler("esx:loadingScreenOff", function()
    loadingScreenFinished = true
end)

RegisterNUICallback("ready", function(_, cb)
    ready = true
    cb(1)
end)

function setGuiState(state)
        SetNuiFocus(state, state)
        guiEnabled = state

        if state then
            SetTimecycleModifier(timecycleModifier)
        else
            ClearTimecycleModifier()
        end

        SendNUIMessage({
            type = "enableui",
            enable = state,
            theme = Config.UI
        })
end

RegisterNetEvent("esx_identity:showRegisterIdentity", function()
        TriggerEvent("esx_skin:resetFirstSpawn")
        local timeout = GetGameTimer() + 10000
        while not ready and GetGameTimer() < timeout do
            Wait(100)
        end

        -- The NUI can be ready even when no loading-screen event was emitted.
        -- Do not block the identity screen forever waiting for an unrelated event.
        if not ready then
            print("^1[esx_identity]^7 NUI did not report ready within 10 seconds.")
            return
        end

        if not ESX.PlayerData.dead then
            setGuiState(true)
        end
end)

RegisterNUICallback("register", function(data, cb)
        if not guiEnabled then
            return
        end

        xLib.callback("esx_identity:registerIdentity", false, function(callback)
            if not callback then
                return
            end

            ESX.ShowNotification(TranslateCap("thank_you_for_registering"))
            setGuiState(false)

            if not ESX.GetConfig().Multichar then
                TriggerEvent("esx_skin:playerRegistered")
            end
        end, data)
        cb(1)
end)
