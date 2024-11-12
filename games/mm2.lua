-- /////////////  INITIALIZE RAYFIELD UI  /////////////

-- First, let's assume Rayfield is already loaded from the previous script.
-- We're adding the new section and toggle functionality onto the existing UI.
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local MainWindow = Rayfield:CreateWindow({
   Name = "Ketchup's Script Hub",
   LoadingTitle = "Scripts",
   LoadingSubtitle = "by ketchup",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = "Ketchup Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})
-- /////////////  CREATE TABS  /////////////
local MainTab = MainWindow:CreateTab("Main", 4483362458)
local PlayerTab = MainWindow:CreateTab("Player", 4483362458)
-- /////////////  GENERAL SECTION  /////////////
local GeneralSection = MainTab:CreateSection("General")
local IYButton = MainTab:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/KeanXR/INF-YIELD/refs/heads/main/v6.0.0'))()
   end,
})
-- /////////////  DEX SECTION  /////////////
local DexSection = MainTab:CreateSection("Dex")
local DexButton = MainTab:CreateButton({
   Name = "Dex",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/DEX-Explorer/main/Mobile.lua"))()
   end,
})
-- /////////////  REMOTES SECTION  /////////////
local RemotesSection = MainTab:CreateSection("Remotes")
local TurtleSpyButton = MainTab:CreateButton({
   Name = "SolSpy",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/xdimket/ketchup-scripthub/refs/heads/main/solspy.lua"))()
   end,
})
-- /////////////  PLAYER TAB SECTIONS  /////////////
local PlayerSection = PlayerTab:CreateSection("Player")
local WalkSpeedSlider = PlayerTab:CreateSlider({
    Name = "Player WalkSpeed",
    Range = {0, 200},
    Increment = 1,
    Suffix = "WalkSpeed",
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})
local JumpPowerSlider = PlayerTab:CreateSlider({
    Name = "Player JumpPower",
    Range = {0, 300},
    Increment = 5,
    Suffix = "JumpPower",
    CurrentValue = 50,
    Flag = "JumpPowerSlider",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end,
})
local ResetButton = PlayerTab:CreateButton({
    Name = "Reset WalkSpeed & JumpPower",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        WalkSpeedSlider:Set(16)
        JumpPowerSlider:Set(50)
    end,
})
-- /////////////  FORCE WALK AND JUMP SPEED TOGGLE  /////////////
local ForceWalkJump = false
local ForceWalkJumpToggle = PlayerTab:CreateToggle({
    Name = "Force Walk and Jump Speed",
    CurrentValue = false,
    Flag = "ForceWalkJumpToggle",
    Callback = function(Value)
        ForceWalkJump = Value
        if ForceWalkJump then
            spawn(function()
                while ForceWalkJump do
                    local humanoid = game.Players.LocalPlayer.Character.Humanoid
                    humanoid.WalkSpeed = WalkSpeedSlider:Get()
                    humanoid.JumpPower = JumpPowerSlider:Get()
                    wait(0.5)
                end
            end)
        end
    end,
})
-- /////////////  FLYING SECTION  /////////////
local FlyingSection = PlayerTab:CreateSection("Flying")
-- /////////////  FLY SCRIPT SETUP  /////////////
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local torso = character:WaitForChild("Head")
local flying = false
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local flightSpeed = 50 -- Initial flight speed, can be adjusted with slider
local mouse = player:GetMouse()
-- Function to update flight speed
local function UpdateFlightSpeed(newSpeed)
    flightSpeed = newSpeed
end
-- /////////////  FLY FUNCTION WITHOUT MOVEMENT TILT  /////////////
local function Fly()
    local bg = Instance.new("BodyGyro", torso)
    bg.P = 9e4
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    
    local bv = Instance.new("BodyVelocity", torso)
    bv.velocity = Vector3.new(0, 0.1, 0)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
    repeat wait()
        player.Character.Humanoid.PlatformStand = true
        -- Set fixed velocity based on player controls and flight speed
        bv.velocity = ((workspace.CurrentCamera.CFrame.LookVector * (ctrl.f + ctrl.b)) +
                      ((workspace.CurrentCamera.CFrame * CFrame.new(ctrl.l + ctrl.r, 0, 0).Position) - 
                      workspace.CurrentCamera.CFrame.Position)) * flightSpeed
        -- Rotate player to face the direction of the camera
        bg.cframe = workspace.CurrentCamera.CFrame
    until not flying
    -- Reset flight settings when stopped
    ctrl = {f = 0, b = 0, l = 0, r = 0}
    bg:Destroy()
    bv:Destroy()
    player.Character.Humanoid.PlatformStand = false
end
-- /////////////  PLAYER CONTROLS FOR FLY MOVEMENT  /////////////
mouse.KeyDown:Connect(function(key)
    if key:lower() == "w" then ctrl.f = 1
    elseif key:lower() == "s" then ctrl.b = -1
    elseif key:lower() == "a" then ctrl.l = -1
    elseif key:lower() == "d" then ctrl.r = 1
    end
end)
mouse.KeyUp:Connect(function(key)
    if key:lower() == "w" then ctrl.f = 0
    elseif key:lower() == "s" then ctrl.b = 0
    elseif key:lower() == "a" then ctrl.l = 0
    elseif key:lower() == "d" then ctrl.r = 0
    end
end)
-- /////////////  FLY TOGGLE BUTTON  /////////////
local FlightToggle = PlayerTab:CreateToggle({
    Name = "Toggle Flight",
    CurrentValue = false,
    Flag = "FlightToggle",
    Callback = function(Value)
        if Value then
            flying = true
            Fly()
        else
            flying = false
        end
    end,
})
-- /////////////  FLIGHT SPEED SLIDER  /////////////
local FlightSpeedSlider = PlayerTab:CreateSlider({
    Name = "Flight Speed",
    Range = {10, 400},
    Increment = 10,
    Suffix = "Speed",
    CurrentValue = 50,
    Flag = "FlightSpeedSlider",
    Callback = function(Value)
        UpdateFlightSpeed(Value)
    end,
})
local ResetFlightSpeedButton = PlayerTab:CreateButton({
    Name = "Reset Flight Speed",
    Callback = function()
        flightSpeed = 50 -- Reset to default flight speed
        FlightSpeedSlider:Set(50) -- Update the slider to match the reset value
    end,
})
-- /////////////////// MM2 /////////////////////
local MM2Section = MainTab:CreateSection("MM2")
-- ///////////// ESP VARIABLES /////////////

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local espObjects = {}
local espEnabled = false

-- ///////////// FUNCTION TO CREATE ESP FOR PLAYER AND GUNDROP /////////////

local function CreateESP(player, roleColor, isSpecial)
    -- Create ESP BillboardGui for player
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
    label.Font = Enum.Font.SourceSansBold

    espObjects[player] = {espGui = espGui}

    -- If the player is a special role, create a box around them
    if isSpecial then
        local box = Instance.new("BoxHandleAdornment")
        box.Adornee = player.Character:FindFirstChild("HumanoidRootPart")
        box.Size = Vector3.new(3, 6, 3) -- Adjusted to be slightly smaller
        box.Color3 = roleColor
        box.Transparency = 0.4
        box.AlwaysOnTop = true
        box.Parent = player.Character:FindFirstChild("HumanoidRootPart")
        
        espObjects[player].box = box
    end

    -- Check if GunDrop exists in the workspace and create a green box around it if found
    local gunDropPart = workspace:FindFirstChild("GunDrop", true)
    if gunDropPart and not espObjects["GunDrop"] then
        local gunDropBox = Instance.new("BoxHandleAdornment")
        gunDropBox.Adornee = gunDropPart
        gunDropBox.Size = Vector3.new(3, 3, 3) -- Smaller box size for GunDrop
        gunDropBox.Color3 = Color3.fromRGB(0, 255, 0) -- Green color
        gunDropBox.Transparency = 0.4
        gunDropBox.AlwaysOnTop = true
        gunDropBox.Parent = gunDropPart

        espObjects["GunDrop"] = gunDropBox
    end
end

-- ///////////// FUNCTION TO REMOVE ESP FOR PLAYER AND GUNDROP /////////////

local function RemoveESP(player)
    -- Remove ESP for player
    if espObjects[player] then
        if espObjects[player].espGui then
            espObjects[player].espGui:Destroy()
        end
        if espObjects[player].box then
            espObjects[player].box:Destroy()
        end
        espObjects[player] = nil
    end

    -- Remove ESP for GunDrop if it exists
    if espObjects["GunDrop"] then
        espObjects["GunDrop"]:Destroy()
        espObjects["GunDrop"] = nil
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

-- ///////////// FUNCTION TO ENABLE AND DISABLE ESP /////////////

local function EnableESP()
    espEnabled = true
    -- Continuously update roles if ESP is enabled
    while espEnabled do
        CheckPlayerRoles()
        wait(1)
    end
end

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
if MainTab then
    local MM2Tab = MainWindow:CreateTab("Murder Mystery 2")
    local ToggleESPToggle = MM2Tab:CreateToggle({
        Name = "Toggle MM2 ESP",
        CurrentValue = false,
        Flag = "MM2_ESP_Toggle",
        Callback = function(Value)
            espEnabled = Value
            if espEnabled then
                print("MM2 ESP Enabled")
                EnableESP()
            else
                print("MM2 ESP Disabled")
                DisableESP()
            end
        end,
    })
else
    print("Error: MainTab is not available. Ensure Rayfield UI is loaded properly.")
end
