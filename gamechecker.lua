local gameId = game.PlaceId

local function RunGameScript()
    if gameId == 142823291 then  -- Murder Mystery 2 (MM2)
        print("Running Murder Mystery 2 script")
        loadstring(game:HttpGet(""))()
    elseif gameId == 85896571713843 then  -- Bubble Gum Simulator INFINITY (BGSI)
        print("Running BGSI Script")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xdimket/ketchup-scripthub/refs/heads/main/Bubble%20Gum%20Simulator%20Infinite"))()
    end
end

RunGameScript()
