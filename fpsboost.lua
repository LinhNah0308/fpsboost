local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- ===== HIDE CHARACTER =====
local function HideCharacter(char)
    for _,v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 1
            v.CanCollide = false
            v.CastShadow = false
        elseif v:IsA("Decal") then
            v.Transparency = 1
        elseif v:IsA("Accessory") then
            local h = v:FindFirstChild("Handle")
            if h then
                h.Transparency = 1
                h.CanCollide = false
            end
        end
    end

    if char:FindFirstChild("Humanoid") then
        char.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    end
end

if Player.Character then
    HideCharacter(Player.Character)
end

Player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    HideCharacter(char)
end)

-- ===== HIDE BUILDINGS (SAFE MODE) =====
for _,v in pairs(Workspace:GetDescendants()) do
    if v:IsA("BasePart") then
        -- Bỏ qua nhân vật & NPC
        if v:FindFirstAncestorOfClass("Model") then
            local m = v:FindFirstAncestorOfClass("Model")
            if m:FindFirstChildOfClass("Humanoid") then
                continue
            end
        end

        -- Điều kiện giống "toà nhà"
        if v.Anchored == true
        and (v.Size.X > 10 or v.Size.Y > 10 or v.Size.Z > 10) then
            v.Transparency = 1
            v.CanCollide = false
            v.CastShadow = false
        end
    end
end
