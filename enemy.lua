Enemy = {}

local gameoverPlayed = false

function math.angle(x1,y1, x2,y2)
	return math.atan2(y2-y1, x2-x1)
end

function Enemy:new()
	e = {x=gr.getWidth()+30, y=100, w=30, h=30, facing="right", imgLeft=gr.newImage("img/enLeft.png"),
		imgRight=gr.newImage("img/enRight.png"), speed=200, angleDivider=1}
	Enemy:respawn()
	setmetatable(e, {__index = Enemy})
	return e
end

function Enemy:update(dt)
	--checking collision with player
	if o.y+o.h > e.y and o.x+o.w > e.x and o.y < e.y+e.h and o.x < e.x+e.w then
		-- this nested condition checks if the gameover sound has been already played once
		-- if this is not implemented, the gameover sound will be played over and over again
		-- and the game will keep sleeping because of love.timer.sleep()
		if gameoverPlayed == false then
			playingBgm:stop()
			gameoverMusic:play()
			love.timer.sleep(2)
			gameoverPlayed = true
		end
		gamestate = "gameover"
	end

	if gamestate == "playing" and e.facing == "left" and e.x > -100 then
		e.x = e.x - e.speed * dt
		_angle = math.angle(e.x, e.y, f.x, f.y) -- gets the angle between the spawned food and enemy character
		-- adjusts angle toward the spawned food
		dy = math.sin(_angle) * (dt * (e.speed/e.angleDivider)) -- we can use angleDivider to vary difficulty
		-- moves in the direction of the calculated angle
		e.y = e.y + dy
	elseif gamestate == "playing" and e.x <= -100 then
		Enemy:respawn()
		e.facing = "right"
	end
	
	if e.facing == "right" and gamestate == "playing" and e.x < gr.getWidth() + 100 then
		e.x = e.x + e.speed * dt
		-- same calculations as done for e.facing == "left"
		_angle = math.angle(e.x, e.y, f.x, f.y)
		dy = math.sin(_angle) * (dt * (e.speed/e.angleDivider))
		e.y = e.y + dy
	elseif gamestate == "playing" and e.x >= gr.getWidth() + 100 then
		Enemy:respawn()
		e.facing = "left"
	end
end

function Enemy:respawn()
	e.y = math.random(32, gr.getHeight() - 32)
end

function Enemy:newGame()
	e.speed = 200
	gameoverPlayed = false
	e.x = gr.getWidth()+30
	Enemy:respawn()
end