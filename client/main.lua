-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

---local socket = require( "socket")
---local client = socket.connect("localhost",8000)

---client:send("Hello")
local halfH = display.contentHeight * 0.5
local halfW = display.contentWidth * 0.5
center = {halfW, halfH}

--local bkg = display.newImageRect("Parques.JPG", halfW,halfH)

--bkg.x = display.contentCenterX
--bkg.y = display.contentCenterY 

function toScreen(coords, center)
	ny = center[2] - coords[2]
	nx = (coords[1] + center[1])
	return {nx, ny}
end

function toCart(coords, center)
	cx = coords[1] - center[1]
	cy = center[2] - coords[2]
	return {cx,cy}
end

hsrect = {-20,-5,-20,5,20,5,20,-5}
r1rect = {-20,-5,-25,5,15,8,20,-5}
r2rect = {-20,-7,-25,0,10,10,20,-5}
squarepos = toScreen({0,0}, center)
print(halfW, halfH)
print(squarepos[1], squarepos[2])



red =  {}
posx = -25 
posy = 65
diff = -12
for i=1, 10 do
	screenpos = toScreen({posx, posy}, center)
	local f = display.newRect(screenpos[1], screenpos[2], 40,10)
	f.strokeWidth = 1
	if i == 5 then
		f:setStrokeColor( 1, 0, 0)
		f:setFillColor(.2,.2,.2)
	else
		f:setStrokeColor(1,0,0)
		f:setFillColor(1,1,1)
	end
	table.insert(red,f)
	posy = posy + diff

end
posx = posx - 28
posy = posy + 27
for i=1, 6 do
	screenpos = toScreen({posx, posy}, center)
	local f = display.newRect(screenpos[1], screenpos[2], 10,40)
	f.strokeWidth = 1
	if i == 2 then
		f:setStrokeColor( 1, 0, 0)
		f:setFillColor(.2,.2,.2)
	else
		f:setStrokeColor(1,0,0)
		f:setFillColor(1,1,1)
	end
	table.insert(red,f)
	posx = posx-12
end
posy = posy - 42
posx = posx  - diff
refx = posx
for i=1, 8 do
	screenpos = toScreen({posx, posy}, center)
	local f = display.newRect(screenpos[1], screenpos[2], 10,40)
	f.strokeWidth = 1
	if i == 1 then
		f:setStrokeColor( 0, 0, 0)
		f:setFillColor(.2,.2,.2)
	else
		f:setStrokeColor(0,0,0)
		f:setFillColor(1,1,0)
	end
	table.insert(red,f)
	posx = posx - diff
end

-- Aquí comienzan las fichas amarillas
posx = refx
posy = posy - 42
yellow = {}
for i=1, 6 do
	screenpos = toScreen({posx, posy}, center)
	local f = display.newRect(screenpos[1], screenpos[2], 10,40)
	f.strokeWidth = 1
	if i == 5 then
		f:setStrokeColor( 1, 1, 0)
		f:setFillColor(.2,.2,.2)
	else
		f:setStrokeColor(1,1,0)
		f:setFillColor(1,1,1)
	end
	
	table.insert(yellow,f)
	posx = posx - diff
end
posx =-25
posy = posy + 15
for i=1, 10 do
	screenpos = toScreen({posx, posy}, center)
	local f = display.newRect(screenpos[1], screenpos[2], 40,10)
	f.strokeWidth = 1
	if i == 7 then
		f:setStrokeColor( 1, 1, 0)
		f:setFillColor(.2,.2,.2)
	else
		f:setStrokeColor(1,1,0)
		f:setFillColor(1,1,1)
	end
	table.insert(yellow,f)
	posy = posy + diff
end
posy = posy + 27