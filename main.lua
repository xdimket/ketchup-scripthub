-- /////////////  INITIALIZE RAYFIELD UI  /////////////

Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

MainWindow = Rayfield:CreateWindow({
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

local MainTab = MainWindow:CreateTab("Main", 4483362458) -- Renamed here
local PlayerTab = MainWindow:CreateTab("Player", 4483362458)

-- /////////////  GENERAL SECTION  /////////////

local GeneralSection = MainTab:CreateSection("General") -- Renamed here

local IYButton = MainTab:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/KeanXR/INF-YIELD/refs/heads/main/v6.0.0'))()
   end,
})

-- /////////////  DEX SECTION  /////////////

local DexSection = MainTab:CreateSection("Dex") -- Renamed here

 local DexButton = MainTab:CreateButton({
    Name = "Dex",
    Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
    end,
 })

-- /////////////  REMOTES SECTION  /////////////

local RemotesSection = MainTab:CreateSection("Remotes") -- Renamed here

local RSpyButton = MainTab:CreateButton({
   Name = "RSpy",
   Callback = function()
      loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpyBeta.lua"))()
   end,
})
local SigmaSpyButton = MainTab:CreateButton({
    Name = "SigmaSpy",
    Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/depthso/Sigma-Spy/refs/heads/main/Main.lua"), "Sigma Spy")()
    end,
})
local HydroxideButton = MainTab:CreateButton({
    Name = "Hydroxide",
    Callback = function()
       local owner = "Upbolt"
       local branch = "revision"
      
       local function webImport(file)
          return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/Hydroxide/%s/%s.lua"):format(owner, branch, file)), file .. '.lua')()
       end
      
       webImport("init")
       webImport("ui/main")()
    end,
})
-- /////////////  SERVER JOINER SECTION  /////////////

local ServerSection = MainTab:CreateSection("Server Joiner")

-- Initialize TeleportService for server joining
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Create input for Job ID
local JobIDInput = MainTab:CreateInput({
   Name = "Server Job ID",
   PlaceholderText = "Enter server JobID here...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      -- Store the text but don't join yet
   end,
})

-- Create a button to join server by JobID
local JoinServerButton = MainTab:CreateButton({
   Name = "Join Server",
   Callback = function()
      local jobId = JobIDInput.CurrentValue
      jobId = jobId:gsub("[\n\r]", ""):gsub("%s+", "")
      if jobId and jobId ~= "" then
         Rayfield:Notify({
            Title = "Server Joiner",
            Content = "Attempting to join server...",
            Duration = 3,
            Image = 4483362458
         })
         
         -- Get the current place ID
         local placeId = game.PlaceId
         
         -- Using pcall to handle any errors
         local success, errorMsg = pcall(function()
            TeleportService:TeleportToPlaceInstance(placeId, jobId, LocalPlayer)
         end)
         
         if not success then
            Rayfield:Notify({
               Title = "Error",
               Content = "Failed to join: " .. tostring(errorMsg),
               Duration = 5,
               Image = 4483362458
            })
         end
      else
         Rayfield:Notify({
            Title = "Error",
            Content = "Please enter a valid JobID",
            Duration = 3,
            Image = 4483362458
         })
      end
   end,
})

-- Create a button to copy current server's JobID
local GetCurrentJobIDButton = MainTab:CreateButton({
   Name = "Copy Current JobID",
   Callback = function()
      local currentJobId = game.JobId
      
      -- Set the input field to the current JobID
      JobIDInput:Set(currentJobId)
      
      -- Notify the user
      Rayfield:Notify({
         Title = "Current JobID",
         Content = "Current JobID copied: " .. currentJobId,
         Duration = 5,
         Image = 4483362458
      })
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

-- /////////////  RESET FLIGHT SPEED BUTTON  /////////////

local ResetFlightSpeedButton = PlayerTab:CreateButton({
    Name = "Reset Flight Speed",
    Callback = function()
        flightSpeed = 50 -- Reset to default flight speed
        FlightSpeedSlider:Set(50) -- Update the slider to match the reset value
    end,
})
