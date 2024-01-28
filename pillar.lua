local function selFirst()
    local count = turtle.getItemCount()
    if count > 0 then return end
    for i = 1, 16 do
      if turtle.getItemCount(i) > 0 then
        turtle.select(i)
        return true
      end
    end
    error("No items")
end

while true do
    if turtle.detectUp() then break end
    for i=1,4 do
        selFirst()
        turtle.place()
        turtle.turnRight()
    end
    turtle.up()
end