-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------


---local socket = require( "socket")
---local client = socket.connect("localhost",8000)

---client:send("Hello")

local boardlib = require "board"
local widget = require "widget"
local halfH = display.contentHeight * 0.5
local halfW = display.contentWidth * 0.5
local diea = nil
local dieb = nil
local movespeed = 1
center = {halfW, halfH}
local redlimit = 24
local yellowlimit = 48
local bluelimit = 72
local greenlimit = 96
local player = display.newCircle(0,0, 5)
local blackies = {}
player.out = false
player.pos = 13
player.name ="lolita"
player.colour = "red"
player.auxlap = false
player.lap = false
--local bkg = display.newImageRect("BioshockInf.jpg", halfW*2,halfH*2)

--bkg.x = halfW
--bkg.y = halfH
local function exitprison(player) --Salir de la prision

    print(player.name, " exitedprison")
    player.out = true
    player.x = globalboard[player.pos].x
    player.y = globalboard[player.pos].y
end

local function possibleMoves(player, diea, dieb) --Calcula que movidas son posibles hacer
    if not player.auxlap then
        boardlib.enablelap(player)
    end
    player.auxlap = player.lap
    if player.tapped then
        total = diea + dieb
        print("Validmoves: ")
        if player.pos + total > greenlimit then
            validtotal = player.pos + total - greenlimit
            validtotal = boardlib.transPlayable(validtotal, player.colour, player.lap)
            player.validmoves = {validtotal}
        else
            print("Playerpos: ", player.pos)
            total = boardlib.transPlayable(player.pos + total, player.colour, player.lap)
            player.validmoves = {total}
        end
        for i, cell in ipairs(player.validmoves) do
    
            globalboard[cell]:setFillColor(.35,.2,.86)
        end
        print("---------------")
    end
end

function restoreColour(player) 
    for i, cell in ipairs(player.validmoves) do
        if table.indexOf(blackies, cell) == nil then
            colour = boardlib.tellColour(cell)
            print(colour)
            if colour == "solidred" then
                globalboard[cell]:setFillColor(1, 0, 0)
            elseif colour == "solidyellow" then
                globalboard[cell]:setFillColor(1,1,0)
            elseif colour == "solidblue" then 
                globalboard[cell]:setFillColor(0,0,1)
            elseif colour == "solidgreen" then 
                globalboard[cell]:setFillColor(0,1,0)
            else 
                globalboard[cell]:setFillColor(1,1,1)
            end 
        else 
            globalboard[cell]:setFillColor(.2,.2,.2)
        end

    end
end

function player:tap(event)
    player.tapped = true
    if player.out then
        if player.rolled then
            possibleMoves(player,diea, dieb)
        end
    player.rolled = false
    end
end 
function movehorizontal(player, tile)
    transition.moveTo(player, {x = tile.x, 500})
end
function tapListener(event)
    if player.tapped and player.validmoves ~= nil then
        for i, cell in ipairs(player.validmoves) do
            tile = globalboard[cell]
            if (event.target == tile) then
               transition.moveTo(player, {y = tile.y, 500, transition=easing.inOutExpo, onComplete = movehorizontal(player, tile)})
                player.pos = cell
                restoreColour(player)
                return true
            end
        end
    end
    return false
end




player:addEventListener( "tap", player)

local function roll( event )
    local filename = "dice"
    local extension = ".png"
    if player.out then
        player.rolled = true
    end
    if ( "ended" == event.phase ) then
        diea=math.random(1,6)
        dieb=math.random(1,6)
        local rolleda = display.newImageRect(filename..diea..extension,50,50)
        rolleda.x, rolleda.y = 50, 125
        local rolledb = display.newImageRect(filename..dieb..extension,50,50)
        rolledb.x, rolledb.y = 100, 125
    end
    if (diea == dieb and diea ~= nil and not player.out) then
        exitprison(player)
    end

end
 
-- Boton creado (Tipo de Widget)
local rolldice = widget.newButton(
    {
        width = 150,
        height = 20,
        defaultFile = "rollbutton.png",
        id = "rolldice",
        label = "Lanzar dados",
        labelColor = { default={ 1, 1, 1, 1 }, over={ .2, .2, .2,.2} },
        onEvent = roll
    }
)



skypos = boardlib.toScreen({0,-70},center)
sky = display.newCircle(skypos[1], skypos[2],30)
sky:setFillColor(0,1,1)

homegenpos = {-99,32}
homeredpos = homegenpos
homeredpos = boardlib.toScreen(homeredpos, center)
homered = display.newRect(homeredpos[1], homeredpos[2], 72, 78)
homered.x = homeredpos[1]
homered.y = homeredpos[2]

homeygreenpos = {homegenpos[1]*-1,homegenpos[2]}
homeygreenpos = boardlib.toScreen(homeygreenpos, center)
homegreen = display.newRect(homeygreenpos[1], homeygreenpos[2], 72, 78)
homegreen.x = homeygreenpos[1]
homegreen.y = homeygreenpos[2]

homegenpos = {-99,-172}
homebluepos = {homegenpos[1],homegenpos[2]}
homebluepos = boardlib.toScreen(homebluepos, center)
homeblue = display.newRect(homebluepos[1], homebluepos[2], 72, 78)
homeblue.x = homebluepos[1]
homeblue.y = homebluepos[2]

homegenpos = {-99,-172}
homeyellowpos = {homegenpos[1],homegenpos[2]}
homeyellowpos = boardlib.toScreen(homeyellowpos, center)
homeyellow = display.newRect(homeyellowpos[1], homeyellowpos[2], 72, 78)
homeyellow.x = homeyellowpos[1]
homeyellow.y = homeyellowpos[2]

homegenpos = {-99,-172}
homebluepos = {homegenpos[1]*-1,homegenpos[2]}
homebluepos = boardlib.toScreen(homebluepos, center)
homeblue = display.newRect(homebluepos[1], homebluepos[2], 72, 78)
homeblue.x = homebluepos[1]
homeblue.y = homebluepos[2]

homered:setFillColor(.61,0,0.59)
homeblue:setFillColor(.61,0,0.59)
homegreen:setFillColor(.61,0,0.59)
homeyellow:setFillColor(.61,0,0.59)

-- Se dibuja el tablero
globalboard, blackies = boardlib.drawboard()
rolldice.x = 93
rolldice.y = halfH *2 -15
testnum = 0
for i, tile in ipairs(globalboard) do
    tile:addEventListener("tap", tapListener)
end

player.x = homeredpos[1]+10
player.y = homeredpos[2]
player:toFront()