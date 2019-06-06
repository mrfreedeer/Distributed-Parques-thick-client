local board = {}
function board.toScreen(coords, center)
	ny = center[2] - coords[2]
	nx = (coords[1] + center[1])
	return {nx, ny}
end

function board.toCart(coords, center)
	cx = coords[1] - center[1]
	cy = center[2] - coords[2]
	return {cx,cy}
end

function board.drawboard()
		red =  {}
		posx = 0 
		posy = 65
		diff = -12
		
		for i=1, 8 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 40,10)
			f.strokeWidth = 1
			if i == 1 then
				f:setStrokeColor( 1, 0, 0)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(1,0,0)
				f:setFillColor(1,1,1)
			end
			table.insert(red,f)
			posy = posy + diff
		
		end
		posy = 65
		posx = posx-42
		for i=1, 10 do
			screenpos = board.toScreen({posx, posy}, center)
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
		posx = posx - 27
		posy = posy + 27
		for i=1, 6 do
			screenpos = board.toScreen({posx, posy}, center)
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
			posx = posx + diff
		end
		
		-- Aqui comienzan las fichas amarillas
		posy = posy - 42
		posx = posx  - diff
		refx = posx
		for i=1, 8 do
			screenpos = board.toScreen({posx, posy}, center)
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
		
		posx = refx
		posy = posy - 42
		yellow = {}
		for i=1, 6 do
			screenpos = board.toScreen({posx, posy}, center)
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
		posx =-42
		posy = posy + 15
		for i=1, 10 do
			screenpos = board.toScreen({posx, posy}, center)
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
		
		--Aqui comienzan las azules
		blue = {}
		refy = posy
		posy = posy - diff
		posx = posx + 42
		for i=1, 8 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 40,10)
			f.strokeWidth = 1
			if i == 1 then
				f:setStrokeColor(0,0,0)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(0,0,0)
				f:setFillColor(0,0,1)
			end
			table.insert(blue,f)
			posy = posy - diff
		end
		posy = refy - diff
		posx = posx + 42
		for i=1, 10 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 40,10)
			f.strokeWidth = 1
			if i == 4 then
				f:setStrokeColor(0,0,1)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(0,0,1)
				f:setFillColor(1,1,1)
			end
			table.insert(blue,f)
			posy = posy - diff
		end
		posy = posy - 27
		posx = posx + 27
		for i=1, 6 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 10,40)
			f.strokeWidth = 1
			if i == 3 then
				f:setStrokeColor(0,0,0)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(0,0,1)
				f:setFillColor(1,1,1)
			end
			table.insert(blue,f)
			posx = posx - diff
		end
		
		--Aqui empiezan las verdes
		green = {}
		posx = posx + diff
		posy = posy + 42
		for i=1, 8 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 10,40)
			f.strokeWidth = 1
			if i == 1 then
				f:setStrokeColor(0,0,0)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(0,0,0)
				f:setFillColor(1,1,1)
			end
			table.insert(green,f)
			posx = posx + diff
		end
		refx = posx
		posx = posx + 36
		posy = posy + 42
		for i=1, 6 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 10,40)
			f.strokeWidth = 1
			if i == 3 then
				f:setStrokeColor(0,0,0)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(0,1,0)
				f:setFillColor(1,1,1)
			end
			table.insert(green,f)
			posx = posx - diff
		end
		posx = refx + 9
		posy = posy - 15
		
		for i=1, 10 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 40,10)
			f.strokeWidth = 1
			if i == 3 then
				f:setStrokeColor(0,0,0)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(0,1,0)
				f:setFillColor(1,1,1)
			end
			table.insert(green,f)
			posy = posy - diff
		end
		return red, green, blue, yellow
end

return board