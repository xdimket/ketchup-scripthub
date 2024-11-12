-- ///////////// MURDER MYSTERY 2 ESP SCRIPT ADD-ON /////////////

-- First, let's assume Rayfield is already loaded from the previous script.
-- We're adding the new section and toggle functionality onto the existing UI.

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local espEnabled = false
local espObjects = {}

-- ///////////// FUNCTION TO CREATE ESP FOR PLAYER /////////////

local function CreateESP(player, roleColor, isSpecial)
    -- Create ESP BillboardGui
    local espGui = Instance.new("BillboardGui", player.Character:FindFirstChild("Head"))
    espGui.Name = "RoleESP"
    espGui.Size = UDim2.new(3, 0, 3, 0)  -- Increased size for larger text
    espGui.AlwaysOnTop = true

    local label = Instance.new("TextLabel", espGui)
    label.Text = player.Name
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = roleColor
    label.TextStrokeTransparency = 0.5
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold  -- Bold font for visibility

    espObjects[player] = {espGui = espGui}

    -- If the player is a special role, create a box around them
    if isSpecial then
        local box = Instance.new("BoxHandleAdornment")
        box.Adornee = player.Character
        box.Size = Vector3.new(4, 7, 4) -- Adjust dimensions based on character size
        box.Color3 = roleColor
        box.Transparency = 0.4
        box.AlwaysOnTop = true
        box.ZIndex = 10
        box.Parent = player.Character:FindFirstChild("HumanoidRootPart")
        
        espObjects[player].box = box
    end
end

-- ///////////// FUNCTION TO REMOVE ESP /////////////

local function RemoveESP(player)
    if espObjects[player] then
        if espObjects[player].espGui then
            espObjects[player].espGui:Destroy()
        end
        if espObjects[player].box then
            espObjects[player].box:Destroy()
        end
        espObjects[player] = nil
    end
end

-- ///////////// FUNCTION TO CHECK PLAYER ROLES /////////////

local function CheckPlayerRoles()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local roleColor = Color3.fromRGB(128, 128, 128) -- Default to grey for innocent
            local isSpecial = false

            -- Check backpack and character tools for role items
            local hasGun = player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun")
            local hasKnife = player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife")

            if hasGun then
                roleColor = Color3.fromRGB(0, 0, 255) -- Blue for sheriff
                isSpecial = true
            elseif hasKnife then
                roleColor = Color3.fromRGB(255, 0, 0) -- Red for murderer
                isSpecial = true
            end

            -- Update or create ESP based on role color and special status
            if espObjects[player] then
                espObjects[player].espGui.TextLabel.TextColor3 = roleColor
                if espObjects[player].box then
                    espObjects[player].box.Color3 = roleColor
                end
            else
                CreateESP(player, roleColor, isSpecial)
            end
        else
            -- Remove ESP if character or head is missing
            RemoveESP(player)
        end
    end
end

-- ///////////// FUNCTION TO ENABLE ESP /////////////

local function EnableESP()
    espEnabled = true
    -- Continuously update roles if ESP is enabled
    while espEnabled do
        CheckPlayerRoles()
        wait(1)
    end
end

-- ///////////// FUNCTION TO DISABLE ESP /////////////

local function DisableESP()
    espEnabled = false
    -- Remove all ESP when toggling off
    for _, esp in pairs(espObjects) do
        if esp.espGui then esp.espGui:Destroy() end
        if esp.box then esp.box:Destroy() end
    end
    espObjects = {}
end

-- ///////////// ADDING TO EXISTING UI (Rayfield) /////////////

-- Assuming `MainTab` already exists from previous script, we'll add a new section and button under it.
local MM2Section = MainTab:CreateSection("Murder Mystery 2")

-- Toggle button for ESP in Murder Mystery 2 section
local ToggleESPToggle = MainTab:CreateToggle({
    Name = "Toggle MM2 ESP",
    CurrentValue = false,
    Flag = "MM2_ESP_Toggle",
    Callback = function(Value)
        espEnabled = Value

        if espEnabled then
            print("MM2 ESP Enabled")
            -- Run the ESP script when enabled
            EnableESP()
        else
            print("MM2 ESP Disabled")
            -- Stop the ESP when disabled
            DisableESP()
        end
    end,
})

-- This script should now be able to run alongside your existing Rayfield UI,
-- creating a new section called "Murder Mystery 2" and a toggle button to control ESP.
