socket = require( "socket")
local json = require( "json")
client = socket.connect("localhost",8000)

client:settimeout(0)
client:setoption("keepalive",true)
if not client then 
    print("Error, could not connect to server")
end 

local communication = {}

function communication.sendMessage(message)
    client:send(message)
end

function communication.sendinfo(player)
    local info = {}
    pawnpositions = '{'
    for i, pawn in ipairs(player) do
        if i ~= 4 then
            pawnpositions  =  pawnpositions .. '"pawn'.. i ..'":"'.. pawn.pos .. '", '
        else 
            pawnpositions  =  pawnpositions .. '"pawn'.. i ..'":"'.. pawn.pos .. '"'
        end
    end
    pawnpositions = pawnpositions .. '}'
    client:send(pawnpositions)
end

function communication.receiveInfo()
    
    local data, err = client:receive('*l')
    if data and not err then 
        print(data)
        return data, true
    end
    return nil, false
end

return communication
