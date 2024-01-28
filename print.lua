--Definitions
local wrap = require("cc.strings").wrap
local printer = peripheral.find("printer") or error("This program requires a printer")

local args = {...}

if not printer.newPage() then error("Cannot start new page") end

if args[2] then printer.setPageTitle(args[2]) end
--args[1] and fs.exists(args[1]) and not fs.isDir(args[1])
if true then
    print("true returns true, sanity check passed")
    local lines = {}
    do
        print(args[1], fs.exists(args[1]), fs.isDir(args[1]))
        local file = fs.open(args[1])
        repeat
            local line = file.readLine()
            lines[#lines+1] = line
        until not line
        file.close()
    end
    printer.setCursorPos(1,1)
    printer.write(lines[1])
    printer.setCursorPos(1,2)
    printer.write(string.rep("-",25))
    printer.setCursorPos(1,3)
    for k,v in pairs(lines) do
        printer.write(v)
    end
end

if not printer.endPage() then error("File too large to print") end
print("Remaining Ink: "..printer.getInkLevel().."/64 ("..printer.getInkLevel()/64 * 100 .."%)")
print("Remaining Paper: "..printer.getPaperLevel().."/384 ("..printer.getPaperLevel()/384 * 100 .."%)")