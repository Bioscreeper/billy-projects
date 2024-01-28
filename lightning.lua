local speaker = peripheral.find("speaker")
local function play(sound)
    speaker.playSound(sound or "entity.lightning_bolt.impact")
end
while true do
    play()
    sleep(math.random(1, 10)/10)
end