Enemy = {}

local gameoverPlayed = false

function math.angle(x1,y1, x2,y2)
	return math.atan2(y2-y1, x2-x1)
end

function Enemy:new()
	e = {x=gr.getWidth()+30, y=100, w=30, h=30, facing="right", imgLeft=gr.newImage("img/enLeft.png"),
		imgRight=gr.newImage("img/enRight.png"), speed=300}
	Enemy:respawn()
	setmetatable(e, {__index = Enemy})
	return e
end

function Enemy:update(dt)
	if o.y+o.h > e.y and o.x+o.w > e.x and o.y < e.y+e.h and o.x < e.x+e.w then
		if gameoverPlayed == false then
			playingBgm:stop()
			gameoverMusic:play()
			love.timer.sleep(2)
			gameoverPlayed = true
		end
		gamestate = "gameover"
	end

	if gamestate == "playing" and e.facing == "left" and e.x > -100 then
		e.x = e.x - 300 * dt
		_angle = math.angle(e.x, e.y, f.x, f.y)
		dy = math.sin(_angle) * (dt * (e.speed/2))
		e.y = e.y + dy
	elseif gamestate == "playing" and e.x <= -100 then
		Enemy:respawn()
		e.facing = "right"
	end
	
	if e.facing == "right" and gamestate == "playing" and e.x < gr.getWidth() + 100 then
		e.x = e.x + 300 * dt
		_angle = math.angle(e.x, e.y, f.x, f.y)
		dy = math.sin(_angle) * (dt * (e.speed/2))
		e.y = e.y + dy
	elseif gamestate == "playing" and e.x >= gr.getWidth() + 100 then
		Enemy:respawn()
		e.facing = "left"
	end
end

function Enemy:respawn()
	math.randomseed(os.time())
	e.y = math.random(32, gr.getHeight() - 32)
end

function Enemy:newGame()
	gameoverPlayed = false
	e.x = gr.getWidth()+30
	Enemy:respawn()
end