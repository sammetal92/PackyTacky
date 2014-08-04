function saveSS()
	local file = io.open (fs.getSaveDirectory() .. "/score.png", "rb")
	local inp = file:read("*a")
	file:close()

	local outfile = io.open("score.png", "wb")
	outfile:write(inp)
	outfile:close()
end

function render_menu()
	--MAIN MENU

	local muteButton = loveframes.Create("imagebutton")
	muteButton:SetSize(100, 30)
	muteButton:SetImage("img/muteButton.png")
	muteButton:SetPos(5, 5)
	muteButton:SetState("startmenu")
	muteButton:SetText("")
	muteButton.OnClick = function()
		if mute == false then
			mute = true
			menuMusic:stop()
		else
			mute = false
			menuMusic:play()
		end
	end

	local startButton = loveframes.Create("imagebutton")
	startButton:SetSize(150, 40)
	startButton:SetImage("img/playButton.png")
	startButton:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()-160)/2)
	startButton:SetState("startmenu")
	startButton:SetText("")
	startButton.OnClick = function()
		p.score = 0
		p:spawnAgain()
		f:respawn()
		en:newGame()
		gamestate = "playing"
		loveframes.SetState("playing")
		menuMusic:stop()
	end

	local instructButton = loveframes.Create("imagebutton")
	instructButton:SetSize(150, 40)
	instructButton:SetImage("img/instButton.png")
	instructButton:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()-40)/2)
	instructButton:SetState("startmenu")
	instructButton:SetText("")
	instructButton.OnClick = function()
		gamestate = "help"
		loveframes.SetState("help")
	end

	local creditsButton = loveframes.Create("imagebutton")
	creditsButton:SetSize(150, 40)
	creditsButton:SetImage("img/creditsButton.png")
	creditsButton:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()+80)/2)
	creditsButton:SetState("startmenu")
	creditsButton:SetText("")
	creditsButton.OnClick = function()
		gamestate = "credits"
		loveframes.SetState("credits")
	end

	local quitButton = loveframes.Create("imagebutton")
	quitButton:SetSize(150, 40)
	quitButton:SetImage("img/quitButton.png")
	quitButton:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()+200)/2)
	quitButton:SetState("startmenu")
	quitButton:SetText("")
	quitButton.OnClick = function()
		love.event.quit()
	end

	local resetHSButton = loveframes.Create("imagebutton")
	resetHSButton:SetSize(100, 30)
	resetHSButton:SetImage("img/resetButton.png")
	resetHSButton:SetPos(gr.getWidth()/2 + 35, gr.getHeight()/4 + 15) 
	resetHSButton:SetState("startmenu")
	resetHSButton:SetText("")
	resetHSButton.OnClick = function()
		p.score = 0
		p.highscore = 0
		fs.write("scores.lua", "p.highscore\n=\n0")
	end

	--PAUSE MENU

	local muteButtonP = loveframes.Create("imagebutton")
	muteButtonP:SetSize(100, 30)
	muteButtonP:SetImage("img/muteButton.png")
	muteButtonP:SetPos(5, 5)
	muteButtonP:SetState("paused")
	muteButtonP:SetText("")
	muteButtonP.OnClick = function()
		if mute == false then
			mute = true
		else
			mute = false
		end
	end

	local resumeButton = loveframes.Create("imagebutton")
	resumeButton:SetSize(150, 40)
	resumeButton:SetImage("img/resumeButton.png")
	resumeButton:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()-160)/2)
	resumeButton:SetState("paused")
	resumeButton:SetText("")
	resumeButton.OnClick = function()
		loveframes.SetState("playing")
		gamestate = "playing"
	end

	local backButton = loveframes.Create("imagebutton")
	backButton:SetSize(150, 40)
	backButton:SetImage("img/backButton.png")
	backButton:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()-40)/2)
	backButton:SetState("paused")
	backButton:SetText("")
	backButton.OnClick = function()
		loveframes.SetState("startmenu")
		gamestate = "startmenu"
		playingBgm:stop()
		if mute == false then menuMusic:play() end
	end

	local quitButtonP = loveframes.Create("imagebutton")
	quitButtonP:SetSize(150, 40)
	quitButtonP:SetImage("img/quitPButton.png")
	quitButtonP:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()+80)/2)
	quitButtonP:SetState("paused")
	quitButtonP:SetText("")
	quitButtonP.OnClick = function()
		love.event.quit()
	end

	--CREDITS MENU AND INFO MENU

	local backButtonC = loveframes.Create("imagebutton")
	backButtonC:SetSize(150, 40)
	backButtonC:SetImage("img/backButton.png")
	backButtonC:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()+160)/2)
	backButtonC:SetState("credits")
	backButtonC:SetText("")
	backButtonC.OnClick = function()
		loveframes.SetState("startmenu")
		gamestate = "startmenu"
	end

	local backButtonI = loveframes.Create("imagebutton")
	backButtonI:SetSize(150, 40)
	backButtonI:SetImage("img/backButton.png")
	backButtonI:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()+220)/2)
	backButtonI:SetState("help")
	backButtonI:SetText("")
	backButtonI.OnClick = function()
		loveframes.SetState("startmenu")
		gamestate = "startmenu"
	end

	--GAME OVER MENU

	local tryAgainButton = loveframes.Create("imagebutton")
	tryAgainButton:SetSize(150, 40)
	tryAgainButton:SetImage("img/tryButton.png")
	tryAgainButton:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()+80)/2)
	tryAgainButton:SetState("gameover")
	tryAgainButton:SetText("")
	tryAgainButton.OnClick = function()
		p:spawnAgain()
		p.score = 0
		f:respawn()
		e:newGame()
		gamestate = "playing"
		loveframes.SetState("playing")
		menuMusic:stop()
	end

	local screenshotButton = loveframes.Create("imagebutton")
	screenshotButton:SetSize(150, 40)
	screenshotButton:SetImage("img/screenshot.png")
	screenshotButton:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()+200)/2)
	screenshotButton:SetState("gameover")
	screenshotButton:SetText("")
	screenshotButton.OnClick = function()
		screenshot = gr.newScreenshot(false)
		screenshot:encode("score.png","png")
		local frame = loveframes.Create("frame")
		frame:SetName("Screenshot saved")
		frame:SetSize(410, 80)
		frame:SetState("gameover")
		frame:SetPos((gr.getWidth()-410)/2, (gr.getHeight()-130)/2)

		saveSS()

		local text = loveframes.Create("text", frame)
		text:SetText("Screenshot saved as \"score.png\" in the game directory")
		text:SetPos(10, 30)
	end

	local backButtonG = loveframes.Create("imagebutton")
	backButtonG:SetSize(150, 40)
	backButtonG:SetImage("img/backButton.png")
	backButtonG:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()+320)/2)
	backButtonG:SetState("gameover")
	backButtonG:SetText("")
	backButtonG.OnClick = function()
		p:spawnAgain()
		en:newGame()
		gamestate = "startmenu"
		loveframes.SetState("startmenu")
		if mute == false then menuMusic:play() end
	end
end