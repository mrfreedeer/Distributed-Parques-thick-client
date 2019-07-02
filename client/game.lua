-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

local everything
local boardlib = require "board"
local comms = require "communication"
local widget = require "widget"
local json = require ("json")

local halfH = display.contentHeight * 0.5
local halfW = display.contentWidth * 0.5
local diea = nil
local dieb = nil
local movespeed = 1
local center = {halfW, halfH}
local redlimit = 24
local globalboard
local blackies
local yellowlimit = 48
local bluelimit = 72
local greenlimit = 96
local player = {}
local blackies = {}
local tappedpawn = nil
local otherplayersinfo = false
local otherPlayers = {}
local start = false



player.name ="lolita"
player.out = false
player.colour = "red"
player.rolled = false

function tellHomeColour(player)
    if player.colour == "red" then
        homec = homeredpos 
    elseif player.colour == "blue" then
        homec = homebluepos 
    elseif player.colour == "green" then
        homec = homegreenpos
    elseif player.colour == "yellow" then
        homec = homeyellowpos
    end
    return homec
end

-- Dibuja las fichas en la cárcel
function drawInJail(player, homecolour)
    player[1].x = homecolour[1]-20
    player[1].y = homecolour[2]-20
    player[2].x = homecolour[1]+20
    player[2].y = homecolour[2]-20
    player[3].x = homecolour[1]-20
    player[3].y = homecolour[2]+20
    player[4].x = homecolour[1]+20
    player[4].y = homecolour[2]+20
end

function createplayer(player)
    for i=1,4 do
       circle = display.newCircle(0,0,5)
       circle.out = false
       circle.auxlap = false
       circle.lap = false
       circle.colour = player.colour
        if player.colour == "red" then
            circle.pos = 13
            circle:setFillColor(1,0,0)
        elseif player.colour == "yellow" then 
            circle.pos = 35
            circle:setFillColor(1,1,0)
        elseif player.colour == "blue" then
            circle:setFillColor(0,0,1)
            circle.pos = 61
        elseif player.colour == "green" then
            circle:setFillColor(0,1,0)
            circle.pos = 85
        end
        circle:setStrokeColor(.2,.2,.2)
        circle.strokeWidth = 1
        table.insert(player,circle)
    end
end

createplayer(player)


--local bkg = display.newImageRect("BioshockInf.jpg", halfW*2,halfH*2)

--bkg.x = halfW
--bkg.y = halfH
local function exitprison(player) --Salir de la prision

    print(player.name, " exitedprison")
    player.out = true
    for i, pawn in ipairs(player) do
        pawn.out = true
        pawn.x = globalboard[pawn.pos].x
        pawn.y = globalboard[pawn.pos].y
    end 
end



local function possibleMoves(pawn, diea, dieb) --Calcula que movidas son posibles hacer
    if not pawn.auxlap then
        boardlib.enablelap(pawn)
    end
    pawn.auxlap = pawn.lap
    if pawn.tapped then
        total = diea + dieb
        if pawn.pos + total > greenlimit then
            if pawn.pos + diea > greenlimit then
                validiea = pawn.pos + diea - greenlimit
            end
            if pawn.pos + dieb > greenlimit then
                validieb = pawn.pos + dieb - greenlimit
            end
            validtotal = pawn.pos + total - greenlimit
            validtotal = boardlib.transPlayable(validtotal, pawn.colour, pawn.lap)
            validiea = boardlib.transPlayable(validiea, pawn.colour, pawn.lap)
            validieb = boardlib.transPlayable(validieb, pawn.colour, pawn.lap)
            pawn.validmoves = {validtotal, validiea, validieb}
        else
            total = boardlib.transPlayable(pawn.pos + total, pawn.colour, pawn.lap)
            validiea = boardlib.transPlayable(pawn.pos + diea, pawn.colour, pawn.lap)
            validieb = boardlib.transPlayable(pawn.pos + dieb, pawn.colour, pawn.lap)
            pawn.validmoves = {total, validiea, validieb}
        end
        print("Validmoves:")
        takeout = table.indexOf(pawn.validmoves, pawn.pos)
        if takeout ~= nil then
            table.remove(pawn.validmoves, takeout)
        end
        for i, cell in ipairs(pawn.validmoves) do
        print(cell)
            globalboard[cell]:setFillColor(.35,.2,.86)
        end
    end
end

function restoreColour(pawn) 
    for i, cell in ipairs(pawn.validmoves) do
        if table.indexOf(blackies, cell) == nil then
            colour = boardlib.tellColour(cell)
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

function playertap(event)
    event.target.tapped = true  
    print(player.rolled, event.target.out, event.target.tapped)
    if event.target.out then
        if player.rolled then
            possibleMoves(event.target,diea, dieb)
            tappedpawn = event.target
        end
    end
end 
function movehorizontal(player, tile)
    transition.moveTo(player, {x = tile.x, 500})
end
function tapListener(event)
    pawn = tappedpawn
    if pawn.tapped and pawn.validmoves ~= nil then
        for i, cell in ipairs(pawn.validmoves) do
            tile = globalboard[cell]
            if (event.target == tile) then
               transition.moveTo(pawn, {y = tile.y, 500, transition=easing.inOutExpo, onComplete = movehorizontal(pawn, tile)})
                pawn.pos = cell
                restoreColour(pawn)
                pawn.tapped = false

                if cell == pawn.validmoves[1] then
                    diea = 0
                    dieb = 0
                elseif cell == pawn.validmoves[2] then
                    diea = 0
                else
                    dieb = 0
                end 
                print("Dice: ", diea, dieb)
                if diea == 0 and dieb == 0 then
                    player.rolled = false
                end
                return true
            end
        end
    end

    return false
end



for i, pawn in ipairs(player) do
    pawn:addEventListener( "tap", playertap)
end

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



rolldice.x = 93
rolldice.y = halfH *2 -15
testnum = 0





----------------

local function processInfo()
    data, incoming = comms.receiveInfo()
        if incoming then
            if data ~= nil then 
                decoded = json.decode(data)
                if not otherplayersinfo then
                    if decoded.playersQuantity ~=nil then
                        otherPlayers = boardlib.drawOtherPlayers(decoded.playersQuantity, player.colour)
                        print(otherPlayers[1][1].pos)
                        for _, other_player in ipairs(otherPlayers) do 
                            otherhomecolour = tellHomeColour(other_player)
                            drawInJail(other_player, otherhomecolour)
                        end 
                        otherplayersinfo = true
                        start = true
                    end
                elseif start then 
                    print(decoded)
                    if decoded.transition then 
                        otherPlayers = boardlib.transitionOtherPlayers(otherPlayers, decoded.playerspositions, globalboard)
                    end
                end 
            end
        end

end

local s_loop = timer.performWithDelay(50, processInfo, -1)

comms.sendinfo(player)



--------------------------------------------------
function scene:create(event)
    local sceneGroup = self.view
        
    skypos = boardlib.toScreen({0,-70},center)
    sky = display.newCircle(skypos[1], skypos[2],30)
    sky:setFillColor(0,1,1)

    homegenpos = {-99,32}
    homeredpos = homegenpos
    homeredpos = boardlib.toScreen(homeredpos, center)
    homered = display.newRect(homeredpos[1], homeredpos[2], 72, 78)
    homered.x = homeredpos[1]
    homered.y = homeredpos[2]

    homegreenpos = {homegenpos[1]*-1,homegenpos[2]}
    homegreenpos = boardlib.toScreen(homegreenpos, center)
    homegreen = display.newRect(homegreenpos[1], homegreenpos[2], 72, 78)
    homegreen.x = homegreenpos[1]
    homegreen.y = homegreenpos[2]

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
    everything = display.newGroup()

    globalboard, blackies = boardlib.drawboard(everything, center)

    for i, tile in ipairs(globalboard) do
        tile:addEventListener("tap", tapListener)
    end
    homecolour = tellHomeColour(player)
    drawInJail(player, homecolour)



    for i, pawn in ipairs(player) do
        pawn:toFront()
    end

    sceneGroup:insert(everything)
    
end

function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene