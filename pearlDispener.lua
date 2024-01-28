local BOT_NAME = "&3PearBot" -- You can colour bot names!

while true do
	local event, user, command, args = os.pullEvent("command")

	if command == "pearls" then
		if #args > 0 then
            if args[1] == "refill" then
                local function refill()
                    while true do
                        for i=0,4 do
                            turtle.suckUp()
                        end
                        for i=1,16 do
                            turtle.select(i)
                            turtle.dropDown(16)
                        end
                    end
                end
                local function stop()
                    local event, user, command, args = os.pullEvent("command")
                    if command=="pearls" and args[1] and args[1]=="stop" then
                        return
                    end
                end
                parallel.waitForAny(refill, stop)
            else
                for i=0,4 do
                    turtle.suckDown()
                end
                for i=1,math.min(tonumber(args[1]),16) do
                    turtle.select(i)
                    turtle.drop(16)
                end
            end
		else
			chatbox.tell(user, "Usage: \\pearls <stacks>", BOT_NAME)
		end
	end
end