local GUI = require("GUI")
local component = require("component")
local modem = component.modem
local event = require("event")

--------------------------------------------------------------------------------

-- GUI

local workspace = GUI.workspace()
workspace:addChild(GUI.panel(1, 1, workspace.width, workspace.height, 0xb0b0b0))

-- Main Menue
local audioButton = workspace:addChild(GUI.framedButton(2, 2, 30, 3, 0xFFFFFF, 0xFFFFFF, 0x4960de, 0x4960de, "Audio"))
-- Audio System
local playButton = workspace:addChild(GUI.framedButton(2, 4, 30, 3, 0xFFFFFF, 0xFFFFFF, 0x4960de, 0x4960de, "Play"))
local audioNetworkLog = workspace:addChild(GUI.textBox(60, 2, 100, 100, 0xFFFFFF, 0x4960de, {}, 1, 1, 0))

-- Functions

function openAudio()

-- Other
playButton.hidden = false
-- Self
audioButton.hidden = true
audioNetworkLog.hidden = false

workspace:draw()

end

function playSound()
    
end

-- Events

function messageReceived (_, to, from, port, _, message)
    
    if port == 43
    then
        table.insert(audioNetworkLog.lines, "Status [" .. tostring(from) .. "] > " .. tostring(message))
    end
    if port == 44
    then
        table.insert(audioNetworkLog.lines, "Command [" .. tostring(from) .. "] > " .. tostring(message))
    end

    workspace:draw()
end

-- Main Menue
audioButton.onTouch = openAudio
audioButton.hidden = false

-- System Settings

-- Audio Controll

playButton.onTouch = playSound
playButton.hidden = true

table.insert(audioNetworkLog.lines, "Loggin Audio System Traffic")
audioNetworkLog.hidden = true

--------------------------------------------------------------------------------

-- Open Ports

modem.open(43)
modem.open(44)

-- Register Events

event.listen("modem_message", messageReceived)

workspace:draw()
workspace:start()