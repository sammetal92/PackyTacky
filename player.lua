Player = {nomsCollected = 0}

function Player:new()
	o = {x=gr.getWidth()/2, y=gr.getHeight()/2, w=30, h=30, score=0, highscore=0,
		imgUp=gr.newImage("img/up.png"), imgDown=gr.newImage("img/down.png"),
		imgLeft=gr.newImage("img/left.png"), imgRight=gr.newImage("img/right.png"),
		facing="left"}
	setmetatable(o, {__index = Player})
	return o
end

function Player:spawnAgain()
	o.x = gr.getWidth()/2
	o.y = gr.getHeight()/2
	o.facing = "left"
	score = 0
end

function Player:update(dt)
	if (kb.isDown("a") or kb.isDown("left")) and o.x > 0 and gamestate == "playing" then
		o.x = o.x - 300 * dt
		o.facing = "left"
	end
	if kb.isDown("s") or kb.isDown ("down") and gamestate == "playing" then
		o.y = o.y + 300 * dt
		o.facing = "down"
	end
	if (kb.isDown("w") or kb.isDown("up")) and o.y > 32 and gamestate == "playing" then
		o.y = o.y - 300 * dt
		o.facing = "up"
	end
	if kb.isDown("d") or kb.isDown("right") and gamestate == "playing" then
		o.x = o.x + 300 * dt
		o.facing = "right"
	end

	if o.y > gr.getHeight() - o.h then
		o.y = gr.getHeight() - o.h
	end
	if o.x > gr.getWidth() - o.w then
		o.x = gr.getWidth() - o.w
	end
end