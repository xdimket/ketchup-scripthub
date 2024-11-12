-- /////////////  CHECK GAME ID AND RUN SCRIPT BASED ON ID /////////////

local gameId = game.PlaceId


local function loadGameScript()

    if gameId == 142823291 then -- Murder Mystery 2 (MM2)
        print("Running script for Murder Mystery")
        loadstring(game:HttpGet('https://example.com/murder-mystery-script'))()

    elseif gameId == 000000000 then
        print("Running script for ")
        loadstring(game:HttpGet('https://example.com/'))()

    else
        print("Running default script")
        loadstring(game:HttpGet('https://example.com/default-script'))()
    end
end

loadGameScript()
