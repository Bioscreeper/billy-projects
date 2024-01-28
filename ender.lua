--touchscreen ender storage configurator with favorites/bookmarks
-- this one requires sc-peripherals, which is a switchcraft thing (sc3.io)
local chest = peripheral.find("ender_storage")
local monitor = peripheral.find("monitor")
monitor.setTextScale(0.5)
monitor.clear()

local favorites = {
    ["Bin"] = {colors.red,colors.red,colors.red},
    ["Sugar Cane"] = {colors.lime,colors.green,colors.lime},
    ["Leather"] = {colors.brown,colors.white,colors.brown},
    ["Fuel"] = {colors.black,colors.black,colors.gray},
    ["Lava"] = {colors.orange,colors.orange,colors.orange},
    ["Lava Return"] = {colors.orange,colors.orange,colors.white},
    ["Iron"] = {colors.white,colors.white,colors.gray},
    ["Gold"] = {colors.yellow,colors.blue,colors.yellow},
    ["Logs"] = {colors.brown,colors.brown,colors.brown},
    ["Sticks"] = {colors.brown,colors.lime,colors.brown},
    ["Rocks"] = {colors.gray,colors.gray,colors.gray},
    ["BEAF"] = {colors.orange,colors.brown,colors.orange},
    ["Crops"] = {colors.orange,colors.yellow,colors.red},
    ["Rotten Flesh"] = {colors.brown,colors.brown,colors.white},
    ["Cooked Cod"] = {colors.yellow,colors.white,colors.yellow}
}
local fkeys = {}
for k,v in pairs(favorites) do
    table.insert(fkeys,k)
end

local online = {}
local wkeys = {}
local ok,err = pcall(function()
    local data = http.get("https://p.sc3.io/THaX6gxqtp").readAll()
    for _,v in pairs(textutils.unserialiseJSON(data)) do
        online[v.label] = v.colors
        table.insert(wkeys,v.label)
    end
end)
if not ok then printError("Online database not loaded: "..err) end

local selection = 2
local channel = {colors.yellow,colors.white,colors.yellow}
local chs = {"l","m","r"}
local tcol = {
    colors.white,
    colors.orange,
    colors.magenta,
    colors.lightBlue,
    colors.yellow,
    colors.lime,
    colors.pink,
    colors.gray,
    colors.lightGray,
    colors.cyan,
    colors.purple,
    colors.blue,
    colors.brown,
    colors.green,
    colors.red,
    colors.black
}

local function text(x,y,txt,color,bcolor)
    monitor.setCursorPos(x,y)
    if not color then color = colors.white end
    if not bcolor then bcolor = colors.black end
    monitor.setTextColor(color)
    monitor.setBackgroundColor(bcolor)
    monitor.write(txt)
end
local function rect(x,y,w,h,color,highlight)
    local bg = colors.toBlit(color)
    local fg = bg
    if highlight then
        if bg == "0" then
            fg = "f"
        else
            fg = "0" -- white
        end
    end
    for i=x,x+w do
        for j=y,y+h do
            monitor.setCursorPos(i,j)
            monitor.blit("\127",fg,bg)
        end
    end
end

local selectionModified = true
local show = false
local offset = 0
parallel.waitForAny(function() while true do
    -- drawing
    if selectionModified then
        selectionModified = false
        -- ok a little updating because stuff
        chest.setFrequency(channel[1],
                           channel[2],
                           channel[3])
        monitor.clear()
        if show then
            text(3,1,"\x1E")
            text(11,1,"\x1E \x1E")
            for i=1,8 do
                text(1,i+1,show[i+offset])
            end
            text(3,10,"\x1F")
            text(11,10,"\x1F \x1F")
        else
            for i=1,3 do
                local basex = (i*5)-4
                local bcol = channel[i]
                local col = bcol == colors.black and colors.white or colors.black
                if selection == i then
                    text(basex,1," >"..chs[i].."< ",col,bcol)
                else
                    text(basex,1,"  "..chs[i].."  ",col,bcol)
                end
            end
            local opt = channel[selection]
            for i=1,15 do
                rect(i,2,1,8,tcol[i],opt==2^(i-1))
            end
            text(1,10,"Web",colors.white)
            rect(4,10,9,1,tcol[16],opt==2^15)
            text(13,10,"Fav",colors.white)
        end
    else sleep(0) end
end end, function() while true do
    -- handle input
    local e,s,x,y = os.pullEvent("monitor_touch")
    if show then
        if y == 1 then
            if x<6 then
                offset = math.max(offset-2,0)
            elseif x>10 then
                offset = math.max(offset-8,0)
            end
        elseif y == 10 then
            if x<6 then
                offset = math.min(offset+2,#show-8)
            elseif x>10 then
                offset = math.min(offset+8,#show-8)
            end
            offset = math.min(offset+1,#show-8)
        elseif show[y-1+offset] then
            if show == fkeys then
                channel = {table.unpack(favorites[show[y-1+offset]])}
            elseif show == wkeys then
                channel = {table.unpack(online[show[y-1+offset]])}
            end
            show = false
        else
            show = false
        end
    elseif y > 1 and y < 10 then
        channel[selection] = tcol[x]
    elseif y == 10 then
        if x < 4 then
            show = wkeys
            offset = 0
        elseif x > 12 then
            show = fkeys
            offset = 0
        else
            channel[selection] = tcol[16]
        end
    else
        if     x <= 5  then selection = 1
        elseif x <= 10 then selection = 2
        elseif x <= 15 then selection = 3
        end
    end
    selectionModified = true
end end)