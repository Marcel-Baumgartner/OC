local GUI = require("GUI")

-- Init

local workspace = GUI.workspace()
workspace:addChild(GUI.panel(1, 1, workspace.width, workspace.height, 0xe6e6e6))

-- Startpage

local startpage_open_audio_button = workspace:addChild(GUI.framedButton(2, 2, 30, 3, 0xFFFFFF, 0xFFFFFF, 0x6b9fff, 0x6b9fff, "Open Audio"))
startpage_open_audio_button.onTouch = startpage_open_audio_button_click

-- Audio Panel

local audio_panel_play_button = workspace:addChild(GUI.framedButton(2, 4, 30, 3, 0xFFFFFF, 0xFFFFFF, 0x6b9fff, 0x6b9fff, "Play"))
audio_panel_play_button.onTouch = audio_panel_play_button_click

-- Panel Switcher

function hideAll()
    startpage_open_audio_button.hidden = true
    audio_panel_play_button.hidden = true
    fdraw()
end
function showStartpage()
    hideAll()
    startpage_open_audio_button.hidden = false
    fdraw()
end
function showAudioPanel()
    hideAll()
    audio_panel_play_button.hidden = false
    fdraw()
end

-- Other

function fdraw()
    workspace:draw(true)
end

-- Callbacks

function startpage_open_audio_button_click ()
    showAudioPanel()
end

function audio_panel_play_button_click()
    GUI.alert("Play")
end

hideAll()
showStartpage()

fdraw()
workspace:start()