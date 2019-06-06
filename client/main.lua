-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

---local socket = require( "socket")
---local client = socket.connect("localhost",8000)

---client:send("Hello")

boardlib = require "board"

local halfH = display.contentHeight * 0.5
local halfW = display.contentWidth * 0.5
center = {halfW, halfH}

--local bkg = display.newImageRect("BioshockInf.jpg", halfW*2,halfH*2)

--bkg.x = halfW
--bkg.y = halfH




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