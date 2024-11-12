-- /////////////  CHECK GAME ID AND RUN SCRIPT BASED ON ID /////////////

local gameId = game.PlaceId

-- Debug function to log errors
local function safeLoadScript(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not success then
        print("Error loading script from URL: " .. url)
        print("Error details: " .. result)
    end
end

local function loadGameScript()
    print("Checking game ID: " .. gameId)

    if gameId == 142823291 then -- Murder Mystery 2 (MM2)
        print("Running script for Murder Mystery")
        safeLoadScript('https://raw.githubusercontent.com/xdimket/ketchup-scripthub/refs/heads/main/games/mm2.lua')

    elseif gameId == 123456789 then  -- Replace with a valid game ID (example)
        print("Running script for another game")
        safeLoadScript('https://example.com/')

    else
        print("Unsupported Game")
        safeLoadScript('https://example.com/default-script')
    end
end

loadGameScript()
