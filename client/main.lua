-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

---local socket = require( "socket")
---local client = socket.connect("localhost",8000)

---client:send("Hello")
halfH = display.contentHeight * 0.75
halfW = display.contentWidth

local bkg = display.newImageRect("Parques.JPG", halfW,halfH)

bkg.x = display.contentCenterX
bkg.y = display.contentCenterY 