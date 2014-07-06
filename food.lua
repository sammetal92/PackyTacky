Food = {}

function Food:new()
	f = {w=16, h=16, x=0, y=0, foodImage = gr.newImage("img/apple.png")}
	Food:respawn()
	setmetatable(f, {__index = Food})
	return f
end

function Food:update(dt)
	-- checking collision with player
	if o.y+o.h > f.y and o.x+o.w > f.x and o.y < f.y+f.h and o.x < f.x+f.w then
		Food:respawn()
		foodSfx:play()
		o.score = o.score + 1
	end
	-- checking collision with enemy character
	if e.y+e.h > f.y and e.x+e.w > f.x and e.y < f.y+f.h and e.x < f.x+f.w then
		Food:respawn()
		enemySfx:play()
		if o.score > 0 then
			o.score = o.score - 1
		end
	end
end

function Food:respawn()
	math.randomseed(os.time())
	f.x = math.random(gr.getWidth() - f.w)
	f.y = math.random(gr.getHeight() - f.h)
	if f.y < 32 then -- does not let food spawn outside the boundaries of the playing area
		f.y = f.y + 32
	end
end

function Food:draw()
	gr.setColor(255, 255, 255)
	gr.draw(f.foodImage, f.x, f.y)
end