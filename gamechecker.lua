-- This script will check the game PlaceId and execute a loadstring depending on it

local gameId = game.PlaceId

-- Function to execute the corresponding loadstring based on the game PlaceId
local function RunGameScript()
    if gameId == 142823291 then  -- Murder Mystery 2 (MM2)
        -- Load Murder Mystery 2 specific script
        print("Running Murder Mystery 2 script")
        loadstring(game:HttpGet(""))()  -- Example, can be replaced with MM2-specific script
    elseif gameId == 123456789 then  -- Another game (replace with real ID)
        -- Load custom script for this game
        print("Running Another Game script")
        loadstring(game:HttpGet("https://example.com/custom-script"))()  -- Example, replace with actual URL or script
    else
        -- Default script for any other game
        print("Running Default Script")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/KeanXR/INF-YIELD/refs/heads/main/v6.0.0"))()  -- Example, can be replaced with default script
    end
end

-- Run the script
RunGameScript()
