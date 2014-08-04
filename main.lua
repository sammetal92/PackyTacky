require("player")
require("food")
require("enemy")
require("AnAL")
require("Loveframes")
require("menu")

prevScore = 0
gr, kb, fs, au = love.graphics, love.keyboard, love.filesystem, love.audio
mute = false
highscores = {}

function love.load()
	timerS = 0 --reset powerup timer
	math.randomseed(os.time()) --seed the random function
	-- Initialize images
	backgroundImage = gr.newImage("img/bg.png")
	logoImage = gr.newImage("img/logo.png")
	gameoverImage = gr.newImage("img/gameover.png")

	--Initialize objects
	p = Player:new()
	nom = Food:new()
	en = Enemy:new()

	--Initialize animations
	animUp = newAnimation(p.imgUp, 32, 32, 0.08, 6)
	animDown = newAnimation(p.imgDown, 32, 32, 0.08, 6)
	animLeft = newAnimation(p.imgLeft, 32, 32, 0.08, 6)
	animRight = newAnimation(p.imgRight, 32, 32, 0.08, 6)

	enemyFacingLeft = newAnimation(en.imgLeft, 32, 32, 0.08, 0)
	enemyFacingRight = newAnimation(en.imgRight, 32, 32, 0.08, 0)

	--Check scores
	if not fs.exists("scores.lua") then
		fs.newFile("scores.lua")
		fs.write("scores.lua", "p.highscore\n=\n"..p.highscore)
	end

	for lines in fs.lines("scores.lua") do
		table.insert(highscores, lines)
	end

	p.highscore = highscores[3]

	--Initialize fonts
	fontfont = gr.newFont("fonts/BuxtonSketch.ttf", 20)
	defaultFont = gr.newFont(12)

	--Initialize audio
	playingBgm = au.newSource("sfx/music.ogg", "stream")
	foodSfx = au.newSource("sfx/powerup.ogg", "static")
	enemySfx = au.newSource("sfx/powerdown.ogg", "static")
	menuMusic = au.newSource("sfx/mainmenumusic.ogg", "stream")
	gameoverMusic = au.newSource("sfx/gameover.ogg", "static")
	pwrSfx = au.newSource("sfx/pwr.ogg", "static")

	--Set music and sound effects options
	playingBgm:setLooping(true)
	playingBgm:setVolume(0.7)

	menuMusic:setLooping(true)
	menuMusic:setVolume(0.7)
	menuMusic:play()

	gameoverMusic:setVolume(0.7)

	enemySfx:setVolume(0.1)
	foodSfx:setVolume(0.1)
	pwrSfx:setVolume(0.1)

	gamestate = "startmenu"
	loveframes.SetState("startmenu")

	render_menu()
end

function love.update(dt)
	p:update(dt)
	nom:update(dt)

	if o.facing == "left" then
		animLeft:update(dt)
	end

	if o.facing == "right" then
		animRight:update(dt)
	end

	if o.facing == "up" then
		animUp:update(dt)
	end

	if o.facing == "down" then
		animDown:update(dt)
	end

	if en.facing == "left" then
		enemyFacingLeft:update(dt)
	end

	if en.facing == "right" then
		enemyFacingRight:update(dt)
	end

	en:update(dt)

	if p.score > tonumber(p.highscore) then
		p.highscore = p.score
	end

	loveframes.update(dt)
end

function love.touchpressed(id, x, y)
	gr.print("touched!", gr.getWidth(), gr.getHeight())
end

function love.draw()
	gr.setColor(255, 255, 255)
	gr.draw(backgroundImage, 0, 0, 0, gr.getWidth()/800, gr.getHeight()/600)

	if gamestate == "startmenu" then
		loveframes.draw()
		gr.draw(logoImage, (gr.getWidth()-logoImage:getWidth())/2, 70)
		gr.setFont(fontfont)
		gr.print("Highscore: "..p.highscore, 255, (gr.getHeight()-270)/2)
		gr.setFont(defaultFont)
		gr.printf("Copyright © 2014 Abdul Sami Farrukh (Sam Storms) - All Rights Reserved. MCN: CUP4T-2HZJY-JWLZH", 0, gr.getHeight()-50, gr.getWidth(), "center")
		gr.printf("Distributed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License", 0, gr.getHeight()-30, gr.getWidth(), "center")
	elseif gamestate == "gameover" then
		gameoverMusic:stop()
		loveframes.SetState("gameover")
		loveframes.draw()
		gr.setFont(fontfont)
		gr.draw(gameoverImage, (gr.getWidth()-gameoverImage:getWidth())/2, 100)
		gr.printf("Tacky ate you :(", 0, 200, gr.getWidth(), "center")
		gr.printf("Your score: "..p.score, 0, 250, gr.getWidth(), "center")
		gr.printf("Highscore: "..p.highscore, 0, 280, gr.getWidth(), "center")
	elseif gamestate == "help" then
		gr.setFont(fontfont)
		gr.printf("Help Packy eat the food before his naughty twin brother Tacky eats it all!", 0, 140, gr.getWidth(), "center")
		gr.printf("Use WASD or Arrow keys to move Packy.", 0, 190, gr.getWidth(), "center")
		gr.printf("Eat the little red noms that appear before Tacky eats them.", 0, 220, gr.getWidth(), "center")
		gr.printf("If you eat a nom, your score will increase. If Tacky eats a nom, your score will decrease.", 0, 260, gr.getWidth(), "center")
		gr.printf("If Tacky eats you, its game over.", 0, 310, gr.getWidth(), "center")
		gr.printf("Press Esc or the P key to pause the game.", 0, 360, gr.getWidth(), "center")
		loveframes.draw()
	elseif gamestate == "credits" then
		gr.setFont(fontfont)
		gr.printf("Developed by Abdul Sami Farrukh (about.me/SamStorms)", 0, 140, gr.getWidth(), "center")
		gr.printf("Love Frames library by Nikolai Resokav (NikolaiResokav.com)", 0, 180, gr.getWidth(), "center")
		gr.printf("Animations and Love library by Bartbes (love2d.org/wiki/User:Bartbes)", 0, 220, gr.getWidth(), "center")
		gr.printf("Powered by LÖVE2D (love2d.org)", 0, 260, gr.getWidth(), "center")
		gr.printf("Special Thanks to Eamonn Rea for the idea (about.me/eamodev)", 0, 300, gr.getWidth(), "center")
		loveframes.draw()
	elseif gamestate == "paused" then
		loveframes.draw()
	elseif gamestate == "playing" then
		if mute == false then playingBgm:play() end
		deltaTime = love.timer.getTime()
		gr.setColor(0, 0, 255)
		gr.rectangle("fill", 0, 0, gr.getWidth(), 28)
		gr.setColor(255, 255, 255)
		gr.setFont(fontfont)
		gr.print("Score: "..o.score, 5, 0)
		gr.print("Highscore: "..o.highscore, gr.getWidth()-160, 0)
		gr.setColor(255,255,0)
		gr.line(0, 28, gr.getWidth(), 28)
		nom:draw()

		gr.setColor(255, 255, 255)
		if o.facing == "left" then
			animLeft:draw(p.x, p.y)
		end

		if o.facing == "right" then
			animRight:draw(p.x, p.y)
		end

		if o.facing == "up" then
			animUp:draw(p.x, p.y)
		end

		if o.facing == "down" then
			animDown:draw(p.x, p.y)
		end

		gr.setColor(255, 150, 0)
		if en.facing == "left" then
			enemyFacingLeft:draw(en.x, en.y)
		end
		if en.facing == "right" then
			enemyFacingRight:draw(en.x, en.y)
		end
	end

end

function love.quit()
	fs.write("scores.lua", "p.highscore\n=\n"..p.highscore)
end

function love.keypressed(key)
	if gamestate == "playing" and (key == "p" or key == "escape") then
		playingBgm:pause()
		gamestate = "paused"
		loveframes.SetState("paused")
	elseif gamestate == "paused" and (key == "p" or key == "escape") then
		gamestate = "playing"
		loveframes.SetState("playing")
	end
	
	loveframes.keypressed(key)
end

function love.keyreleased(key)
	loveframes.keyreleased(key)
end

function love.mousepressed(x, y, button)
	loveframes.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	loveframes.mousereleased(x, y, button)
end