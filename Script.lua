loadstring(game:HttpGet("https://raw.githubusercontent.com/xidin861-star/Script-tsb-fps-/main/Script.lua"))()

-- 💡 เพิ่มแสงให้ตัวละคร
local player = game.Players.LocalPlayer

local function addLight(char)
    if char:FindFirstChild("HumanoidRootPart") then
        if char.HumanoidRootPart:FindFirstChild("PlayerLight") then
            char.HumanoidRootPart.PlayerLight:Destroy()
        end

        local light = Instance.new("PointLight")
        light.Name = "PlayerLight"
        light.Brightness = 2
        light.Range = 15
        light.Color = Color3.fromRGB(255, 244, 214)
        light.Parent = char.HumanoidRootPart
    end
end

if player.Character then
    addLight(player.Character)
end

player.CharacterAdded:Connect(addLight)
