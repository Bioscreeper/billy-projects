--File browser
--[

]--


--Definitions
local path = "/"
local x,y=term.getSize()
local function write(text,x,y)
    term.setCursorPos(x or 1, y or 1)
    term.clearLine()
    term.write(text)
end
--Startup
term.clear()
term.setBackgroundColour(colours.grey)
term.setTextColour(colours.lightGrey)

for k,v in pairs(fs.list(path)) do
    write()