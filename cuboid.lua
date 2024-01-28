term.clear()
term.setCursorPos(1,1)
print("BlackRa1n Inc. CubicMiner V1")
print("---------------------------------")

print("Desired Blocks Dug Forwards: ")
input = read()
dz = tonumber(input)
dz0 = dz==0
turned = false

downZ = dz<0
if dz<0 then
 dz = dz*-1
end


print("Desired Blocks Dug Right: ")
input = read()
dx = tonumber(input)
if dx<0 then
 downX = false
elseif dx>0 then
 downX = dx>0
end
if dx<0 then
 dx = dx*-1
end
if dz0 == true then
 dx = dx
else
 dx = dx + 1
end


print("Desired Blocks Dug Down/Up: ")
input = read()
dy = tonumber(input)
if dy<0 then
 downY = true
 dy = dy
else
 downY = false
 dy = dy
end
if dy<0 then
 dy = dy*-1
end
dy = dy + 1
print("Starting...")
