local GUI = require("GUI")

-- Init

local workspace = GUI.workspace()
workspace:addChild(GUI.panel(1, 1, workspace.width, workspace.height, 0xe6e6e6))

-- Startpage

local startpage_open_audio_button = workspace:addChild(GUI.framedButton(2, 22, 30, 3, 0xFFFFFF, 0xFFFFFF, 0x6b9fff, 0x6b9fff, "Open Audio"))
startpage_open_audio_button.onTouch = startpage_open_audio_button_click

-- Callbacks

function startpage_open_audio_button_click ()
    GUI.alert("Audio Not found")
end

workspace:draw()
workspace:start()