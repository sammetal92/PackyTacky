Food = {}

function Food:new()
	f = {w=10, h=10, x=0, y=0}
	Food:respawn()
	setmetatable(f, {__index = Food})
	return f
end

function Food:update(dt)
	if o.y+o.h > f.y and o.x+o.w > f.x and o.y < f.y+f.h and o.x < f.x+f.w then
		Food:respawn()
		foodSfx:play()
		o.score = o.score + 1
	end
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
	if f.y < 32 then
		f.y = f.y + 32
	end
end

function Food:draw()
	gr.setColor(255, 0, 0)
	gr.rectangle("fill", f.x, f.y, f.w, f.h)
end