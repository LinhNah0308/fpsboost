local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

-- ===== REMOVE CLOUDS =====
for _,v in pairs(Workspace:GetDescendants()) do
    if v:IsA("Clouds") then
        v:Destroy()
    end
end

-- ===== LIGHTING MIN =====
pcall(function()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 1e10
    Lighting.Brightness = 0
end)

for _,v in pairs(Lighting:GetChildren()) do
    if v:IsA("PostEffect") then
        v.Enabled = false
    end
end

-- ===== DELETE SOUND =====
for _,v in pairs(game:GetDescendants()) do
    if v:IsA("Sound") then
        v:Destroy()
    end
end

-- ===== MAP + SEA EXTREME OPTIMIZE (NOT FULL DELETE) =====
for _,v in pairs(Workspace:GetDescendants()) do
    if v:IsA("Terrain") then
        -- Sea / terrain tối giản
        v.WaterWaveSize = 0
        v.WaterWaveSpeed = 0
        v.WaterReflectance = 0
        v.WaterTransparency = 1
    elseif v:IsA("BasePart") then
        v.CastShadow = false
        v.Material = Enum.Material.Plastic
        v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") then
        v:Destroy()
    elseif v:IsA("ParticleEmitter")
        or v:IsA("Trail")
        or v:IsA("Beam")
        or v:IsA("Fire")
        or v:IsA("Smoke")
        or v:IsA("Sparkles") then
        v.Enabled = false
    end
end

-- ===== INVISIBLE CHARACTER (ALL PLAYERS) =====
local function invisibleChar(char)
    for _,v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 1
            v.CastShadow = false
        elseif v:IsA("Decal") then
            v:Destroy()
        end
    end
end

for _,plr in pairs(Players:GetPlayers()) do
    if plr.Character then
        invisibleChar(plr.Character)
    end
end

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(invisibleChar)
end)

-- ===== AUTO DELETE NEW EFFECTS + SOUND =====
Workspace.DescendantAdded:Connect(function(v)
    if v:IsA("Sound") then
        v:Destroy()
    elseif v:IsA("Decal")
        or v:IsA("Texture")
        or v:IsA("ParticleEmitter")
        or v:IsA("Trail")
        or v:IsA("Beam")
        or v:IsA("Fire")
        or v:IsA("Smoke")
        or v:IsA("Sparkles") then
        task.wait()
        pcall(function() v:Destroy() end)
    end
end)

-- ===== LOWEST RENDER =====
pcall(function()
    settings().Rendering.QualityLevel = 1
end)

-- ===== FPS COUNTER (RAINBOW) =====
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = Player:WaitForChild("PlayerGui")

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0,160,0,30)
label.Position = UDim2.new(0,10,0,10)
label.BackgroundTransparency = 1
label.TextScaled = true
label.Font = Enum.Font.SourceSansBold
label.Text = "FPS : 0"
label.Parent = gui

local frames, last, hue = 0, tick(), 0

RunService.RenderStepped:Connect(function()
    frames += 1
    if tick() - last >= 1 then
        label.Text = "FPS : "..frames
        frames = 0
        last = tick()
    end
    hue = (hue + 0.01) % 1
    label.TextColor3 = Color3.fromHSV(hue,1,1)
end)
