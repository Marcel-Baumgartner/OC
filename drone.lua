local modem = component.proxy(component.list("modem")())
while true do
    local e, _, _, _, _, command = computer.pushSignal()
    if e == "modem_message" then
        pcall(load(command))
    end
end