-- KUYA FPS BOOST V3 (All-in-one)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer

-- 🌆 เวลา 17:50
Lighting.ClockTime = 17.83
Lighting.Brightness = 2
Lighting.Ambient = Color3.fromRGB(90,90,90)
Lighting.OutdoorAmbient = Color3.fromRGB(120,120,120)
Lighting.GlobalShadows = false

-- 📊 FPS
local fps = 0
local frames = 0
local last = tick()

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "KuyaV3"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,220,0,140)
frame.Position = UDim2.new(0.5,-110,0.5,-70)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.Text = "FPS BOOST V3"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextScaled = true

local fpsLabel = Instance.new("TextLabel", frame)
fpsLabel.Size = UDim2.new(1,0,0,25)
fpsLabel.Position = UDim2.new(0,0,0,30)
fpsLabel.Text = "FPS: 0"
fpsLabel.TextColor3 = Color3.fromRGB(255,255,0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextScaled = true

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0.9,0,0,40)
btn.Position = UDim2.new(0.05,0,0.65,0)
btn.Text = "เปิดโหมดลื่น"
btn.BackgroundColor3 = Color3.fromRGB(0,140,255)
btn.TextColor3 = Color3.new(1,1,1)
btn.TextScaled = true
Instance.new("UICorner", btn)

-- ❌ ลบเอฟเฟค + ดินน้ำมัน
local function optimize(v)

    if v:IsA("BasePart") then
        v.Material = Enum.Material.SmoothPlastic
        v.CastShadow = false

    elseif v:IsA("MeshPart") then
        v.TextureID = ""

    elseif v:IsA("Decal") then
        if v.Name == "face" then
            v:Destroy()
        else
            v.Transparency = 1
        end

    elseif v:IsA("Texture") then
        v:Destroy()

    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v:Destroy()

    elseif v:IsA("Explosion") then
        v:Destroy()

    elseif v:IsA("Fire") or v:IsA("Smoke") then
        v:Destroy()

    elseif v:IsA("Model") then
        if v.Name:lower():find("tree") then
            v:Destroy()
        end
    end
end

local enabled = false

local function enable()
    enabled = true
    btn.Text = "ลื่นแล้ว!"
    btn.BackgroundColor3 = Color3.fromRGB(0,255,100)

    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

    for _,v in pairs(workspace:GetDescendants()) do
        optimize(v)
    end
end

local function disable()
    enabled = false
    btn.Text = "เปิดโหมดลื่น"
    btn.BackgroundColor3 = Color3.fromRGB(0,140,255)
end

workspace.DescendantAdded:Connect(function(v)
    if enabled then
        task.wait()
        optimize(v)
    end
end)

btn.MouseButton1Click:Connect(function()
    if enabled then
        disable()
    else
        enable()
    end
end)

-- FPS realtime
RunService.RenderStepped:Connect(function()
    frames += 1
    if tick() - last >= 1 then
        fps = frames
        fpsLabel.Text = "FPS: "..fps
        frames = 0
        last = tick()
    end
end)

-- 💡 ทำให้ตัวละครสว่าง
local function addLight(char)
    local root = char:WaitForChild("HumanoidRootPart",5)
    if root then
        if root:FindFirstChild("Light") then
            root.Light:Destroy()
        end
        local light = Instance.new("PointLight")
        light.Brightness = 2
        light.Range = 15
        light.Parent = root
    end
end

if player.Character then
    addLight(player.Character)
end
player.CharacterAdded:Connect(addLight)
