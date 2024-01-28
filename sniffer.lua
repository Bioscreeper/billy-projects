local monitor = peripheral.find("monitor") or error("No Monitor")
monitor.setTextScale(1)
monitor.clear()
monitor.setCursorPos(1,1)
local x,y=monitor.getSize()
for i=1,x do
    monitor.setCursorPos(i,1)
    monitor.blit(" ","f","7")
end
local function writeCentered(text)
    --checkArg(1, text, "string")
    monitor.setCursorPos(math.floor(x/2)-17,1)
    monitor.setBackgroundColor(colours.lightGrey)
    monitor.write("snifflet - for all ur sniffin needz")
    monitor.setBackgroundColor(colours.black)
end

local modems
