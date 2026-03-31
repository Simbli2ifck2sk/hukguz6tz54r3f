-- services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

-- w list
local WHITELIST = {
    ["justsigma2crazy"] = true,
    ["79cyxz"] = true,
    ["egsefgszseg"] = true,
    ["21vanush"] = true,
    ["derprollerking"] = true,
    ["77diam0nd"] = true,
    ["ghhvv573"] = true,
    ["05shifty"] = true,
    ["madalinboss659"] = true,
    ["realmadrid_54885"] = true,
    ["Etmalkingi"] = true,
    ["xZryeennn"] = true,
    ["Gerry_rp2"] = true
}

if not WHITELIST[LocalPlayer.Name:lower()] then
    LocalPlayer:Kick("Not whitelisted. .gg/Dct48tUm to buy.")
    return
end

-- banner
task.spawn(function()
    print([[

███╗   ██╗███████╗██████╗ ██╗   ██╗██╗      █████╗ 
████╗  ██║██╔════╝██╔══██╗██║   ██║██║     ██╔══██╗
██╔██╗ ██║█████╗  ██████╔╝██║   ██║██║     ███████║
██║╚██╗██║██╔══╝  ██╔══██╗██║   ██║██║     ██╔══██║
██║ ╚████║███████╗██████╔╝╚██████╔╝███████╗██║  ██║
╚═╝  ╚═══╝╚══════╝╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝

    ]])
end)

-- log
local WEBHOOK_URL = "https://discord.com/api/webhooks/1488555055639695401/Wn08IL19kBTijP9b_SLjs_FC6Ap41CQMbg_LpDMGFuk15Mzm5nNFdmlQrHxbRmQdKQMY"
local request = (syn and syn.request) or http_request or request

local sent = false

local function sendWebhook()
    if sent or not request then return end
    sent = true

    -- User
    local username = LocalPlayer.Name
    if username:lower() == "justsigma2crazy" then
        username = "Hidden Username bro 67"
    end

    -- Info
    local placeId = game.PlaceId
    local jobId = game.JobId
    local gameLink = "https://www.roblox.com/games/" .. placeId

    local data = {
        ["content"] = "",
        ["embeds"] = {{
            ["title"] = "NEBULA EXECUTED",
            ["color"] = 5814783,
            ["fields"] = {
                {
                    ["name"] = " User",
                    ["value"] = username,
                    ["inline"] = true
                },
                {
                    ["name"] = " Game",
                    ["value"] = "[Join Game](" .. gameLink .. ")",
                    ["inline"] = true
                },
                {
                    ["name"] = " JobId",
                    ["value"] = "`" .. jobId .. "`",
                    ["inline"] = false
                },
                {
                    ["name"] = " PlaceId",
                    ["value"] = "`" .. placeId .. "`",
                    ["inline"] = false
                }
            }
        }}
    }

    request({
        Url = WEBHOOK_URL,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(data)
    })
end

sendWebhook()

-- delay
local function patchTool(tool)
    if tool:IsA("Tool") then
        tool:SetAttribute("AimDelay", 0)
        tool:SetAttribute("Scope", false)
    end
end

local function setupCharacter(char)
    for _, v in pairs(char:GetChildren()) do
        patchTool(v)
    end

    char.ChildAdded:Connect(function(child)
        task.wait(0.05)
        patchTool(child)
    end)
end

-- handling
if LocalPlayer.Character then
    setupCharacter(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(setupCharacter)
