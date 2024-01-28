
local dfpwm = require("cc.audio.dfpwm")
local speaker = peripheral.find("speaker")

--[[General Program Flow
Check for a user specified file
If the exact filename is not found, try completing it
Otherwise, if there is no user file or we could not find it,
try to load from a drive.
And if we can't fall back to internal storage, then error.
]]
if not speaker then error("A speaker is required to run this program, dingus!") end


local args = {...}
local songName = args[1] or "audio.dfpwm"

local amplification=4
local attenuation=1

local function play()
    local decoder = dfpwm.make_decoder()
    for chunk in io.lines(songName, 16 * 1024) do
        local buffer = decoder(chunk)
        for i = 1, #buffer do
            --Volume control
            buffer[i] = math.max(math.min(buffer[i] * amplification, 127), -128)*attenuation
        end
        while not speaker.playAudio(buffer) do
            os.pullEvent("speaker_audio_empty")
        end

        -- The audio processing above can be quite slow and preparing the first batch of audio
        -- may timeout the computer. We sleep to avoid this.
        -- There's definitely better ways of handling this - this is just an example!
        sleep(0.05)
    end
end

while true do
    play()
    for i=0, math.random(10, 30) do
        sleep(1)
    end
end