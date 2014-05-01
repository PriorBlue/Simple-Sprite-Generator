require "lib/postshader"
require "lib/gui/gui"

function love.load()
	G = love.graphics
	W = love.window
	T = love.timer

	G.setPointStyle("rough")
	FONT = G.newFont(16)
	G.setFont(FONT)

	page = 0
	size = 16
	cnt = 4
	v1 = 1
	v2 = 4
	sprite = {}
	sprite2 = {}

	initCells(size)

	for i = 1, cnt do
		calcCells(v1, v2)
	end

	gui = {}

	for i = 1, 8 do
		gui[i] = love.gui.newGui()
	end

	rdbSize1 = gui[1].newRadioButton(W.getWidth() - 196 + 32 * 0, 32 + 56 * 0, 24, 24, "6")
	rdbSize2 = gui[1].newRadioButton(W.getWidth() - 196 + 32 * 1, 32 + 56 * 0, 24, 24, "8")
	rdbSize3 = gui[1].newRadioButton(W.getWidth() - 196 + 32 * 2, 32 + 56 * 0, 24, 24, "10")
	rdbSize4 = gui[1].newRadioButton(W.getWidth() - 196 + 32 * 3, 32 + 56 * 0, 24, 24, "12")
	rdbSize5 = gui[1].newRadioButton(W.getWidth() - 196 + 32 * 4, 32 + 56 * 0, 24, 24, "14")
	rdbSize6 = gui[1].newRadioButton(W.getWidth() - 196 + 32 * 5, 32 + 56 * 0, 24, 24, "16")
	rdbSize6.setChecked(true)

	rdbKill1 = gui[2].newRadioButton(W.getWidth() - 164 + 32 * 0, 32 + 56 * 3, 24, 24, "1")
	rdbKill2 = gui[2].newRadioButton(W.getWidth() - 164 + 32 * 1, 32 + 56 * 3, 24, 24, "2")
	rdbKill3 = gui[2].newRadioButton(W.getWidth() - 164 + 32 * 2, 32 + 56 * 3, 24, 24, "3")
	rdbKill4 = gui[2].newRadioButton(W.getWidth() - 164 + 32 * 3, 32 + 56 * 3, 24, 24, "4")
	rdbKill2.setChecked(true)

	rdbGrow1 = gui[3].newRadioButton(W.getWidth() - 164 + 32 * 0, 32 + 56 * 4, 24, 24, "1")
	rdbGrow2 = gui[3].newRadioButton(W.getWidth() - 164 + 32 * 1, 32 + 56 * 4, 24, 24, "2")
	rdbGrow3 = gui[3].newRadioButton(W.getWidth() - 164 + 32 * 2, 32 + 56 * 4, 24, 24, "3")
	rdbGrow4 = gui[3].newRadioButton(W.getWidth() - 164 + 32 * 3, 32 + 56 * 4, 24, 24, "4")
	rdbGrow4.setChecked(true)

	rdbCount1 = gui[4].newRadioButton(W.getWidth() - 164 + 32 * 0, 32 + 56 * 5, 24, 24, "1")
	rdbCount2 = gui[4].newRadioButton(W.getWidth() - 164 + 32 * 1, 32 + 56 * 5, 24, 24, "2")
	rdbCount3 = gui[4].newRadioButton(W.getWidth() - 164 + 32 * 2, 32 + 56 * 5, 24, 24, "3")
	rdbCount4 = gui[4].newRadioButton(W.getWidth() - 164 + 32 * 3, 32 + 56 * 5, 24, 24, "4")
	rdbCount4.setChecked(true)

	rdbBorder1 = gui[5].newRadioButton(W.getWidth() - 164 + 32 * 0, 32 + 56 * 2, 24, 24, "1")
	rdbBorder2 = gui[5].newRadioButton(W.getWidth() - 164 + 32 * 1, 32 + 56 * 2, 24, 24, "2")
	rdbBorder3 = gui[5].newRadioButton(W.getWidth() - 164 + 32 * 2, 32 + 56 * 2, 24, 24, "3")
	rdbBorder4 = gui[5].newRadioButton(W.getWidth() - 164 + 32 * 3, 32 + 56 * 2, 24, 24, "4")
	rdbBorder1.setChecked(true)

	rdbColor1 = gui[6].newRadioButton(W.getWidth() - 164 + 32 * 0, 32 + 56 * 1, 24, 24, "1")
	rdbColor2 = gui[6].newRadioButton(W.getWidth() - 164 + 32 * 1, 32 + 56 * 1, 24, 24, "2")
	rdbColor3 = gui[6].newRadioButton(W.getWidth() - 164 + 32 * 2, 32 + 56 * 1, 24, 24, "3")
	rdbColor4 = gui[6].newRadioButton(W.getWidth() - 164 + 32 * 3, 32 + 56 * 1, 24, 24, "4")
	rdbColor1.setChecked(true)

	rdbBloom1 = gui[7].newRadioButton(W.getWidth() - 164 + 32 * 0, 32 + 56 * 6, 24, 24, "0")
	rdbBloom2 = gui[7].newRadioButton(W.getWidth() - 164 + 32 * 1, 32 + 56 * 6, 24, 24, "1")
	rdbBloom3 = gui[7].newRadioButton(W.getWidth() - 164 + 32 * 2, 32 + 56 * 6, 24, 24, "2")
	rdbBloom4 = gui[7].newRadioButton(W.getWidth() - 164 + 32 * 3, 32 + 56 * 6, 24, 24, "3")
	rdbBloom1.setChecked(true)

	rdbGlow1 = gui[8].newRadioButton(W.getWidth() - 164 + 32 * 0, 32 + 56 * 7, 24, 24, "0")
	rdbGlow2 = gui[8].newRadioButton(W.getWidth() - 164 + 32 * 1, 32 + 56 * 7, 24, 24, "1")
	rdbGlow3 = gui[8].newRadioButton(W.getWidth() - 164 + 32 * 2, 32 + 56 * 7, 24, 24, "2")
	rdbGlow4 = gui[8].newRadioButton(W.getWidth() - 164 + 32 * 3, 32 + 56 * 7, 24, 24, "3")
	rdbGlow1.setChecked(true)

	chkRandom = gui[6].newCheckbox(W.getWidth() - 164, 480 + 32 * 0, 24, 24, true, "Random Color")
	chkShadow   = gui[6].newCheckbox(W.getWidth() - 164, 480 + 32 * 1, 24, 24, false, "Shadow")
	chk4Colors   = gui[6].newCheckbox(W.getWidth() - 164, 480 + 32 * 2, 24, 24, false, "4-Colors")

	update = true
end

function love.update(dt)
	for i = 1, #gui do
		gui[i].update(dt)
	end

	if rdbSize1.isHit() then
		size = 6
		initCells(size)
	elseif rdbSize2.isHit() then
		size = 8
		initCells(size)
	elseif rdbSize3.isHit() then
		size = 10
		initCells(size)
	elseif rdbSize4.isHit() then
		size = 12
		initCells(size)
	elseif rdbSize5.isHit() then
		size = 14
		initCells(size)
	elseif rdbSize6.isHit() then
		size = 16
		initCells(size)
	end

	if rdbKill1.isHit() then
		v1 = 0
		update = true
	elseif rdbKill2.isHit() then
		v1 = 1
		update = true
	elseif rdbKill3.isHit() then
		v1 = 2
		update = true
	elseif rdbKill4.isHit() then
		v1 = 3
		update = true
	end

	if rdbGrow1.isHit() then
		v2 = 1
		update = true
	elseif rdbGrow2.isHit() then
		v2 = 2
		update = true
	elseif rdbGrow3.isHit() then
		v2 = 3
		update = true
	elseif rdbGrow4.isHit() then
		v2 = 4
		update = true
	end

	if rdbCount1.isHit() then
		cnt = 1
		update = true
	elseif rdbCount2.isHit() then
		cnt = 2
		update = true
	elseif rdbCount3.isHit() then
		cnt = 3
		update = true
	elseif rdbCount4.isHit() then
		cnt = 4
		update = true
	end
end

function love.draw()
	W.setTitle("Simple Sprite Generator - Page " ..page .. " (FPS:" .. T.getFPS() .. ")")
	if update then
		if not rdbGlow1.isChecked() then
			love.postshader.setBuffer("glow")
		end
		drawCells(page, 16, 16, true)
		love.postshader.setBuffer("render")
		if rdbColor1.isChecked() then
			if chk4Colors.isChecked() then
				G.setColor(215, 232, 148)
			else
				G.setColor(0, 0, 0)
			end
		elseif rdbColor2.isChecked() then
			if chk4Colors.isChecked() then
				G.setColor(174, 196, 64)
			else
				G.setColor(63, 63, 63)
			end
		elseif rdbColor3.isChecked() then
			if chk4Colors.isChecked() then
				G.setColor(82, 127, 57)
			else
				G.setColor(191, 191, 191)
			end
		elseif rdbColor4.isChecked() then
			if chk4Colors.isChecked() then
				G.setColor(32, 70, 49)
			else
				G.setColor(0, 127, 255)
			end
		end
		G.rectangle("fill", 0, 0, W.getWidth(), W.getHeight())
		G.setColor(0, 0, 0, 127)
		G.rectangle("fill", W.getWidth() - 208, 0, 208, W.getHeight())
		if rdbGlow2.isChecked() then
			love.postshader.addEffect("glow", 2, 2)
		elseif rdbGlow3.isChecked() then
			love.postshader.addEffect("glow", 4, 4)
		elseif rdbGlow4.isChecked() then
			love.postshader.addEffect("glow", 6, 6)
		end
		G.setBlendMode("alpha")
		drawCells(page, 16, 16)

		if rdbBloom2.isChecked() then
			love.postshader.addEffect("bloom")
		elseif rdbBloom3.isChecked() then
			love.postshader.addEffect("bloom", 1, 1)
		elseif rdbBloom4.isChecked() then
			love.postshader.addEffect("bloom", 2, 2)
		end
		for i = 1, #gui do
			gui[i].draw()
		end
		G.setColor(255, 127, 0)
		--G.print("Page: " .. page .. " Cnt:" .. cnt .. " Kill:" .. v1 .. " Grow:" .. v2 .. " Size:" .. size .. "x" .. size, 8, 8)
		G.printf("Size", W.getWidth() - 176, 32 + 56 * 0 - 24, 128, "center")
		G.printf("Color", W.getWidth() - 176, 32 + 56 * 1 - 24, 128, "center")
		G.printf("Border", W.getWidth() - 176, 32 + 56 * 2 - 24, 128, "center")
		G.printf("Parameter 1", W.getWidth() - 176, 32 + 56 * 3 - 24, 128, "center")
		G.printf("Parameter 2", W.getWidth() - 176, 32 + 56 * 4 - 24, 128, "center")
		G.printf("Parameter 2", W.getWidth() - 176, 32 + 56 * 5 - 24, 128, "center")
		G.printf("Bloom", W.getWidth() - 176, 32 + 56 * 6 - 24, 128, "center")
		G.printf("Glow", W.getWidth() - 176, 32 + 56 * 7 - 24, 128, "center")
		G.printf("(Scroll for new icons)", 176, W.getHeight() - 20, 240, "center")
	end

	love.postshader.draw()

	update = false
end

function love.keypressed(key, unicode)
	if key == "up" then
		page = page - 1
	elseif key == "down" then
		page = page + 1
	end

	if key == "pageup" then
		page = page - 100
	elseif key == "pagedown" then
		page = page + 100
	end

	update = true
end

function love.mousepressed(x, y, key)
	if key == "wu" then
		page = page - 1
	elseif key == "wd" then
		page = page + 1
	end

	update = true
end

function initCells(s)
	sprite = {}
	for i = 1, s do
		sprite[i] = {}
		for k = 1, s do
			sprite[i][k] = 0
		end
	end

	sprite2 = {}
	for i = 1, s do
		sprite2[i] = {}
		for k = 1, s do
			sprite2[i][k] = 0
		end
	end
end

function drawCells(page, x, y, glow)
	local w = math.floor(W.getWidth() / size / 8.1)
	local h = math.floor(W.getHeight() / size / 6.1)
	local cell = nil

	for i = 1, w do
		for k = 1, h do
			math.randomseed((i + k * w) + page * w)
			red = math.random(63, 255)
			green = math.random(63, 255)
			blue = math.random(63, 255)
			calcCell((i + k * w) + page * w)

			if chkShadow.isChecked() then
				G.setColor(255, 255, 255)
				drawCell((i - 1) * (size * 6) + x + 1, (k - 1) * (size * 6) + y + 1)
			end

			if not rdbBorder1.isChecked() or chk4Colors.isChecked() then
				if glow then
					if chkRandom.isChecked() then
						G.setColor(math.min(red * 2, 255), math.min(green * 2, 255), math.min(blue * 2, 255))
					else
						G.setColor(0, 127, 255)
					end
				else
					if rdbBorder2.isChecked() then
						if chk4Colors.isChecked() then
							G.setColor(82, 127, 57)
						else
							G.setColor(0, 0, 0)
						end
					elseif rdbBorder3.isChecked() then
						if chk4Colors.isChecked() then
							if chkRandom.isChecked() then
								if red % 4 == 3 then
									G.setColor(32, 70, 49)
								elseif red % 4 == 2 then
									G.setColor(82, 127, 57)
								elseif red % 4 == 1 then
									G.setColor(174, 196, 64)
								elseif red % 4 == 0 then
									G.setColor(215, 232, 148)
								end
							else
								G.setColor(32, 70, 49)
							end
						else
							if chkRandom.isChecked() then
								G.setColor(red * 0.25, green * 0.25, blue * 0.25)
							else
								G.setColor(0, 31, 63)
							end
						end
					elseif rdbBorder4.isChecked() then
						if chk4Colors.isChecked() then
							G.setColor(82, 127, 57)
						else
							if chkRandom.isChecked() then
								G.setColor(red * 0.35, green * 0.35, blue * 0.35)
							else
								G.setColor(0, 63, 127)
							end
						end
					elseif chk4Colors.isChecked() then
						G.setColor(215, 232, 148)
					end
				end
				drawCell((i - 1) * (size * 6) + x - 4, (k - 1) * (size * 6) + y)
				drawCell((i - 1) * (size * 6) + x, (k - 1) * (size * 6) + y - 4)
				if glow then
					if chkRandom.isChecked() then
						G.setColor(math.min(red * 2, 255), math.min(green * 2, 255), math.min(blue * 2, 255))
					else
						G.setColor(0, 127, 255)
					end
				else
					if rdbBorder2.isChecked() then
						if chk4Colors.isChecked() then
							G.setColor(82, 127, 57)
						else
							G.setColor(0, 0, 0)
						end
					elseif rdbBorder3.isChecked() or rdbBorder4.isChecked() then
						if chk4Colors.isChecked() then
							if chkRandom.isChecked() then
								if red % 4 == 3 then
									G.setColor(32, 70, 49)
								elseif red % 4 == 2 then
									G.setColor(82, 127, 57)
								elseif red % 4 == 1 then
									G.setColor(174, 196, 64)
								elseif red % 4 == 0 then
									G.setColor(215, 232, 148)
								end
							else
								G.setColor(32, 70, 49)
							end
						else
							if chkRandom.isChecked() then
								G.setColor(red * 0.25, green * 0.25, blue * 0.25)
							else
								G.setColor(0, 31, 63)
							end
						end
					end
				end
				drawCell((i - 1) * (size * 6) + x + 4, (k - 1) * (size * 6) + y)
				drawCell((i - 1) * (size * 6) + x, (k - 1) * (size * 6) + y + 4)
			end

			--G.setBlendMode("additive")
			if chkRandom.isChecked() then
				if rdbBorder4.isChecked() then
					if chk4Colors.isChecked() then
						if red % 4 == 0 then
							G.setColor(32, 70, 49)
						elseif red % 4 == 1 then
							G.setColor(82, 127, 57)
						elseif red % 4 == 2 then
							G.setColor(174, 196, 64)
						elseif red % 4 == 3 then
							G.setColor(215, 232, 148)
						end
					else
						G.setColor(red, green, blue, 127)
						G.setBlendMode("additive")
					end
				else
					if chk4Colors.isChecked() then
						if red % 4 == 0 then
							G.setColor(32, 70, 49)
						elseif red % 4 == 1 then
							G.setColor(82, 127, 57)
						elseif red % 4 == 2 then
							G.setColor(174, 196, 64)
						elseif red % 4 == 3 then
							G.setColor(215, 232, 148)
						end
					else
						G.setColor(red, green, blue)
					end
				end
			else
				if rdbBorder4.isChecked() then
					if chk4Colors.isChecked() then
						G.setColor(215, 232, 148)
					else
						G.setColor(0, 127, 255, 127)
						G.setBlendMode("additive")
					end
				else
					if chk4Colors.isChecked() then
						G.setColor(215, 232, 148)
					else
						G.setColor(0, 127, 255)
					end
				end
			end
			drawCell((i - 1) * (size * 6) + x, (k - 1) * (size * 6) + y)
			G.setBlendMode("alpha")
		end
	end
end

function calcCell(page)
	math.randomseed(page)
	for i = 1, size do
		for k = 1, size * 0.5 do
			sprite[i][k] = math.random(0, 1)
		end
	end

	for i = 1, cnt do
		calcCells(v1, v2)
	end
end

function drawCell(x, y)
	for i = 1, size do
		for k = 1, size * 0.5 do
			if sprite[i][k] == 1 then
				G.rectangle("fill", k * 4 + x, i * 4 + y, 4, 4)
				G.rectangle("fill", ((size + 1) - k) * 4 + x, i * 4 + y, 4, 4)
			end
		end
	end
end

function calcCells(n1, n2)
	for i = 1, size do
		for k = 1, size * 0.5 do
			killCell(i, k, n1)
		end
	end

	for i = 1, size do
		for k = 1, size * 0.5 do
			sprite[i][k] = sprite2[i][k]
		end
	end

	for i = 1, size do
		for k = 1, size * 0.5 do
			sprite2[i][k] = 0
		end
	end

	for i = 1, size do
		for k = 1, size * 0.5 do
			growCell(i, k, n2)
		end
	end

	for i = 1, size do
		for k = 1, size * 0.5 do
			sprite[i][k] = sprite2[i][k]
		end
	end

	for i = 1, size do
		for k = 1, size * 0.5 do
			sprite2[i][k] = 0
		end
	end
end

function killCell(x, y, n)
	if sprite[x][y] == 1 then
		if getCellCount(x, y) >= n then
			sprite2[x][y] = 1
		end
	end
end

function growCell(x, y, n)
	if sprite[x][y] == 0 then
		if getCellCount(x, y) >= n then
			sprite2[x][y] = 1
		end
	else
		sprite2[x][y] = 1
	end
end

function getCellCount(x, y)
	local n = 0

	if x - 1 >= 1 then
		n = n + sprite[x - 1][y]
	end

	if x + 1 <= size * 0.5 then
		n = n + sprite[x + 1][y]
	end

	if y - 1 >= 1 then
		n = n + sprite[x][y - 1]
	end

	if y + 1 <= size then
		n = n + sprite[x][y + 1]
	end

	return n
end