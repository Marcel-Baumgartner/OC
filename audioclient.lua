local component = require("component")
local modem = component.modem
local event = require("event")
local tape = component.tape_drive

local port = 44
local dataPort = 46
local serverPort = 45

modem.open(port)
modem.open(46)

function split(pString, pPattern)
    local Table = {}  -- NOTE: use {n = 0} in Lua-5.0
    local fpat = "(.-)" .. pPattern
    local last_end = 1
    local s, e, cap = pString:find(fpat, 1)
    while s do
       if s ~= 1 or cap ~= "" then
      table.insert(Table,cap)
       end
       last_end = e+1
       s, e, cap = pString:find(fpat, last_end)
    end
    if last_end <= #pString then
       cap = pString:sub(last_end)
       table.insert(Table, cap)
    end
    return Table
end

function download (name)
    os.execute("rm " .. name)
    modem.broadcast(45, name)

    _, _, from, port, _, message = event.pull("modem_message")

    if tostring(message) == "404" 
    then
        print ("404 File " .. name .. "not found")
        os.exit()
    else
        file = io.open(name, "w")
        file:write(message)
        file:close()

        print ("Downloaded " .. name)
    end
end

function install (name)

    os.execute("tape write -y " .. name)
    modem.broadcast(43, "I " .. tostring(modem.address))

end

function deletetape (name)
    os.execute("tape wipe -y " .. name)
    modem.broadcast(43, "R " .. tostring(modem.address))
end

function play()
    os.execute("tape play")
    modem.broadcast(43, "P " .. tostring(modem.address))
end

function stop()
    os.execute("tape pause")
    modem.broadcast(43, "S " .. tostring(modem.address))
end

while true
do
    print ("Waiting for incomming connections")

    _, _, from, port, _, message = event.pull("modem_message")

    os.execute("sleep 2")

    print ("Incomming message from " .. tostring(from))

    commands = split(message, " ")

    action = commands[1]

    if action == "download"
    then
        download(commands[2])
        modem.broadcast(43, "D .. " + tostring(modem.address))
    end
    if action == "install"
    then
        install(commands[2])
    end
    if action == "delete"
    then
        deletetape(commands[2])
    end
    if action == "play"
    then
        play()
    end
    if action == "stop"
    then
        stop()
    end
end