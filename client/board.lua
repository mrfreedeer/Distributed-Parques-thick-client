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
		global =  {}
		posx = 0 
		posy = 65
		diff = -12
		num = 1
		for i=1, 8 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 40,10)
			f.strokeWidth = 1
			f.number = num
			num = num + 1
			f.number = num
			num = num + 1
			if i == 1 then
				f:setStrokeColor( 1, 0, 0)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(1,1,1)
				f:setFillColor(1,0,0)
			end
			table.insert(global, f)
			
			posy = posy + diff
		
		end
		posy = 65
		posx = posx-42
		for i=1, 10 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 40,10)
			f.strokeWidth = 1
			f.number = num
			num = num + 1
			if i == 5 then
				f:setStrokeColor( 1, 0, 0)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(1,0,0)
				f:setFillColor(1,1,1)
			end
			table.insert(global, f)
			posy = posy + diff
		
		end
		posx = posx - 27
		posy = posy + 27
		for i=1, 6 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 10,40)
			f.strokeWidth = 1
			f.number = num
			num = num + 1
			if i == 2 then
				f:setStrokeColor( 1, 0, 0)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(1,0,0)
				f:setFillColor(1,1,1)
			end
			table.insert(global, f)
			posx = posx + diff
		end
		redlimit = num - 1
		-- Aqui comienzan las fichas amarillas
		posy = posy - 42
		posx = posx  - diff
		refx = posx
		for i=1, 8 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 10,40)
			f.strokeWidth = 1
			f.number = num
			num = num + 1
			if i == 1 then
				f:setStrokeColor( 0, 0, 0)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(0,0,0)
				f:setFillColor(1,1,0)
			end
			table.insert(global, f)
			posx = posx - diff
		end
		
		posx = refx
		posy = posy - 42

		for i=1, 6 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 10,40)
			f.strokeWidth = 1
			f.number = num
			num = num + 1
			if i == 5 then
				f:setStrokeColor( 1, 1, 0)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(1,1,0)
				f:setFillColor(1,1,1)
			end
			
			table.insert(global, f)
			posx = posx - diff
		end
		posx =-42
		posy = posy + 15
		for i=1, 10 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 40,10)
			f.strokeWidth = 1
			f.number = num
			num = num + 1
			if i == 7 then
				f:setStrokeColor( 1, 1, 0)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(1,1,0)
				f:setFillColor(1,1,1)
			end
			table.insert(global, f)
			posy = posy + diff
		end
		yellowlimit = num - 1
		--Aqui comienzan las azules

		refy = posy
		posy = posy - diff
		posx = posx + 42
		for i=1, 8 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 40,10)
			f.strokeWidth = 1
			f.number = num
			num = num + 1
			if i == 1 then
				f:setStrokeColor(0,0,0)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(1,1,1)
				f:setFillColor(0,0,1)
			end
			table.insert(global, f)
			posy = posy - diff
		end
		posy = refy - diff
		posx = posx + 42
		for i=1, 10 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 40,10)
			f.strokeWidth = 1
			f.number = num
			num = num + 1
			if i == 4 then
				f:setStrokeColor(0,0,1)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(0,0,1)
				f:setFillColor(1,1,1)
			end
			table.insert(global, f)
			posy = posy - diff
		end
		posy = posy - 27
		posx = posx + 27
		for i=1, 6 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 10,40)
			f.strokeWidth = 1
			f.number = num
			num = num + 1
			if i == 3 then
				f:setStrokeColor(0,0,0)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(0,0,1)
				f:setFillColor(1,1,1)
			end
			table.insert(global, f)
			posx = posx - diff
		end
		bluelimit = num - 1
		--Aqui empiezan las verdes

		posx = posx + diff
		posy = posy + 42
		for i=1, 8 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 10,40)
			f.strokeWidth = 1
			f.number = num
			num = num + 1
			if i == 1 then
				f:setStrokeColor(0,0,0)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(0,0,0)
				f:setFillColor(0,1,0)
			end
			table.insert(global, f)
			posx = posx + diff
		end
		refx = posx
		posx = posx + 36
		posy = posy + 42
		for i=1, 6 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 10,40)
			f.strokeWidth = 1
			f.number = num
			num = num + 1
			if i == 3 then
				f:setStrokeColor(0,0,0)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(0,1,0)
				f:setFillColor(1,1,1)
			end
			table.insert(global, f)
			posx = posx - diff
		end
		posx = refx + 9
		posy = posy - 15
		
		for i=1, 10 do
			screenpos = board.toScreen({posx, posy}, center)
			local f = display.newRect(screenpos[1], screenpos[2], 40,10)
			f.strokeWidth = 1
			f.number = num
			num = num + 1
			if i == 6 then
				f:setStrokeColor(0,0,0)
				f:setFillColor(.2,.2,.2)
			else
				f:setStrokeColor(0,1,0)
				f:setFillColor(1,1,1)
			end
			table.insert(global, f)
			posy = posy - diff
		end
		greenlimit = num - 1
		return global, redlimit, yellowlimit, bluelimit, greenlimit
end

return board