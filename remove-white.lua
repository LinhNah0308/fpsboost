-- REMOVE FULL WHITE SCREEN AFTER 4S + MENU TOGGLE UI HACK

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local UIS = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ================= DELAY =================
task.wait(4)

-- ================= RESET LIGHTING =================
pcall(function()
    Lighting.Brightness = 2
    Lighting.ExposureCompensation = 0
    Lighting.FogStart = 0
    Lighting.FogEnd = 100000
    Lighting.Ambient = Color3.fromRGB(128,128,128)
    Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)

    for _,v in pairs(Lighting:GetChildren()) do
        if v:IsA("ColorCorrectionEffect")
        or v:IsA("BloomEffect")
        or v:IsA("BlurEffect")
        or v:IsA("SunRaysEffect") then
            v:Destroy()
        end
    end
end)

-- ================= WHITE SCREEN CHECK =================
local function IsFullWhiteScreen(gui)
    if not gui:IsA("Frame") then return false end
    if gui.BackgroundTransparency > 0.15 then return false end
    if gui.BackgroundColor3 ~= Color3.fromRGB(255,255,255) then return false end

    local s = gui.AbsoluteSize
    local c = Camera.ViewportSize
    return s.X >= c.X - 5 and s.Y >= c.Y - 5
end

local function RemoveWhite(parent)
    for _,v in pairs(parent:GetDescendants()) do
        if IsFullWhiteScreen(v) then
            v:Destroy()
        end
    end
end

RemoveWhite(CoreGui)
RemoveWhite(Player:WaitForChild("PlayerGui"))

CoreGui.DescendantAdded:Connect(function(v)
    task.wait()
    if IsFullWhiteScreen(v) then
        v:Destroy()
    end
end)

-- ================= UI MENU =================
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "WhiteScreenRemoverUI"
gui.ResetOnSpawn = false

local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.fromOffset(120,40)
toggleBtn.Position = UDim2.fromOffset(50,200)
toggleBtn.Text = "MENU"
toggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.BorderSizePixel = 0
toggleBtn.Active = true
toggleBtn.Draggable = true

local menu = Instance.new("Frame", gui)
menu.Size = UDim2.fromOffset(200,120)
menu.Position = UDim2.fromOffset(50,250)
menu.BackgroundColor3 = Color3.fromRGB(20,20,20)
menu.BorderSizePixel = 0
menu.Visible = true

local hideBtn = Instance.new("TextButton", menu)
hideBtn.Size = UDim2.fromOffset(180,40)
hideBtn.Position = UDim2.fromOffset(10,40)
hideBtn.Text = "Ẩn / Hiện UI Hack"
hideBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
hideBtn.TextColor3 = Color3.new(1,1,1)
hideBtn.BorderSizePixel = 0

-- ================= TOGGLE MENU =================
toggleBtn.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
end)

-- ================= HIDE / SHOW OTHER HACK UI =================
local hidden = false
hideBtn.MouseButton1Click:Connect(function()
    hidden = not hidden
    for _,v in pairs(CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v ~= gui then
            v.Enabled = not hidden
        end
    end
end)

-- ================= NOTIFICATION =================
pcall(function()
    StarterGui:SetCore("SendNotification",{
        Title = "-Notification-",
        Text = "Removed ✅",
        Duration = 3
    })
end)
