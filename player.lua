Player = {}
local dx, dy = 0, 0

function Player:new()
	o = {x=gr.getWidth()/2, y=gr.getHeight()/2, w=30, h=30, score=0, highscore=0,
		imgUp=gr.newImage("img/up.png"), imgDown=gr.newImage("img/down.png"),
		imgLeft=gr.newImage("img/left.png"), imgRight=gr.newImage("img/right.png"),
		facing="left", speed = 300, speedup = false}
	setmetatable(o, {__index = Player})
	return o
end

function Player:spawnAgain()
	-- Spawning the player in the center of the playing area
	o.x = gr.getWidth()/2
	o.y = gr.getHeight()/2
	o.facing = "left"
	o.speed = 300
	-- Resetting score
	score = 0
end

function Player:update(dt)
	if (o.speedup == true) then --if player eats a speed powerup
		o.speed = 500 --increase speed
		timerS = timerS + dt --update timer
		if (timerS > 5) then --when timer is over 5 seconds
			o.speedup = false --reset everything
			o.speed = 300
			timerS = 0
		end
	end

	dx, dy = 0, 0 --delta x and y

	--MOVEMENT CONTROLS

	if (kb.isDown("a") or kb.isDown("left")) and o.x > 0 and gamestate == "playing" then
		dx = dx - o.speed * dt
		o.facing = "left"
	end
	if kb.isDown("s") or kb.isDown ("down") and gamestate == "playing" then
		dy = dy + o.speed * dt
		o.facing = "down"
	end
	if (kb.isDown("w") or kb.isDown("up")) and o.y > 32 and gamestate == "playing" then
		dy = dy - o.speed * dt
		o.facing = "up"
	end
	if kb.isDown("d") or kb.isDown("right") and gamestate == "playing" then
		dx = dx + o.speed * dt
		o.facing = "right"
	end

	-- To keep velocity constant when player moves diagonally, we use Pythagorean theorem
	-- Pythagorean theorem is hypotenuse^2 = base^2 + height^2
	-- So we need the ratio dx/(sqroot(2)) assuming base = 1 and height = 1, so hypotenuse^2 = 2
	if dx ~= 0 and dy ~= 0 and gamestate == "playing" then
    	dx = dx / 1.41421 -- 1.41421 is an estimation of square root of 2
    	dy = dy / 1.41421
	end
   	o.x = o.x + dx
   	o.y = o.y + dy

   	-- Checking if player collides with the boundaries of the playing area
   	-- stops if colliding
	if o.y > gr.getHeight() - o.h then
		o.y = gr.getHeight() - o.h
	end
	if o.x > gr.getWidth() - o.w then
		o.x = gr.getWidth() - o.w
	end
end