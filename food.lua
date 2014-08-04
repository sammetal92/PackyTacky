Food = {}

function Food:new()
	f = {w=16, h=16, x=0, y=0, foodImage = gr.newImage("img/apple.png"), powerupImage = gr.newImage("img/pwr.png"), powerUp = false}
	Food:respawn()
	setmetatable(f, {__index = Food})
	return f
end

function Food:update(dt)
	-- checking collision with player
	if o.y+o.h > f.y and o.x+o.w > f.x and o.y < f.y+f.h and o.x < f.x+f.w then
		o.score = o.score + 1
		if o.score - prevScore == 10 and e.speed < 500 then
			prevScore = o.score
			e.speed = e.speed + 50
		end
		
		if (f.powerUp == true and o.score > 1) then
			f.powerUp = false
			o.speedup = true
			timerS = 0 --set timer start to zero
			pwrSfx:play() --if apple is a powerup, play the powerup sound
		else foodSfx:play() --if the apple is a red one, play the regular sound
		end
		Food:respawn()
	end
	-- checking collision with enemy character
	if e.y+e.h > f.y and e.x+e.w > f.x and e.y < f.y+f.h and e.x < f.x+f.w then
		enemySfx:play()
		if o.score > 0 then
			o.score = o.score - 1
		end

		f.powerUp = false
		Food:respawn()
	end
end

function Food:respawn()
	r = math.random(1,15)
	if (r == 3 and f.powerUp == false) then --1/15 chance of every apple being a powerup
		f.powerUp = true
	end
    local lastX, lastY = f.x, f.y
    f.x = math.random(gr.getWidth() - f.w)
    f.y = math.random(32, gr.getHeight() - f.h)
    if f.x==lastX and f.y==lastY then
        f.x = (f.x + math.random(gr.getWidth()-f.w) + 5) % gr.getWidth()
	end
end

function Food:draw()
	gr.setColor(255, 255, 255)
	if (f.powerUp == false or o.score == 0) then --if the apple is not a powerup
		gr.draw(f.foodImage, f.x, f.y) --we draw the regular red apple
	else gr.draw(f.powerupImage, f.x, f.y) --if it is, we draw the green apple
	end
end