function render_menu()
	--MAIN MENU

	local startButton = loveframes.Create("button")
	startButton:SetSize(150, 40)
	startButton:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()-160)/2)
	startButton:SetState("startmenu")
	startButton:SetText("Play")
	startButton.OnClick = function()
		p.score = 0
		p:spawnAgain()
		f:respawn()
		gamestate = "playing"
		loveframes.SetState("playing")
		menuMusic:stop()
	end

	local instructButton = loveframes.Create("button")
	instructButton:SetSize(150, 40)
	instructButton:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()-40)/2)
	instructButton:SetState("startmenu")
	instructButton:SetText("Instructions")
	instructButton.OnClick = function()
		gamestate = "help"
		loveframes.SetState("help")
	end

	local quitButton = loveframes.Create("button")
	quitButton:SetSize(150, 40)
	quitButton:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()+80)/2)
	quitButton:SetState("startmenu")
	quitButton:SetText("Credits")
	quitButton.OnClick = function()
		gamestate = "credits"
		loveframes.SetState("credits")
	end

	local quitButton = loveframes.Create("button")
	quitButton:SetSize(150, 40)
	quitButton:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()+200)/2)
	quitButton:SetState("startmenu")
	quitButton:SetText("Quit")
	quitButton.OnClick = function()
		love.event.quit()
	end

	local resetHSButton = loveframes.Create("button")
	resetHSButton:SetSize(90, 25)
	resetHSButton:SetPos(gr.getWidth() - 95, 5)
	resetHSButton:SetState("startmenu")
	resetHSButton:SetText("Reset Highscore")
	resetHSButton.OnClick = function()
		p.highscore = 0
	end

	--PAUSE MENU

	local resumeButton = loveframes.Create("button")
	resumeButton:SetSize(150, 40)
	resumeButton:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()-160)/2)
	resumeButton:SetState("paused")
	resumeButton:SetText("Resume Game")
	resumeButton.OnClick = function()
		loveframes.SetState("playing")
		gamestate = "playing"
	end

	local backButton = loveframes.Create("button")
	backButton:SetSize(150, 40)
	backButton:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()-40)/2)
	backButton:SetState("paused")
	backButton:SetText("Back To Main Menu")
	backButton.OnClick = function()
		loveframes.SetState("startmenu")
		gamestate = "startmenu"
		playingBgm:stop()
		menuMusic:play()
	end

	local quitButtonP = loveframes.Create("button")
	quitButtonP:SetSize(150, 40)
	quitButtonP:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()+80)/2)
	quitButtonP:SetState("paused")
	quitButtonP:SetText("Quit")
	quitButtonP.OnClick = function()
		love.event.quit()
	end

	--CREDITS MENU AND INFO MENU

	local backButtonC = loveframes.Create("button")
	backButtonC:SetSize(150, 40)
	backButtonC:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()+160)/2)
	backButtonC:SetState("credits")
	backButtonC:SetText("Back To Main Menu")
	backButtonC.OnClick = function()
		loveframes.SetState("startmenu")
		gamestate = "startmenu"
	end

	local backButtonI = loveframes.Create("button")
	backButtonI:SetSize(150, 40)
	backButtonI:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()+220)/2)
	backButtonI:SetState("help")
	backButtonI:SetText("Back To Main Menu")
	backButtonI.OnClick = function()
		loveframes.SetState("startmenu")
		gamestate = "startmenu"
	end

	--GAME OVER MENU

	local backButtonG = loveframes.Create("button")
	backButtonG:SetSize(150, 40)
	backButtonG:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()+200)/2)
	backButtonG:SetState("gameover")
	backButtonG:SetText("Back To Main Menu")
	backButtonG.OnClick = function()
		p:spawnAgain()
		e:newGame()
		gamestate = "startmenu"
		loveframes.SetState("startmenu")
		menuMusic:play()
	end

	local tryAgainButton = loveframes.Create("button")
	tryAgainButton:SetSize(150, 40)
	tryAgainButton:SetPos((gr.getWidth()-150)/2 , (gr.getHeight()+80)/2)
	tryAgainButton:SetState("gameover")
	tryAgainButton:SetText("Try Again")
	tryAgainButton.OnClick = function()
		p:spawnAgain()
		p.score = 0
		f:respawn()
		e:newGame()
		gamestate = "playing"
		loveframes.SetState("playing")
		menuMusic:stop()
	end
end