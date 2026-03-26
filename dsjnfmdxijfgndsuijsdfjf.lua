-- made by cqf5 not skidded like simple hurensohn
print(".gg/nebula-hq ")

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- C
local TOGGLE_KEY = Enum.KeyCode.Comma
local THEME = {
    Main = Color3.fromRGB(10, 10, 10),
    Secondary = Color3.fromRGB(20, 20, 22),
    Accent = Color3.fromRGB(255, 255, 255),
    Text = Color3.fromRGB(255, 255, 255),
    CloseHover = Color3.fromRGB(200, 50, 50)
}

-- Skybox 
local SKYBOXES = {
    {Name="Rivals", ID="108929045660200|78646480540009|90546017435179|109838453114563|94190734796082|126944775797063"},
    {Name="Galaxy", ID="15983968922|15983966825|15983965025|15983967420|15983966246|15983964246"},
    {Name="Sunset", ID="600830446|600831635|600832720|600886090|600833862|600835177"},
    {Name="Astral", ID="16553658937|16553660713|16553662144|16553664042|16553665766|16553667750"},
    {Name="Green", ID="16563478983|16563481302|16563484084|16563485362|16563487078|16563489821"},
    {Name="Default Night", ID="nil"}
}

local function applySky(id)
    for _,v in pairs(Lighting:GetChildren()) do if v:IsA("Sky") then v:Destroy() end end
    if id == "nil" then return end
    local sky = Instance.new("Sky", Lighting)
    local ids = string.split(id, "|")
    if #ids == 6 then
        sky.SkyboxBk="rbxassetid://"..ids[1] sky.SkyboxDn="rbxassetid://"..ids[2]
        sky.SkyboxFt="rbxassetid://"..ids[3] sky.SkyboxLf="rbxassetid://"..ids[4]
        sky.SkyboxRt="rbxassetid://"..ids[5] sky.SkyboxUp="rbxassetid://"..ids[6]
    end
end

-- UI
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "NebulaLarge"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 300) -- Neue Größe 600x300
main.Position = UDim2.new(0.5, -300, 0.5, -150)
main.BackgroundColor3 = THEME.Main
main.ClipsDescendants = true
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
local border = Instance.new("UIStroke", main)
border.Color = THEME.Secondary
border.Thickness = 2

-- Header
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.Text = "NEBULA"
title.TextColor3 = THEME.Text
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -40, 0, 0)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(100, 100, 100)
closeBtn.TextSize = 26
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.Gotham

closeBtn.MouseEnter:Connect(function() closeBtn.TextColor3 = THEME.CloseHover end)
closeBtn.MouseLeave:Connect(function() closeBtn.TextColor3 = Color3.fromRGB(100, 100, 100) end)
closeBtn.MouseButton1Click:Connect(function() gui.Enabled = false end)

-- Schnee
local snowContainer = Instance.new("Frame", main)
snowContainer.Size = UDim2.new(1, 0, 1, 0)
snowContainer.BackgroundTransparency = 1
snowContainer.ZIndex = 1

task.spawn(function()
    while true do
        if gui.Enabled then
            local flake = Instance.new("Frame", snowContainer)
            flake.Size = UDim2.new(0, math.random(2,3), 0, math.random(2,3))
            flake.BackgroundColor3 = THEME.Accent
            flake.BackgroundTransparency = 0.5
            flake.Position = UDim2.new(math.random(), 0, -0.05, 0)
            Instance.new("UICorner", flake).CornerRadius = UDim.new(1, 0)
            
            local drift = (math.random() - 0.5) * 0.1
            flake:TweenPosition(UDim2.new(flake.Position.X.Scale + drift, 0, 1.1, 0), "Linear", "In", math.random(3, 5))
            task.delay(5, function() flake:Destroy() end)
        end
        task.wait(0.15)
    end
end)

-- Buttons
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -30, 1, -60)
scroll.Position = UDim2.new(0, 15, 0, 45)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 2
scroll.ScrollBarImageColor3 = THEME.Secondary
scroll.CanvasSize = UDim2.new(0, 0, 0, 0) 
scroll.ZIndex = 5

local layout = Instance.new("UIGridLayout", scroll)
layout.CellSize = UDim2.new(0, 180, 0, 50)
layout.CellPadding = UDim2.new(0, 15, 0, 15)
layout.SortOrder = Enum.SortOrder.LayoutOrder

for _, sky in pairs(SKYBOXES) do
    local btn = Instance.new("TextButton", scroll)
    btn.Text = sky.Name
    btn.BackgroundColor3 = THEME.Secondary
    btn.TextColor3 = THEME.Text
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 13
    btn.ZIndex = 6
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    -- Hover Effekt
    btn.MouseEnter:Connect(function() 
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 38)}):Play() 
    end)
    btn.MouseLeave:Connect(function() 
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = THEME.Secondary}):Play() 
    end)
    
    btn.MouseButton1Click:Connect(function()
        applySky(sky.ID)
    end)
end

-- drag
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == TOGGLE_KEY then gui.Enabled = not gui.Enabled end
end)

local dragging, dragStart, startPos
main.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true dragStart = i.Position startPos = main.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
