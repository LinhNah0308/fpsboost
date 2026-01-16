local Players = game:GetService("Players")
local Player = Players.LocalPlayer

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

    -- Xoá tên trên đầu
    if char:FindFirstChild("Humanoid") then
        char.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    end
end

-- Áp dụng ngay
if Player.Character then
    HideCharacter(Player.Character)
end

-- Khi respawn vẫn bị xoá
Player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    HideCharacter(char)
end)
