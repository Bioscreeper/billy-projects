if not turtle then error("No turtle library") end
local w=3
local l=3

for y=0,l do
    for x=0,w do
        turtle.dig()
        if x==w then break end
        turtle.forward()
    end
    if y%1==0 then turn=turtle.turnLeft else turn=turtle.turnRight end
    turn()
    turtle.dig()
    turtle.forward()
    turn()
end