-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

---local socket = require( "socket")
---local client = socket.connect("localhost",8000)

---client:send("Hello")

local boardlib = require "board"
local widget = require "widget"
local halfH = display.contentHeight * 0.5
local halfW = display.contentWidth * 0.5
center = {halfW, halfH}

--local bkg = display.newImageRect("BioshockInf.jpg", halfW*2,halfH*2)

--bkg.x = halfW
--bkg.y = halfH
local function roll( event )
    local filename = "dice"
    local extension = ".png"
    if ( "ended" == event.phase ) then
        diea=math.random(1,6)
        dieb=math.random(1,6)
        local rolleda = display.newImageRect(filename..diea..extension,50,50)
        rolleda.x, rolleda.y = 50, 125
        local rolledb = display.newImageRect(filename..dieb..extension,50,50)
        rolledb.x, rolledb.y = 100, 125
        print("rolled")
    end
    return diea, dieb
end
 
-- Create the widget
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


red, green, blue, yellow = boardlib.drawboard()
rolldice.x = 93
rolldice.y = halfH *2 -15