term.clear()
local x,y=term.getSize()

local function write(text,x,y)
    term.setCursorPos(x or 1, y or 1)
    term.clearLine()
    term.write(text)
end
term.setCursorPos(1,1)

local tickerStrings = {}

local function ticker(tickertext,line)
    return function()
        local str=tickertext
        local line=line
        for i=1,string.len(str) do
            str=str:sub(2,-1)..str:sub(1,1) 
            write(str,1,line)
            os.sleep(0.15)
        end
        os.sleep(5)
    end
end

local function touchInput()
    while true do
        local ev = table.unpack(table.pack(os.pullEvent()))
        write(ev,1,2)
    end
end
while true do
    parallel.waitForAny(ticker("Play in a regional area for maximum ping! ",1),ticker("Bonkitty bonk, Bonchidk, Boioioioionk",2))
end
