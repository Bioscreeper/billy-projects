sleep(3) --ensure that we hahe a chatbox
local function elevator()
    local floorDistances = {0,30}
    local currentHeight = 0
    local function goToHeight(height)
        local move
        if height > currentHeight then
            move=turtle.up
        elseif height < currentHeight then
            move=turtle.down
        else
            return
        end
        for i=1,math.abs(height-currentHeight) do
            move()
        end
        currentHeight = height 
    end
    --home to bottom
    while not turtle.detectDown() do turtle.down() end

    while true do
        --wait for a call
        local event, user, command, args = os.pullEvent("command")
        if command == "call" and args then
            for k,v in ipairs(args) do
                goToHeight(tonumber(v))
            end
        end
    end

end
elevator()
--If my height is 1 and my target is 2, differential is target-cur
--If my height is 2