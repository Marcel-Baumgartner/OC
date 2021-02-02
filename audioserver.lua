local component = require("component")
local modem = component.modem
local fs = require("filesystem")
local event = require("event")

local port = 45

modem.open(45)

print ("Opened Audio Server on port " .. tostring(port))

while true
do
    print ("Waiting for incomming connection")

    _, _, from, _, _, message = event.pull("modem_message")

    print ("Data received from " .. tostring(from))

    os.execute("sleep 2")

    if fs.exists(tostring(message)) == false 
    then
        modem.send(tostring(from), 46, "404")
        print ("File not found " .. tostring(message))
    else
        local handle = io.popen("cat " .. tostring(message))
        local file = handle:read("*a")
        handle:close()

        modem.send(tostring(from), 46, file)
    end
end