local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

-- Remove clouds
for _, v in pairs(Workspace:GetDescendants()) do
    if v:IsA("Clouds") then
        v:Destroy()
    end
end

pcall(function()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 0
end)

for _, v in pairs(Lighting:GetChildren()) do
    if v:IsA("PostEffect") then
        v.Enabled = false
    end
end

for _, v in pairs(Workspace:GetDescendants()) do
    if v:IsA("ParticleEmitter")
    or v:IsA("Trail")
    or v:IsA("Beam")
    or v:IsA("Fire")
    or v:IsA("Smoke")
    or v:IsA("Sparkles") then
        v.Enabled = false
    end

    if v:IsA("Decal") or v:IsA("Texture") then
        v:Destroy()
    end

    if v:IsA("BasePart") then
        v.CastShadow = false
        v.Material = Enum.Material.Plastic
        v.Reflectance = 0
    end
end

local function hideChar(char)
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then
            v.Transparency = 1
        end
    end
end

for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= Player and plr.Character then
        hideChar(plr.Character)
    end
end

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(hideChar)
end)

Workspace.DescendantAdded:Connect(function(v)
    if v:IsA("ParticleEmitter")
    or v:IsA("Trail")
    or v:IsA("Beam")
    or v:IsA("Fire")
    or v:IsA("Smoke")
    or v:IsA("Sparkles")
    or v:IsA("Decal")
    or v:IsA("Texture") then
        task.wait()
        pcall(function() v:Destroy() end)
    end
end)

settings().Rendering.QualityLevel = 1

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = Player:WaitForChild("PlayerGui")

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0, 160, 0, 30)
label.Position = UDim2.new(0, 10, 0, 10)
label.BackgroundTransparency = 1
label.TextScaled = true
label.Font = Enum.Font.SourceSansBold
label.Text = "FPS : 0"
label.Parent = gui

local frames = 0
local last = tick()
local fps = 0
local hue = 0

RunService.RenderStepped:Connect(function()
    frames += 1
    local now = tick()

    if now - last >= 1 then
        fps = frames
        frames = 0
        last = now
        label.Text = "FPS : "..fps
    end

    hue = (hue + 0.01) % 1
    label.TextColor3 = Color3.fromHSV(hue, 1, 1)
end)
